package com.wutka.viking721;

import com.codingrodent.microprocessor.IBaseDevice;
import com.codingrodent.microprocessor.IMemory;
import com.codingrodent.microprocessor.Z80.CPUConstants;
import com.codingrodent.microprocessor.Z80.Z80Core;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class TerminalPanel extends JPanel implements Runnable, IMemory, IBaseDevice, InterruptBus {
    Memory[] banks;
    Memory[] blocks;
    int[] currBlockBanks;
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
    Uart8250 commUart;
    Uart8250 kbdUart;
    Timer[] timers;
    boolean connected;
    boolean ready;

    BlockingQueue<Integer> txQueue = new ArrayBlockingQueue<>(256);
    BlockingQueue<Integer> rxQueue = new ArrayBlockingQueue<>(256);
    BlockingQueue<Integer> kbQueue =  new ArrayBlockingQueue<>(256);

    boolean debug;
    Debugger debugger;

    public TerminalPanel(boolean debug) {
        try {
            this.debug = debug;
            banks = new Memory[15];
            banks[0] = createBankFromFile("resident.bin", 0x4000, true);
            banks[1] = createBank(0x4000);
            banks[2] = createBank(0x4000);
            banks[3] = createBank(0x4000);
            banks[4] = createBank(0x4000);
            banks[5] = createBankFromFile("gfxfw.rom", 0x4000, true);
            banks[6] = createBank(0x4000);
            banks[7] = createBank(0x4000, false);
            banks[8] = createBank(0x4000, false);
            banks[9] = createBank(0x4000);
            banks[10] = null;
            banks[11] = createBank(0x4000);
            banks[12] = createBank(0x4000);
            banks[13] = createBankFromFile("16krom.bin", 0x4000, true);
            banks[14] = createBank(0x4000);

            try {
                byte[] nvram = Files.readAllBytes(Path.of("nvram.bin"));
                System.arraycopy(nvram, 0, banks[6].data, 0, nvram.length);
            } catch (IOException exc) {
                System.out.println("Unable to read nvram.bin: "+exc.getMessage());
            }
            blocks = new Memory[4];
            blocks[0] = banks[0];
            blocks[1] = banks[6];
            blocks[2] = banks[5];
            blocks[3] = banks[4];

            currBlockBanks = new int[] { 0, 6, 5, 4};

            blockBanks = new int[][] {
                    new int[] { 0, 9, 1, 14},
                    new int[] { 6, 10, 13, 2},
                    new int[] { 5, 3, 11, 7},
                    new int[] { 4, 6, 12, 8}
            };
            charmap = Files.readAllBytes(Path.of("chargen.bin"));
            lastBlinkTime = System.currentTimeMillis();

            pendingInterrupts = 0;

            z80 = new Z80Core(this, this);
            if (debug) {
                this.debugger = new Debugger(z80, this, banks, currBlockBanks, this);
            }

            commUart = new Uart8250("comm", this, 0, rxQueue, txQueue);
            kbdUart = new Uart8250("kbd", this, 5, kbQueue, null);

            timers = new Timer[] {
                    new Timer(this, 6),
                            new Timer(this, 6),
                            new Timer(this, 6),
                            new Timer(this, 6)
            };

            (new Thread(this)).start();

            writeToVideoRam = false;
            ready = false;
//            connect("localhost", 23);

        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    public KeyListener getKeyListener() {
        return new KeyHandler();
    }
    public Memory createBankFromFile(String filename, int bankSize, boolean readOnly) {
        try {
            byte[] data = Files.readAllBytes(Path.of(filename));
            if (data.length < bankSize) {
                byte[] newData = new byte[bankSize];
                System.arraycopy(data, 0, newData, 0, data.length);
                data = newData;
            }
            return new Memory(data, readOnly);
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
                int videoOffset = (readByte(VIDEO_RAM + row * 2)&0xff) | ((readByte(VIDEO_RAM + row * 2 + 1)&0xff) << 8);

                for (int scanlineRow = 0; scanlineRow < 15; scanlineRow++) {
                    int x = 1;
                    for (int col = 0; col < 80; col++) {
                        int chr = readByte(VIDEO_RAM + ((col * 2 + videoOffset) & 0x1fff)) & 0xff;
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
        if (address >= 0x40 && address <= 0x47) {
            int result = commUart.readRegister(address - 0x40);
            return result & 0xff;
        } else if (address >= 0x20 && address <= 0x27) {
            int result = kbdUart.readRegister(address - 0x20);
            return result & 0xff;
        } else if (address >= 0 && address < 4) {
            return timers[address].readRegister();
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
                currBlockBanks[blockNum] = blockBanks[blockNum][data & 3];
                data = data >> 2;
            }
        } else if (address >= 0x40 && address <= 0x47) {
//            System.out.printf("Writing %02x to commUART reg %1d at pc = %04x\n",
//                    data, address - 0x40, z80.getProgramCounter());
            commUart.writeRegister(address - 0x40, data);
        } else if (address >= 0x20 && address <= 0x27) {
//            System.out.printf("Writing %02x to kbdUART reg %1d at pc = %04x\n",
//                    data, address - 0x20, z80.getProgramCounter());
            kbdUart.writeRegister(address - 0x20, data);
        } else if (address < 0x04) {
            System.out.printf("Writing %02x to timer reg %1d at pc = %04x\n",
                    data, address, z80.getProgramCounter());
            timers[address].writeRegister(data);
        } else {
            portData[address] = (byte) data;
        }
    }

    @Override
    public int readByte(int address) {
        address = address & 0xffff;
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
/*        if (currBlockBanks[address >> 14] == 6 && ((address & 0x3fff) < 0x100)) {
            System.out.printf("Truncating write to %04x\n", address);
            data = data & 0xff;
            if ((address & 0x3fff) == 0x1f) {
                data = 0x0c;
            }
        }

 */
        block.putData(address & 0x3fff, data);
        if ((address >= 0xe110) && (address <= 0xffff)) {
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
            long lastTicks = z80.getTStates();

            for (;;) {
                if (this.debug) {
                    this.debugger.step();
                } else {
                    z80.executeOneInstruction();
                }
                long ticksNow = z80.getTStates();
                for (int i=0; i < 4; i++) {
                    timers[i].tick(ticksNow-lastTicks);
                }
                lastTicks = ticksNow;
                if (ready) {
                    commUart.checkTxQueue();
                    commUart.checkRxQueue();
                    kbdUart.checkRxQueue();
                } else {
                    if (z80.getProgramCounter() == 0x2925) {
//                        ready = true;
//                        connect("localhost", 23);
                    }
//                    System.out.printf("PC = %04x\n", z80.getProgramCounter());
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
                if (pendingInterrupts == 0) {
                    z80.setIRQ(false);
                }
                return i * 2;
            }
        }
        z80.setIRQ(false);
        return 0;
    }

    @Override
    public void setInterruptLine(int line) {
        pendingInterrupts |= (1 << line);
        z80.setIRQ(true);
    }

    @Override
    public void clearInterruptLine(int line) {
        if ((pendingInterrupts & (1 << line)) != 0) {
            pendingInterrupts -= (1 << line);
        }
        if (pendingInterrupts == 0) {
            z80.setIRQ(false);
        }
    }

    public void connect(String host, int port) {
        try {
            Socket sock = new Socket(host, port);
            connIn = sock.getInputStream();
            connOut = sock.getOutputStream();
            CommReceiver receiver = new CommReceiver();
            new Thread(receiver).start();
            CommSender sender = new CommSender();
            new Thread(sender).start();

        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }
    class KeyHandler implements KeyListener {
        @Override
        public void keyTyped(KeyEvent keyEvent) {
            System.out.printf("Key typed %08x\n", (int) keyEvent.getKeyChar());
            if ((keyEvent.getKeyChar() == 0x0a) || (keyEvent.getKeyChar() == 0x0d)) {
                kbQueue.offer(0x66);
            } else {
                kbQueue.offer((int) keyEvent.getKeyChar());
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
                        System.out.println("Connection closed");
                        connected = false;
                        return;
                    }
                    rxQueue.put((int)buff[0]);
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
                    buff[0] = txQueue.take().byteValue();
                    connOut.write(buff);
                }
            } catch (Exception exc) {
                exc.printStackTrace();
            }
        }
    }
}
