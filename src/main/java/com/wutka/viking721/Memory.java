package com.wutka.viking721;

public class Memory {
    byte[] data;
    boolean readOnly;

    public Memory(byte[] data, boolean readOnly) {
        this.data = data;
        this.readOnly = readOnly;
    }

    public int getData(int address) {
        return data[address&0xffff] & 0xff;
    }

    public void putData(int address, int val) {
        if (readOnly) return;
        data[address&0xffff] = (byte) (val & 0xff);
    }

}
