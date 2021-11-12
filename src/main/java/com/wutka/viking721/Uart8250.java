package com.wutka.viking721;

import java.util.ArrayDeque;
import java.util.Queue;

public class Uart8250 {
    boolean loopbackMode;
    Queue<Byte> inputQueue;
    Queue<Byte> outputQueue;
    boolean latchAccess;
    boolean txIntEnabled;
    boolean rxIntEnabled;
    byte latchLow;
    byte latchHigh;
    InterruptBus bus;
    int irq;

    public Uart8250(InterruptBus bus, int irq) {
        loopbackMode = false;
        inputQueue = new ArrayDeque<>();
        outputQueue = new ArrayDeque<>();
        this.bus = bus;
        this.irq = irq;
    }

    public void writeRegister(int regNum, int value) {
        System.out.printf("Uart write %02x to register %02x\n", value, regNum);
        if (regNum == 0) {
            if (!latchAccess) {
                System.out.printf("Transmit byte %02x\n", value);
                if (loopbackMode) {
                    inputQueue.add((byte) (value & 0xff));
                    if (rxIntEnabled) {
                        bus.setInterruptLine(irq);
                    }
                } else {
                    outputQueue.add((byte) (value & 0xff));
                }
            } else {
                latchLow = (byte) (value & 0xff);
            }
        } else if (regNum == 1) {
            if (latchAccess) {
                latchHigh = (byte) (value & 0xff);
            } else {
                rxIntEnabled = (value & 1) == 1;
                txIntEnabled = (value & 2) == 2;
            }
        } else if (regNum == 3) {
            latchAccess = (value & 0x80) == 0x80;
        } else if (regNum == 4){
            loopbackMode = (value & 0x10) == 0x10;
            System.out.println("Loopback mode is "+loopbackMode);
        }
    }

    public int readRegister(int regNum) {
        System.out.printf("Uart read register %02x\n", regNum);
        if (regNum == 0) {
            if (!latchAccess) {
                if (inputQueue.isEmpty()) return 0;
                byte b = inputQueue.remove();
                System.out.printf("Transmit byte %02x\n", b);
                return b;
            } else {
                return latchLow;
            }
        } else if (regNum == 0) {
            if (latchAccess) {
                return latchHigh;
            }
        } else if (regNum == 4) {
            byte status = 0;
            if (loopbackMode) {
                status |= 0x10;
            }
            return status;
        } else if (regNum == 5) {
            byte status = 0;
            if (outputQueue.isEmpty()) {
                status |= 0x20;
            }
            if (inputQueue.isEmpty()) {
                status |= 0x40;
            }
            if (!inputQueue.isEmpty()) {
                status |= 1;
            }
            return status;
        }
        return 0;
    }

    public void writeInputByte(byte b) {
        inputQueue.add(b);
        if (rxIntEnabled) {
            bus.setInterruptLine(irq);
        }
    }

    public boolean hasOutputByte() {
        return !outputQueue.isEmpty();
    }

    public byte readOutputByte() {
        if (outputQueue.isEmpty()) {
            return 0;
        }
        byte b = outputQueue.remove();
        if (outputQueue.isEmpty()) {
            bus.setInterruptLine(irq);
        }
        return b;
    }
}
