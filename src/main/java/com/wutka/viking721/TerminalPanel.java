package com.wutka.viking721;

import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;

public class TerminalPanel extends JPanel implements Runnable {

    public static final int ATTR_BLANK = 1;
    public static final int ATTR_UNDERLINE = 2;
    public static final int ATTR_INVERSE = 4;
    public static final int ATTR_BLINK = 8;
    public static final int ATTR_DIM = 16;
    public static final int ATTR_PROTECTED = 32;
    public static final int ATTR_MODIFIED = 64;

    byte[] charmap;
    long lastBlinkTime;
    public static final long blinkInterval = 1000;
    boolean blinkOn = false;
    boolean blinkEnabled = true;
    boolean rollEnabled = true;
    boolean underscoreChar = false;
    boolean protectChar = false;
    boolean dimChar = false;
    boolean inverseChar = false;
    boolean large = false;
    boolean bias = false;
    boolean cols132 = false;
    boolean blinkChar = false;
    boolean autotab = false;
    boolean blockMode = false;
    boolean modified = false;
    boolean autoLineFeed = false;

    Color dimGreen = new Color(0, 128, 0);
    InputStream connIn;
    OutputStream connOut;
    byte[][] screenRam;
    int rows = 30;
    int cursorRow;
    int cursorCol;


    public TerminalPanel(InputStream connIn, OutputStream connOut) {
        this.connIn = connIn;
        this.connOut = connOut;
        try {
            charmap = Files.readAllBytes(Path.of("chargen.bin"));
            lastBlinkTime = System.currentTimeMillis();
            screenRam = new byte[132*30][];
            for (int i=0; i < screenRam.length; i++) {
                screenRam[i] = new byte[2];
            }
            cursorRow = 0;
            cursorCol = 0;

            (new Thread(this)).start();

        } catch (Exception exc) {
            exc.printStackTrace();
        }
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

            int highCol = cols132 ? 132 : 80;

            for (int row = 0; row < 30; row++) {

                for (int scanlineRow = 0; scanlineRow < 15; scanlineRow++) {
                    int x = 1;
                    for (int col = 0; col < highCol; col++) {
                        byte[] cell = screenRam[row+132 + col];

                        int attr = cell[0];
                        int chr = cell[1];
                        int bits = charmap[chr | (scanlineRow << 8)];
                        boolean draw = true;
                        boolean dim = false;
                        if ((attr & ATTR_BLANK) != 0) {
                            draw = false;
                            bits = 0;
                        } else if (((attr & ATTR_UNDERLINE) != 0) && (scanlineRow == 14)) {
                            bits = 0xff;
                        } else if ((attr & ATTR_INVERSE) != 0) {
                            bits = (bits ^ 0xff) & 0xff;
                        } else if ((attr & ATTR_BLINK) != 0) {
                            if (System.currentTimeMillis() + blinkInterval > lastBlinkTime) {
                                blinkOn = !blinkOn;
                            }
                            if (blinkEnabled && !blinkOn) {
                                bits = 0;
                            }
                        } else if ((attr & ATTR_DIM) != 0) {
                            dim = true;
                        }

                        if ((row == cursorRow) && (col == cursorCol)) {
                            bits = (bits ^ 0xff) & 0xff;
                            draw = true;
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
        }
    }

    @Override
    public void run() {
        try {
            for (;;) {
                int chr = connIn.read();

                if ((large && chr == 0x02) || (!large && chr == 0x10)) {
                    int col = 0;
                    if (cols132) {
                        int expect7e = connIn.read();
                        if ((expect7e & 0xff) != 0x7e) {
                            System.out.printf("Expected 0x7e for start of write cursor address, got %02x\n",
                                    expect7e);
                            continue;
                        }
                        int colArea = connIn.read();
                        if ((bias && colArea == 0) || (!bias && colArea == 0x20)) {
                            col = connIn.read();
                            if (bias) col -= 0x20;
                        } else if ((bias && colArea == 1) || (!bias && colArea == 0x21)) {
                            col = connIn.read();
                            if (bias) col -= 0x20;
                            col += 80;
                        } else {
                            System.out.printf("Got col area value %02x in write cursor while in 132-column mode with bias = %s\n",
                                    colArea, bias);
                            continue;
                        }
                    } else {
                        col = connIn.read();
                        if (bias) col -= 0x20;
                    }
                    int row = connIn.read();
                    if (bias) row -= 0x20;
                    cursorCol = col;
                    cursorRow = row;
                    requestScreenUpdate();
                } else if (chr == 0x03) {
                    blinkEnabled = true;
                    requestScreenUpdate();
                } else if (chr == 0x04) {
                    blinkEnabled = false;
                    requestScreenUpdate();
                } else if (chr == 0x05) {
                    connOut.write(0x1f);
                    if (cols132) {
                        connOut.write(0x7e);
                        if (cursorCol >= 80) {
                            if (bias) {
                                connOut.write(0x21);
                                connOut.write(0x20 + cursorCol - 80);
                            } else {
                                connOut.write(0x01);
                                connOut.write(cursorCol - 80);
                            }
                        } else {
                            if (bias) {
                                connOut.write(0x20);
                                connOut.write(0x20 + cursorCol);
                            } else {
                                connOut.write(0x00);
                                connOut.write(cursorCol);
                            }
                        }
                    } else {
                        if (bias) {
                            connOut.write(0x20 + cursorCol);
                        } else {
                            connOut.write(cursorCol);
                        }
                    }
                    if (bias) {
                        connOut.write(0x20 + cursorRow);
                    } else {
                        connOut.write(cursorRow);
                    }
                } else if (chr == 0x06) {
                    if (large) {
                        underscoreChar = true;
                    }
                } else if (chr == 0x07) {
                    playBell();
                } else if (chr == 0x08) {
                    if (!large) {
                        cursorCol = 0;
                        cursorRow = 0;
                    } else {
                        cursorCol--;
                        if (cursorCol < 0) {
                            if (cursorRow > 0) {
                                cursorRow--;
                                cursorCol = highestCol();
                            }
                        }
                        doAutoTab();
                    }
                    requestScreenUpdate();
                } else if (large && chr == 0x09) {
                    doTab();
                } else if (!large && chr == 0x0a) {
                    cursorCol = 0;
                    requestScreenUpdate();
                } else if (large && chr == 0x0a) {
                    cursorCol = 0;
                    cursorRow++;
                    if (cursorRow >= rows) {
                        if (rollEnabled) {
                            scrollBottom();
                            cursorRow--;
                        }
                    } else {
                        cursorRow = 0;
                    }
                    requestScreenUpdate();
                } else if (chr == 0x0b) {
                    if (isDim(cursorCol, cursorRow)) {
                        while (cursorCol <= highestCol() && isDim(cursorCol, cursorRow) && !isProtected(cursorCol, cursorRow)) {
                            clearCell(cursorCol, cursorRow, blockMode);
                            cursorCol++;
                        }
                    } else {
                        while (cursorCol <= highestCol() && !isProtected(cursorCol, cursorRow)) {
                            clearCell(cursorCol, cursorRow, blockMode);
                            cursorCol++;
                        }
                    }
                    requestScreenUpdate();
                    modified = true;
                } else if (chr == 0x0c) {
                    for (int row = 0; row < rows; row++) {
                        for (int col = 0; col <= highestCol(); col++) {
                            clearCell(col, row, blockMode);
                        }
                    }
                    cursorCol = 0;
                    cursorRow = 0;
                    protectChar = false;
                    blinkChar = false;
                    underscoreChar = false;
                    dimChar = false;
                    inverseChar = false;
                    blinkEnabled = true;
                    requestScreenUpdate();
                } else if (chr == 0x0d) {
                    cursorCol = 0;
                    if (autoLineFeed) {
                        cursorRow++;
                        if (cursorRow >= rows) {
                            if (rollEnabled) {
                                scrollBottom();
                                cursorRow--;
                            }
                        } else {
                            cursorRow = 0;
                        }
                    }
                    requestScreenUpdate();
                } else if (chr == 0x0e) {
                    blinkChar = true;
                } else if (chr == 0x0f) {
                    blinkChar = false;
                } else if (chr == 0x10) {
                    // do nothing for large cyber, for small this is processed above
                } else if (chr == 0x11) {
                    // do nothing for small
                    // print page (not supported) for large
                } else if (chr == 0x12) {
                    rollEnabled = true;
                } else if (chr == 0x13) {
                    if (!large) {
                        rollEnabled = false;
                    }
                } else if (chr == 0x14) {
                    if (!large) {
                        underscoreChar = true;
                    }
                } else if (chr == 0x15) {
                    underscoreChar = false;
                } else if (chr == 0x16) {
                    if (large) {
                        rollEnabled = false;
                    }
                } else if (chr == 0x17) {
                    cursorRow--;
                    if (cursorRow < 0) {
                        cursorRow = highestRow();
                    }
                    requestScreenUpdate();
                } else if (chr == 0x18) {
                    cursorCol++;
                    if (cursorCol > highestCol()) {
                        cursorCol = highestCol();
                        doAutoTab();
                    }
                    requestScreenUpdate();
                } else if (chr == 0x19) {
                    if (!large) {
                        cursorCol--;
                        if (cursorCol < 0) {
                            cursorCol = 0;
                        }
                        doAutoTab();
                    } else {
                        cursorRow = 0;
                        cursorCol = 0;
                    }
                    requestScreenUpdate();
                } else if (chr == 0x1a) {
                    cursorRow++;
                    if (cursorRow > highestRow()) {
                        cursorRow = 0;
                    }
                    requestScreenUpdate();
                } else if (chr == 0x1b) {
                    // no-op for escape
                } else if (chr == 0x1c) {
                    dimChar = true;
                } else if (chr == 0x1d) {
                    dimChar = false;
                } else if (chr == 0x1f) {
                    if (large) {
                        cursorCol--;
                        if (cursorCol < 0) {
                            cursorCol = 0;
                        }
                        doAutoTab();
                        clearCell(cursorCol, cursorRow, blockMode);
                        requestScreenUpdate();
                    }
                } else if (chr == 0x1e) {
                    int chr2 = connIn.read();
                    if (chr2 == 0x01) {
                        // print form not supported yet
                    } else if (chr == 0x02) {
                        // page print not supported yet
                    } else if (chr == 0x04) {
                        if (!large) {
                            doTab();
                        }
                    }
                } else {
                    writeChar(chr);
                }
            }
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }

    public void writeChar(int ch) {
        int attr = ATTR_MODIFIED;
        if (dimChar) {
            attr |= ATTR_DIM;
        }
        if (blinkChar) {
            attr |= ATTR_BLINK;
        }
        if (inverseChar) {
            attr |= ATTR_INVERSE;
        }
        if (underscoreChar) {
            attr |= ATTR_UNDERLINE;
        }
        if (protectChar) {
            attr |= ATTR_PROTECTED;
        }
        int pos = cursorRow * 132 + cursorCol;
        screenRam[pos][0] = (byte) attr;
        screenRam[pos][1] = (byte) (ch& 0xff);

        advanceCursor();
    }

    public void advanceCursor() {
        cursorCol++;
        if (cursorCol > highestCol()) {
            cursorCol = 0;
            cursorRow++;
            if (cursorRow > highestRow()) {
                if (!rollEnabled) {
                    cursorRow = 0;
                    doAutoTab();
                } else {
                    cursorRow = highestRow();
                    scrollBottom();
                }
            }
        }
        requestScreenUpdate();
    }

    public void doTab() {
        boolean hasFields = fieldsExist();
        for (; ; ) {
            cursorCol++;
            if (cursorCol >= highestCol()) {
                cursorCol = 0;
                if (cursorRow == highestRow()) {
                    if (hasFields) {
                        cursorRow = 0;
                    } else {
                        scrollBottom();
                    }
                }
            }
            if (((cursorCol & 8) == 0) && !isProtected(cursorCol, cursorRow)) break;

            if (hasFields && !isProtected(cursorCol, cursorRow) && isDim(cursorCol, cursorRow)) {
                break;
            }
        }
        requestScreenUpdate();
    }
    public void doAutoTab() {
        if (isProtected(cursorCol, cursorRow) && autotab) {
            while (isProtected(cursorCol, cursorRow) && autotab) {
                cursorCol--;
                if (cursorCol < 0) {
                    cursorCol = highestCol();
                    if (cursorRow == 0) {
                        cursorRow = rows - 1;
                    }
                }
            }
        }
    }

    public void scrollBottom() {
        for (int row = 0; row < rows - 1; row++) {
            for (int col = 0; col < 132; col++) {
                System.arraycopy(screenRam[(row + 1) * 132 + col], 0, screenRam[row * 132 + col], 0, 2);
            }
        }
        for (int col = 0; col < 132; col++) {
            screenRam[highestRow() * 132 + col][0] = 0;
            screenRam[highestRow() * 132 + col][1] = ' ';
        }
        requestScreenUpdate();
    }

    public boolean hasAttr(int col, int row, int attrMask) {
        return (screenRam[col + row * 132][0] & attrMask) == attrMask;
    }

    public boolean isProtected(int col, int row) {
        return hasAttr(col, row, ATTR_PROTECTED);
    }

    public boolean isDim(int col, int row) {
        return hasAttr(col, row, ATTR_DIM);
    }

    public void clearCell(int col, int row, boolean setModified) {
        int pos = col + row * 132;
        screenRam[pos][0] = (byte) (setModified ? ATTR_MODIFIED : 0);
        screenRam[pos][1] = 32;
    }

    public boolean fieldsExist() {
        for (int row=0; row < rows; row++) {
            for (int col=0; col < highestCol(); col++) {
                if (isDim(col, row)) return true;
            }
        }
        return false;
    }

    public int highestCol() {
        return cols132 ? 131 : 79;
    }

    public int highestRow() {
        return rows-1;
    }

    void playBell() {

    }

    void requestScreenUpdate() {
        validate();
        repaint();
    }

    class KeyHandler implements KeyListener {
        @Override
        public void keyTyped(KeyEvent keyEvent) {
            try {
                connOut.write(keyEvent.getKeyChar() & 0xff);
            } catch (Exception exc) {
                System.out.println("Lost connection.");
                System.out.flush();
                System.exit(0);
            }
        }

        @Override
        public void keyPressed(KeyEvent keyEvent) {

        }

        @Override
        public void keyReleased(KeyEvent keyEvent) {

        }
    }
}
