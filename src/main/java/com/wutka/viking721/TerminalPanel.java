package com.wutka.viking721;

import com.codingrodent.microprocessor.IBaseDevice;
import com.codingrodent.microprocessor.IMemory;
import com.codingrodent.microprocessor.Z80.CPUConstants;
import com.codingrodent.microprocessor.Z80.Z80Core;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayDeque;
import java.util.Deque;

public class TerminalPanel extends JPanel implements Runnable, IMemory, IBaseDevice, InterruptBus {
    Memory[] banks;
    Memory[] blocks;
    int [][]blockBanks;
    byte[] charmap;
    byte[] portData = new byte[256];
    public static final int VIDEO_RAM = 0xe000;
    long lastBlinkTime;
    boolean blinkOn = false;
    public static final long blinkInterval = 1000;
    Color dimGreen = new Color(0, 128, 0);
    Z80Core z80;
    boolean writeToVideoRam;
    int pendingInterrupts;
    InputStream connIn;
    OutputStream connOut;
    VikingQueue keyboardQueue;
    VikingQueue sendQueue;
    VikingQueue receiveQueue;

    Deque<Byte> keyboardData;
    Deque<Byte> sendData;
    Deque<Byte> receiveData;

    boolean initialized;

    public TerminalPanel() {
        try {
            banks = new Memory[15];
            banks[0] = createBankFromFile("resident.bin", 0x4000);
            banks[1] = createBank(0x4000);
            banks[2] = createBank(0x4000);
            banks[3] = createBank(0x4000);
            banks[4] = createBank(0x4000);
            banks[5] = createBank(0x4000, true);
            banks[6] = createBank(0x4000);
            banks[7] = createBank(0x4000);
            banks[8] = createBank(0x4000);
            banks[9] = createBank(0x4000, true);
            banks[10] = null;
            banks[11] = createBank(0x4000);
            banks[12] = createBank(0x4000);
            banks[13] = createBankFromFile("16krom.bin", 0x4000);
            banks[14] = createBank(0x4000);

            blocks = new Memory[4];
            blocks[0] = banks[0];
            blocks[1] = banks[6];
            blocks[2] = banks[5];
            blocks[3] = banks[4];

            blockBanks = new int[][] {
                    new int[] { 0, 7, 1, 14},
                    new int[] { 6, 8, 13, 2},
                    new int[] { 5, 3, 11, 9},
                    new int[] { 4, 6, 12, 9}
            };
            charmap = Files.readAllBytes(Path.of("chargen.bin"));
            lastBlinkTime = System.currentTimeMillis();

            pendingInterrupts = 0;

            keyboardQueue = new VikingQueue(0xe089, 0xe08a, 0xe08c,
                   0xdb10, 16);
            sendQueue = new VikingQueue(0xe08e, 0xe08f, 0xe091,
                          0xdf00, 192);
            receiveQueue = new VikingQueue(0xe083, 0xe085, 0xe087,
                    0xdb20, 992);

            keyboardData = new ArrayDeque<>();
            receiveData = new ArrayDeque<>();
            sendData = new ArrayDeque<>();

            z80 = new Z80Core(this, this);

            (new Thread(this)).start();

            writeToVideoRam = false;


        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    public Memory createBankFromFile(String filename, int bankSize) {
        try {
            byte[] data = Files.readAllBytes(Path.of(filename));
            if (data.length < bankSize) {
                byte[] newData = new byte[bankSize];
                System.arraycopy(data, 0, newData, 0, data.length);
                data = newData;
            }
            return new Memory(data, true);
        } catch (Exception exc) {
            System.err.println("Error loading ROM file: "+filename);
            exc.printStackTrace();
            return null;
        }
    }

    public Memory createBank(int bankSize) {
        return createBank(bankSize, false);
    }

    public Memory createBank(int bankSize, boolean readOnly) {
        return new Memory(new byte[bankSize], readOnly);
    }

    @Override
    public Dimension getPreferredSize() {
        return new Dimension(800, 600);
    }

    @Override
    protected void paintComponent(Graphics g) {
        try {
            super.paintComponent(g);
            g.setColor(Color.BLACK);
            g.fillRect(0, 0, getWidth(), getHeight());
            g.setColor(Color.GREEN);

            int outY = 1;
            for (int row = 0; row < 30; row++) {
//                System.out.printf("Y %02d Row %02d: ", outY, row);
                int videoOffset = (readByte(VIDEO_RAM + row * 2)&0xff) | ((readByte(VIDEO_RAM + row * 2 + 1)&0xff) << 8);

                for (int scanlineRow = 0; scanlineRow < 15; scanlineRow++) {
                    int x = 1;
                    for (int col = 0; col < 80; col++) {
                        int chr = readByte(VIDEO_RAM + ((col * 2 + videoOffset) & 0x1fff)) & 0xff;
//                        if (scanlineRow == 0) {
//                            System.out.printf("%c", chr);
//                        }
//                    System.out.printf("Video char: %02x at %04x\n", chr, VIDEO_RAM + ((col * 2 + videoOffset) & 0x1fff));
                        int attr = readByte(VIDEO_RAM + ((col * 2 + 1 + videoOffset) & 0x1fff)) & 0xff;
                        int bits = charmap[chr | (scanlineRow << 8)];
                        boolean draw = true;
                        boolean dim = false;
                        if ((attr & 1) != 0) {
                            draw = false;
                        } else if (((attr & 2) != 0) && (scanlineRow == 14)) {
                            bits = 0xff;
                        } else if ((attr & 4) != 0) {
                            bits = (bits ^ 0xff) & 0xff;
                        } else if ((attr & 8) != 0) {
                            if (System.currentTimeMillis() + blinkInterval > lastBlinkTime) {
                                blinkOn = !blinkOn;
                            }
                            if (!blinkOn) {
                                bits = 0;
                            }
                        } else if ((attr & 16) != 0) {
                            dim = true;
                        }
                        if (dim) {
                            g.setColor(dimGreen);
                        } else if (!draw) {
                            g.setColor(Color.BLACK);
                        } else {
                            g.setColor(Color.GREEN);
                        }
                        for (int b = 0; b < 8; b++) {
                            if (draw) {
                                if ((bits & (1 << b)) != 0) {
                                    g.drawLine(x + b, outY, x + b, outY);
                                }
                            } else {
                                g.drawLine(x + b, outY, x + b, outY);
                            }
                        }
                        x+=8;
                    }
//                    if (scanlineRow == 0) {
//                        System.out.println();
//                    }

                    outY++;
                }

            }
        }
        catch (Exception exc) {
            exc.printStackTrace(System.out);
            System.out.flush();
            try { Thread.sleep(1000); } catch (Exception ignore) {}
            System.exit(0);
        }
    }

    @Override
    public int IORead(int address) {
        address = address & 0xff;
        if (address == 0x46) {
            return 0xb0;
        }
        return portData[address] & 0xff;
    }

    @Override
    public void IOWrite(int address, int data) {
        address = address & 0xff;
        data = data & 0xff;

        if (address == 0x70) {
            for (int blockNum = 0; blockNum < 4; blockNum++) {
                blocks[blockNum] = banks[blockBanks[blockNum][data & 3]];
                data = data >> 2;
            }
        } else {
            portData[address] = (byte) data;
        }
    }

    @Override
    public int readByte(int address) {
        address = address & 0xffff;
        if (address == 0xe0fe) {
            return 7;
        } else if (initialized && (address == 0xe0ae)) {
            return 0xff;
        } else if (initialized && (address == 0xe0f0)) {
            return 1;
        } else if (initialized && (address == 0xe0f7)) {
            return 0;
        } else if ((address >= 0xe093) && (address <= 0xe09e)) {
            return 0x00;
        }
        Memory block = blocks[address >> 14];
        return block.getData(address & 0x3fff);
    }

    @Override
    public int readWord(int address) {
        int b1, b2;
        b1 = readByte(address);
        b2 = readByte(address+1);
        return b1 + (b2 << 8);
    }

    @Override
    public void writeByte(int address, int data) {
        address = address & 0xffff;
        data = data & 0xff;
        Memory block = blocks[address >> 14];
        block.putData(address & 0x3fff, data);
        if ((address >= 0xe110) && (address <= 0xffff)) {
//           System.out.printf("Write %02x to video ram at %04x\n", value, address & 0xffff);
            writeToVideoRam = true;
        }
    }

    @Override
    public void writeWord(int address, int data) {
        address = address & 0xffff;
        data = data & 0xffff;
        writeByte(address, data & 0xff);
        writeByte(address+1, (data >> 8) & 0xff);
    }

    @Override
    public void run() {
        try {
            z80.setRegisterValue(CPUConstants.RegisterNames.IX, 0xffff);
            z80.setRegisterValue(CPUConstants.RegisterNames.IY, 0xffff);
            z80.setRegisterValue(CPUConstants.RegisterNames.F, 0x40);
            z80.setRegisterValue(CPUConstants.RegisterNames.F_ALT, 0x80);

            long lastTicks = z80.getTStates();

            for (;;) {
                /*
                if (initialized) {
                    System.out.printf("PC:%04x OP: %02x  Flags: %02x  A: %02x  B: %02x  C: %02x  D: %02x  E: %02x  H: %02x  L: %02x  IX: %04x  IY: %04x  SP: %04x  SF: %02x\n",
                            z80.getRegisterValue(CPUConstants.RegisterNames.PC),
                            readByte(z80.getRegisterValue(CPUConstants.RegisterNames.PC)),
                            z80.getRegisterValue(CPUConstants.RegisterNames.F),
                            z80.getRegisterValue(CPUConstants.RegisterNames.A),
                            (z80.getRegisterValue(CPUConstants.RegisterNames.BC) >> 8) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.BC) & 0xff,
                            (z80.getRegisterValue(CPUConstants.RegisterNames.DE) >> 8) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.DE) & 0xff,
                            (z80.getRegisterValue(CPUConstants.RegisterNames.HL) >> 8) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.HL) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.IX),
                            z80.getRegisterValue(CPUConstants.RegisterNames.IY),
                            z80.getRegisterValue(CPUConstants.RegisterNames.SP),
                            z80.getRegisterValue(CPUConstants.RegisterNames.F_ALT) & 0xff
                    );
                }
                 */

                /*
                if (pendingInterrupts != 0) {
                    z80.setIRQ(true);
                } else {
                    z80.setIRQ(false);
                }
                 */

                synchronized (keyboardData) {
                    while (keyboardQueueSafe() && !keyboardData.isEmpty() && keyboardQueue.canAccept()) {
                        byte b = keyboardData.remove();
                        keyboardQueue.put(b);
                    }
                }

                boolean newCommData = false;
                synchronized (receiveData) {
                    while (receiveQueueSafe() && !receiveData.isEmpty() && receiveQueue.canAccept()) {
                        byte b = receiveData.remove();
                        receiveQueue.put(b);
                        newCommData = true;
                    }
                }

                synchronized (sendData) {
                    while (sendQueueSafe() && sendQueue.hasData()) {
                        byte b = sendQueue.get();
                        sendData.add(b);
                    }
                }

                z80.setIRQ(newCommData);
                newCommData = false;

                boolean showPC = false;
                int pc = z80.getProgramCounter() & 0xffff;

                if (pc == 0x2946) {
                    System.out.printf("Returning from 2946\n");
                    showPC = true;
                } else if (pc == 0x1f11) {
                    System.out.printf("Processing char from comm buffer %04x\n", pc);
                } else if (pc == 0x2db3) {
                    System.out.printf("At %04x\n", pc);
                }

                z80.executeOneInstruction();

                pc = z80.getProgramCounter() & 0xffff;
                if (showPC) {
                    System.out.printf("PC is now %04x\n", pc);
                }

//                if ((pc >= 0x2925) && (pc <= 0x2946)) {
                if (initialized) {
                    System.out.printf("PC:%04x OP: %02x  Flags: %02x  A: %02x  B: %02x  C: %02x  D: %02x  E: %02x  H: %02x  L: %02x  IX: %04x  IY: %04x  SP: %04x  SF: %02x\n",
                            z80.getRegisterValue(CPUConstants.RegisterNames.PC),
                            readByte(z80.getRegisterValue(CPUConstants.RegisterNames.PC)),
                            z80.getRegisterValue(CPUConstants.RegisterNames.F),
                            z80.getRegisterValue(CPUConstants.RegisterNames.A),
                            (z80.getRegisterValue(CPUConstants.RegisterNames.BC) >> 8) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.BC) & 0xff,
                            (z80.getRegisterValue(CPUConstants.RegisterNames.DE) >> 8) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.DE) & 0xff,
                            (z80.getRegisterValue(CPUConstants.RegisterNames.HL) >> 8) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.HL) & 0xff,
                            z80.getRegisterValue(CPUConstants.RegisterNames.IX),
                            z80.getRegisterValue(CPUConstants.RegisterNames.IY),
                            z80.getRegisterValue(CPUConstants.RegisterNames.SP),
                            z80.getRegisterValue(CPUConstants.RegisterNames.F_ALT) & 0xff
                    );
                }
//                if (!initialized && pc == 0x4781) {
                if (!initialized && pc == 0x3d49) {
                    Socket sock = new Socket("localhost", 6610);
                    connIn = sock.getInputStream();
                    connOut = sock.getOutputStream();

                    (new Thread(new CommSender())).start();
                    (new Thread(new CommReceiver())).start();

                    setFocusable(true);
                    requestFocusInWindow();
                    addKeyListener(new KeyHandler());

                    initialized = true;
                    z80.setIRQ(true);
                }
                if (writeToVideoRam) {
                    this.validate();
                    this.repaint();
                    writeToVideoRam = false;
                }
            }
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    @Override
    public int getINTACK() {
        for (int i=0; i < 8; i++) {
            if ((pendingInterrupts & (1 << i)) != 0) {
                pendingInterrupts -= (1 << i);
                return i * 2;
            }
        }
        return 0;
    }

    @Override
    public void setInterruptLine(int line) {
        pendingInterrupts |= (1 << line);
    }

    @Override
    public void clearInterruptLine(int line) {
        if ((pendingInterrupts & (1 << line)) != 0) {
            pendingInterrupts -= (1 << line);
        }
    }

    public boolean keyboardQueueSafe() {
        if (!initialized) return false;
        int pc = z80.getProgramCounter() & 0xffff;
        return !(((pc >= 0x6cc) && (pc <= 0x6e9)) ||
                 ((pc >= 0x292c) && (pc <= 0x2945)) ||
                (pc == 0x2dca) ||
                (pc == 0x44fd) ||
                (pc == 0x45fd) ||
                (pc == 0x4f73));

    }

    public boolean receiveQueueSafe() {
        if (!initialized) return false;
        int pc = z80.getProgramCounter() & 0xffff;
        return !((pc == 0x66f) ||
                ((pc >= 0x684) && (pc <= 0x694)) ||
                ((pc >= 0x1ef8) && (pc <= 0x1f0d)) ||
                (pc == 0x2db9) ||
                (pc == 0x4eff));

    }

    public boolean sendQueueSafe() {
        if (!initialized) return false;
        int pc = z80.getProgramCounter() & 0xffff;
        return ! ((pc == 0x170c) ||
                (pc == 0x2925) ||
                (pc == 0x2dd1) ||
                (pc == 0x3087) ||
                ((pc >= 0x30f8) && (pc <= 0x3111)) ||
                ((pc >= 0x315f) && (pc <= 0x3173)) ||
                (pc == 0x318d) ||
                (pc == 0x4f29));
    }

    class KeyHandler implements KeyListener {
        @Override
        public void keyTyped(KeyEvent keyEvent) {
            synchronized (keyboardData) {
                if ((keyEvent.getKeyChar() == 0x0a) || (keyEvent.getKeyChar() == 0x0d)) {
                    keyboardData.add((byte)0x66);
                } else {
                    keyboardData.add((byte) keyEvent.getKeyChar());
                }
            }
        }

        @Override
        public void keyPressed(KeyEvent keyEvent) {
        }

        @Override
        public void keyReleased(KeyEvent keyEvent) {

        }
    }

    class CommReceiver implements Runnable {
        public void run() {
            try {
                byte[] buff = new byte[1];
                for (;;) {
                    int n = connIn.read(buff);
                    if (n <= 0) {
                        System.out.printf("Connection closed");
                        return;
                    }
                    synchronized (receiveData) {
                        receiveData.add(buff[0]);
                    }
                }
            } catch (Exception exc) {
                exc.printStackTrace();
            }
        }
    }

    class CommSender implements Runnable {
        public void run() {
            try {
                byte[] buff = new byte[1];

                for (;;) {
                    boolean send = false;
                    synchronized (sendData) {
                        if (!sendData.isEmpty()) {
                            buff[0] = sendData.remove();
                            send = true;
                        }
                    }

                    if (send) {
                        System.out.printf("Sending %02x\n", buff[0]);
                        connOut.write(buff);
                    } else {
                        Thread.sleep(100);
                    }
                }
            } catch (Exception exc) {
                exc.printStackTrace();
            }
        }
    }

    class VikingQueue {
        int queueCountAddr;
        int queueSlotAddr;
        int queueTakeAddr;
        int queueAddr;
        int queueSize;

        VikingQueue(int queueCountAddr, int queueSlotAddr, int queueTakeAddr, int queueAddr, int queueSize) {
            this.queueCountAddr = queueCountAddr;
            this.queueSlotAddr = queueSlotAddr;
            this.queueTakeAddr = queueTakeAddr;
            this.queueAddr = queueAddr;
            this.queueSize = queueSize;
        }

        public int readNumVals() {
            int numVals = 0;
            if (queueSize > 256) {
                numVals = readWord(queueCountAddr) & 0xffff;
            } else {
                numVals = readByte(queueCountAddr) & 0xff;
            }
            return numVals;
        }

        public void writeNumVals(int numVals) {
            if (queueSize > 256) {
                writeWord(queueCountAddr, numVals & 0xffff);
            } else {
                writeByte(queueCountAddr, numVals & 0xff);
            }
        }

        public boolean hasData() {
            return readNumVals() > 0;
        }

        public boolean canAccept() {
            return readNumVals() < queueSize;
        }

        public byte get() {
            if (!hasData()) return 0;
            int buffAddr = readWord(queueTakeAddr);
            int b = readByte(buffAddr) & 0xff;
            buffAddr++;
            if (buffAddr >= queueAddr + queueSize) {
                buffAddr = queueAddr;
            }
            writeWord(queueTakeAddr, buffAddr);
            writeNumVals(readNumVals()-1);
            return (byte) (b & 0xff);
        }

        public void put(byte val) {
            if (!canAccept()) return;
            int buffAddr = readWord(queueSlotAddr);
            writeByte(buffAddr, val);
            buffAddr++;
            if (buffAddr >= queueAddr + queueSize) {
                buffAddr = queueAddr;
            }
            writeWord(queueSlotAddr, buffAddr);
            writeNumVals(readNumVals()+1);
        }
    }
}
