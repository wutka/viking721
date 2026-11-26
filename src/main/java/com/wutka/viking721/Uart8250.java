package com.wutka.viking721;

import java.util.ArrayDeque;
import java.util.Queue;
import java.util.concurrent.BlockingQueue;

public class Uart8250 {
    String name;
    int rxRegister;
    int txRegister;
    int intEnRegister;
    int intIdRegister;
    int lineControlRegister;
    int modemControlRegister;
    int lineStatusRegister;
    int modemStatusRegister;
    int divisorLSB;
    int divisorMSB;
    boolean sentTxEmpty;
    boolean sentRxAvailable;
    int lastMSR;

    InterruptBus bus;
    int irq;

    BlockingQueue<Integer> txQueue;
    BlockingQueue<Integer> rxQueue;

    public Uart8250(String name, InterruptBus bus, int irq, BlockingQueue<Integer> rxQueue,
                    BlockingQueue<Integer> txQueue) {
        this.name = name;
        this.bus = bus;
        this.irq = irq;
        this.rxRegister = 0;
        this.txRegister = 0;
        this.intEnRegister = 0;
        this.intIdRegister = 6;
        this.lineControlRegister = 0;
        this.modemControlRegister = 0;
        this.lineStatusRegister = 0x60; // tx empty, rx empty
        this.modemStatusRegister = 0xc0;
        this.divisorLSB = 0;
        this.divisorMSB = 0;
        this.sentTxEmpty = false;
        this.sentRxAvailable = false;
        this.txQueue = txQueue;
        this.rxQueue = rxQueue;
    }

    protected boolean latchAccess() {
        return (lineControlRegister & 0x80) == 0x80;
    }

    protected boolean txEmpty() {
        return (lineStatusRegister & 0x20) == 0x20;
    }

    protected void setTxEmpty(boolean empty) {
        if (empty) {
            lineStatusRegister = lineStatusRegister | 0x20;
            sendTxEmpty();
        } else {
            sentTxEmpty = false;
            lineStatusRegister = lineStatusRegister & 0xdf;
        }
    }

    protected boolean rxEmpty() {
        return (lineStatusRegister & 0x40) == 0x40;
    }

    protected void setRxEmpty(boolean empty) {
        if (empty) {
            lineStatusRegister = lineStatusRegister | 0x40;
            lineStatusRegister = lineStatusRegister & 0xfe;
            sentRxAvailable = false;
        } else {
            lineStatusRegister = lineStatusRegister & 0xbf;
            lineStatusRegister = lineStatusRegister | 1;
            sendRxAvailable();
        }
    }

    protected boolean loopback() {
        return (modemControlRegister & 0x10) == 0x10;
    }

    protected boolean txIntEnabled() {
        return (intEnRegister & 2) == 2;
    }

    protected boolean rxIntEnabled() {
        return (intEnRegister & 1) == 1;
    }

    public void writeRegister(int regNum, int value) {
        if (regNum == 0) {
            if (!latchAccess()) {
                if (txEmpty()) {
                    txRegister = value & 0xff;
                    setTxEmpty(false);
                    if (loopback()) {
                        if (rxEmpty()) {
                            lineStatusRegister = lineStatusRegister & 0xdf;
                            // Set tx empty again
                            setTxEmpty(true);
                            setRxEmpty(false);
                            rxRegister = txRegister;
                        }
                    } else {
                        System.out.printf("Uart %s tx holding byte %02x\n", name, value);
                    }
                }
            } else {
            }
        } else if (regNum == 1) {
            intEnRegister = value;
            if (txIntEnabled() && txEmpty() && !sentTxEmpty) {
                sendTxEmpty();
            }
        } else if (regNum == 3) {
            lineControlRegister = value;
        } else if (regNum == 4){
            modemControlRegister = value;
            if (loopback()) {
                modemStatusRegister = modemStatusRegister |
                        ((modemControlRegister & 2) << 3) |
                        ((modemControlRegister & 1) << 5);
                if (((modemStatusRegister & 0x60) ^
                        (lastMSR & 0x60)) != 0) {
                    modemStatusRegister |=
                            ((modemStatusRegister & 0x60) >> 4);
                }
            }
        }
    }

    protected void sendTxEmpty() {
        if (txIntEnabled()) {
            bus.setInterruptLine(irq);
            sentTxEmpty = true;
        }
    }

    protected void sendRxAvailable() {
        if (rxIntEnabled()) {
            bus.setInterruptLine(irq);
            sentRxAvailable = true;
        }
    }
    public int readRegister(int regNum) {
        if (regNum == 0) {
            if (!latchAccess()) {
                if (rxEmpty()) {
                    return 0;
                } else {
                    int rxVal = rxRegister;
                    rxRegister = 0;
                    setRxEmpty(true);
                    return rxVal;
                }
            } else {
                return 0;
            }
        } else if (regNum == 1) {
            return intEnRegister;
        } else if (regNum == 2) {
            return intIdRegister;
        } else if (regNum == 4) {
            return modemStatusRegister;
        } else if (regNum == 5) {
            return lineStatusRegister;
        } else if (regNum == 6) {
            lastMSR = modemStatusRegister;
            return modemStatusRegister;
        }
        return 0;
    }

    void checkTxQueue() {
        if (!txEmpty() && txQueue.remainingCapacity() > 0) {
            txQueue.offer(txRegister);
            setTxEmpty(true);
        }
    }

    void checkRxQueue() {
        if (rxEmpty()) {
            Integer d = rxQueue.poll();
            if (d != null) {
                rxRegister = d;
                setRxEmpty(false);
            }
        }
    }
}
