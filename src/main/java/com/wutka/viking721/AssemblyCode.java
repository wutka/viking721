package com.wutka.viking721;

/**
 * Copied from: https://github.com/HanWelmer/DasmZ80/tree/master
 */

import java.util.ArrayList;

public class AssemblyCode {

    private int address = 0;
    private ArrayList<Byte> bytes;
    private String label;
    private String mnemonic;
    private String comment;

    /**
     * Create a new assembler instruction based on address, array of binary bytes,
     * label, mnemonic and comment.
     *
     * @param address
     * @param bytes
     * @param label
     * @param mnemonic
     * @param comment
     */
    public AssemblyCode(int address, ArrayList<Byte> bytes, String label, String mnemonic, String comment) {
        this.address = address;
        this.bytes = bytes;
        this.label = label;
        this.mnemonic = mnemonic;
        this.comment = comment;
    }

    /**
     * Create a new assembler instruction based on address and array with binary
     * bytes.
     *
     * @param address
     * @param bytes
     */
    public AssemblyCode(int address, ArrayList<Byte> bytes) {
        this.address = address;
        this.bytes = bytes;
    }

    /**
     * Create a new assembler instruction based on address, mnemonic and comment.
     *
     * @param address
     * @param mnemonic
     * @param comment
     */
    public AssemblyCode(int address, String mnemonic, String comment) {
        this.address = address;
        this.label = "";
        this.mnemonic = mnemonic;
        this.comment = comment;
    }

    /**
     * Create a new assembler instruction based on address and mnemonic.
     *
     * @param address
     * @param mnemonic
     */
    public AssemblyCode(int address, String mnemonic) {
        this.address = address;
        this.label = "";
        this.mnemonic = mnemonic;
        this.comment = "";
    }

    public int getAddress() {
        return address;
    }

    public ArrayList<Byte> getBytes() {
        return bytes;
    }

    public void addByte(Byte nextByte) {
        if (bytes == null) {
            bytes = new ArrayList<Byte>();
        }
        bytes.add(nextByte);
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getMnemonic() {
        return mnemonic;
    }

    public void setMnemonic(String mnemonic) {
        this.mnemonic = mnemonic;
    }

    public void updateMnemonic(String oldValue, String newValue) {
        mnemonic = mnemonic.replace(oldValue, newValue);
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public boolean isExit() {
        // TODO add flag to code definition, so that this part becomes
        // microprocessor independent.
        return bytes.get(0) == (byte) 0xC9 // RET
                || bytes.get(0) == (byte) 0xC3 // JP nnnn
                || bytes.get(0) == (byte) 0x18 // JR dd
                || bytes.get(0) == (byte) 0xE9 // JP (HL), JP (IX), JP (IY)
                || "JP   (IX)".equals(mnemonic) || "JP   (IY)".equals(mnemonic);
    } // isExit()

    public String toString() {
        // address
        String result = String.format("%04X", address);

        if ((mnemonic == null || mnemonic.length() == 0) && (label == null || label.length() == 0) && bytes == null) {
            // only a comment or nothing:
            if (comment == null || comment.length() == 0) {
                result = "";
            } else {
                result = String.format("%24s%s", "", comment);
            }
        } else {
            // binary code
            if (bytes != null) {
                int i = 0;
                for (Byte byt : bytes) {
                    if (i == 0) {
                        result += " ";
                        i = 4;
                    }
                    i--;
                    result += String.format("%02X", byt);
                }
            }

            // label
            if (label != null && label.length() > 0) {
                if (result.length() < 14) {
                    result += String.format("%14s", "");
                    result = result.substring(0, 14);
                }
                result += label + ":";
            }

            // mnemonic
            if (mnemonic != null && mnemonic.length() > 0) {
                if (result.length() < 24) {
                    result += String.format("%24s", "");
                    ;
                    result = result.substring(0, 24);
                }
                result += mnemonic;
            }

            // comment
            if (comment != null && comment.length() > 0) {
                if (result.length() < 44) {
                    result += String.format("%44s", "");
                    result = result.substring(0, 44);
                }
                result += comment;
            }
        }

        return result + "\n";
    } // toString()
}