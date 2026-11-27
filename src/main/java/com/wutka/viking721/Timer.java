package com.wutka.viking721;

import com.codingrodent.microprocessor.Z80.Z80Core;

public class Timer {
    boolean setTimeConstant;
    InterruptBus bus;
    boolean interruptEnabled;
    boolean counting;
    boolean timerMode;
    long expiryTime;
    int timeConstant;
    int prescale;
    int irq;

    public Timer(InterruptBus bus, int irq) {
        this.bus = bus;
        this.irq = irq;
    }

    public int readRegister() {
        return timeConstant & 0xff;
    }

    public void writeRegister(int data) {
        if (setTimeConstant) {
            timeConstant = data & 0xff;
            if (timeConstant == 0) {
                timeConstant = 256;
            }
            setTimeConstant = false;
            if (!timerMode) {
                expiryTime = timeConstant;
            } else {
                expiryTime = (long)prescale * timeConstant;
            }
            counting = true;
        } else if ((data & 1) == 1) { //Control word
            interruptEnabled = (data & 0x80) == 0x80;
            setTimeConstant = (data & 4) == 4;
            timerMode = (data & 0x40) != 0x40;
            if ((data & 0x20) == 0x20) {
                prescale = 256;
            } else {
                prescale = 16;
            }
            if ((data & 2) == 2 && counting) {
                counting = false;
                interruptEnabled = false;
            }
            if ((data & 0x40) == 0x40) {
                expiryTime = timeConstant;
                counting = !setTimeConstant;
            } else {
                expiryTime = timeConstant * prescale;
            }
        }
    }

    public void tick(long ticks) {
        if (counting) {
            expiryTime -= ticks;
            if (expiryTime <= 0) {
                if (interruptEnabled) {
                    bus.setInterruptLine(irq);
                }
                //counting = false;
                if (!timerMode) {
                    expiryTime = timeConstant;
                } else {
                    counting = false;
                }
            }
        }
    }
}
