package com.wutka.viking721;

import java.util.ArrayDeque;
import java.util.Queue;

public class Uart8250 {
    String name;
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

    public Uart8250(String name, InterruptBus bus, int irq) {
        this.name = name;
        loopbackMode = false;
        inputQueue = new ArrayDeque<>();
        outputQueue = new ArrayDeque<>();
        this.bus = bus;
        this.irq = irq;
    }

    public void writeRegister(int regNum, int value) {
        System.out.printf("Uart %s write %02x to register %02x\n", name, value, regNum);
        if (regNum == 0) {
            if (!latchAccess) {
                if (loopbackMode) {
                    System.out.printf("Uart %s Loopback byte %02x\n", name, value);
                    inputQueue.add((byte) (value & 0xff));
                    if (rxIntEnabled) {
                        bus.setInterruptLine(irq);
                    }
                } else {
                    System.out.printf("Uart %s Transmit byte %02x\n", name, value);
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
                if (rxIntEnabled && !inputQueue.isEmpty()) {
                    bus.setInterruptLine(irq);
                }
                if (txIntEnabled && outputQueue.isEmpty()) {
                    bus.setInterruptLine(irq);
                }
            }
        } else if (regNum == 3) {
            latchAccess = (value & 0x80) == 0x80;
        } else if (regNum == 4){
            loopbackMode = (value & 0x10) == 0x10;
            System.out.println("Uart "+name+" Loopback mode is "+loopbackMode);
            if (loopbackMode) {
                System.out.printf("Uart %s transferring %d bytes to input queue\n", name, outputQueue.size());
                inputQueue.addAll(outputQueue);
                outputQueue.clear();
                if (rxIntEnabled && !inputQueue.isEmpty()) {
                    bus.setInterruptLine(irq);
                }
            }
        }
    }

    public int readRegister(int regNum) {
        if (regNum == 0) {
            if (!latchAccess) {
                if (inputQueue.isEmpty()) return 0;
                byte b = inputQueue.remove();
                System.out.printf("Uart %s Receive byte %02x\n", name, b);
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
//                status |= 0x20;
            }
//            status |= 0x40;
            if (!inputQueue.isEmpty()) {
                status |= 1;
            }
            return status;
        } else if (regNum == 6) {
            int status = 0x88;
            bus.clearInterruptLine(irq);

            return (byte) (status & 0xff);
        }
        return 0;
    }

    public void writeInputByte(byte b) {
        System.out.printf("Uart %s got input byte %-2x\n", name, b);
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
