package com.wutka.viking721;

import java.util.ArrayDeque;
import java.util.Queue;

public class Uart8250 {
    String name;
    boolean loopbackMode;
    boolean latchAccess;
    boolean txIntEnabled;
    boolean rxIntEnabled;
    boolean txEmpty;
    int txHolding;
    boolean rxEmpty;
    int rxHolding;
    InterruptBus bus;
    int irq;

    public Uart8250(String name, InterruptBus bus, int irq) {
        this.name = name;
        loopbackMode = false;
        this.bus = bus;
        this.irq = irq;
        txEmpty = true;
        rxEmpty = false;
    }

    public void writeRegister(int regNum, int value) {
        System.out.printf("Uart %s write %02x to register %02x\n", name, value, regNum);
        if (regNum == 0) {
            if (!latchAccess) {
                if (txEmpty) {
                    txHolding = value & 0xff;
                    txEmpty = false;
                    if (loopbackMode) {
                        if (rxEmpty) {
                            rxEmpty = false;
                            rxHolding = txHolding;
                        }
                        if (rxIntEnabled) {
                            bus.setInterruptLine(irq);
                        }
                    } else {
                        System.out.printf("Uart %s tx holding byte %02x\n", name, value);
                    }
                }
            } else {
            }
        } else if (regNum == 1) {
            if (latchAccess) {
//                latchHigh = (byte) (value & 0xff);
            } else {
                rxIntEnabled = (value & 1) == 1;
                txIntEnabled = (value & 2) == 2;
/*                if (rxIntEnabled && !inputQueue.isEmpty()) {
                    bus.setInterruptLine(irq);
                }
                if (txIntEnabled && outputQueue.isEmpty()) {
                    bus.setInterruptLine(irq);
                }*/
            }
        } else if (regNum == 3) {
            latchAccess = (value & 0x80) == 0x80;
        } else if (regNum == 4){
            loopbackMode = (value & 0x10) == 0x10;
            System.out.println("Uart "+name+" Loopback mode is "+loopbackMode);
            if (loopbackMode && ((value & 1) == 1)) {
                if (!txEmpty && rxEmpty) {
                    rxHolding = txHolding;
                    if (rxIntEnabled) {
                        bus.setInterruptLine(irq);
                    }
                }
            }
        }
    }

    public int readRegister(int regNum) {
        if (regNum == 0) {
            if (!latchAccess) {
                if (rxEmpty) {
                    return 0;
                } else {
                    int rxVal = rxHolding;
                    rxHolding = 0;
                    rxEmpty = true;
                    System.out.printf("Uart %s Receive byte %02x\n", name, rxVal);
                    return rxVal;
                }
            } else {
                return 0;
            }
        } else if (regNum == 1) {
            if (latchAccess) {
            }
        } else if (regNum == 4) {
            byte status = 0;
            if (loopbackMode) {
                status |= 0x10;
            }
            return status;
        } else if (regNum == 5) {
            byte status = 0;
            /*
            if (outputQueue.isEmpty()) {
//                status |= 0x20;
            }
//            status |= 0x40;
            if (!inputQueue.isEmpty()) {
                status |= 1;
            }
             */
            return status & 0xff;
        } else if (regNum == 6) {
            int status = 0x88;
            bus.clearInterruptLine(irq);

            return status & 0xff;
        }
        return 0;
    }
}
