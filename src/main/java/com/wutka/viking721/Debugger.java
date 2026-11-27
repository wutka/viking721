package com.wutka.viking721;

import com.codingrodent.microprocessor.IMemory;
import com.codingrodent.microprocessor.ProcessorException;
import com.codingrodent.microprocessor.Z80.CPUConstants;
import com.codingrodent.microprocessor.Z80.Z80Core;

import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashSet;
import java.util.Set;
import javax.swing.*;

public class Debugger {
    Z80Core z80;
    Set<Integer> breakpoints;
    boolean continuing;
    Decoder decoder;
    IMemory mem;
    boolean enabled;
    Memory[] banks;
    int[] blockBankNums;
    JPanel display;
    Console console;
    BufferedReader reader;


    public Debugger(Z80Core z80, IMemory mem, Memory[] banks, int[] blockBankNums, JPanel display) {
        this.z80 = z80;
        this.mem = mem;
        this.breakpoints = new HashSet<>();
        this.continuing = false;
        this.decoder = new Decoder(mem);
        this.enabled = true;
        this.banks = banks;
        this.blockBankNums = blockBankNums;
        this.display = display;
        this.console = System.console();
        if (this.console == null) {
            this.reader = new BufferedReader(new InputStreamReader(System.in));
        }
    }

    protected String flagsToString(int flags) {
        StringBuilder result = new StringBuilder();
        if ((flags & 0x80) == 0x80) result.append('S');
        if ((flags & 0x40) == 0x40) result.append('Z');
        if ((flags & 0x10) == 0x10) result.append('H');
        if ((flags & 0x4) == 0x4) result.append('V');
        if ((flags & 0x2) == 0x2) result.append('N');
        if ((flags & 0x1) == 0x1) result.append('C');
        if (result.isEmpty()) result.append("-");
        return result.toString();
    }
    public void step() {
        if (!this.enabled) {
            try {
                z80.executeOneInstruction();
                return;
            } catch (ProcessorException exc) {
                System.out.println("Processor exception:");
                exc.printStackTrace(System.out);
            }
            return;
        }
        if (continuing) {
            if (!this.breakpoints.contains(z80.getProgramCounter())) {
                try {
                    z80.executeOneInstruction();
                    return;
                } catch (ProcessorException exc) {
                    System.out.println("Processor exception:");
                    exc.printStackTrace(System.out);
                }
            } else {
                System.out.printf("Hit breakpoint at %4x\n", z80.getProgramCounter());
                this.continuing = false;
            }
        }
        while (true) {
            Decoder.Instr inst = decoder.get(z80.getProgramCounter());
            System.out.printf("PC:%04x OP: %02x  Flags: %s  A: %02x  B: %02x  C: %02x  D: %02x  E: %02x  H: %02x  L: %02x  IX: %04x  IY: %04x  SP: %04x  SF: %02x  I: %02x\n",
                    z80.getRegisterValue(CPUConstants.RegisterNames.PC),
                    mem.readByte(z80.getRegisterValue(CPUConstants.RegisterNames.PC)),
                    flagsToString(z80.getRegisterValue(CPUConstants.RegisterNames.F)),
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
                    z80.getRegisterValue(CPUConstants.RegisterNames.F_ALT) & 0xff,
                    z80.getRegisterValue(CPUConstants.RegisterNames.I));
            System.out.print(inst.str);
            System.out.print("> ");
            System.out.flush();
            try {
                String line;
                if (console != null) {
                    line = System.console().readLine();
                } else {
                    try {
                        line = reader.readLine();
                    } catch (IOException exc) {
                        System.out.println("Error reading input");
                        return;
                    }
                }
                String[] parts = line.split(" ");
                switch (parts[0]) {
                    case "c":
                        this.continuing = true;
                        z80.executeOneInstruction();
                        return;
                    case "b":
                        int addr = z80.getProgramCounter();
                        if (parts.length > 1) {
                            addr = Integer.parseInt(parts[1], 16);
                        }
                        if (this.breakpoints.contains(addr)) {
                            this.breakpoints.remove(addr);
                        } else {
                            this.breakpoints.add(addr);
                        }
                        break;
                    case "bl":
                        System.out.println("Breakpoints:");
                        Integer[] breakpoints = this.breakpoints.stream().sorted().toArray(Integer[]::new);
                        for (Integer bp : breakpoints) {
                            System.out.printf("%4x\n", bp);
                        }
                        break;
                    case "banks":
                        System.out.println("Active banks:");
                        for (int i=0; i < 4; i++) {
                            System.out.printf("Block %04x: %d\n", i * 0x4000, blockBankNums[i]);
                        }
                        break;
                    case "d":
                        addr = z80.getProgramCounter();
                        int len = 10;
                        if (parts.length > 1) {
                            addr = Integer.parseInt(parts[1], 16);
                        }
                        if (parts.length > 2) {
                            len = Integer.parseInt(parts[2]);
                        }
                        while (len > 0) {
                            inst = decoder.get(addr);
                            System.out.print(inst.str);
                            addr = inst.nextAddr;
                            len -= 1;
                        }
                        System.out.println("-------------------");
                        break;
                    case "g":
                        if (parts.length < 2) {
                            System.out.println("Please supply an address to goto");
                            break;
                        }
                        addr =  Integer.parseInt(parts[1], 16);
                        z80.setProgramCounter(addr);
                        break;
                    case "m":
                        if (parts.length < 2) {
                            System.out.println("Please supply a memory address");
                            break;
                        }
                        addr = Integer.parseInt(parts[1], 16);
                        len = 32;
                        if (parts.length > 2) {
                            len = Integer.parseInt(parts[2]);
                        }
                        byte[] buff = new byte[len];
                        for (int i=0; i<len; i++) {
                            buff[i] = (byte) mem.readByte(addr+i);
                        }
                        this.dumpMemory(addr, len, buff);
                        break;
                    case "w":
                        if (parts.length < 3) {
                            System.out.println("Please supply a filename, a memory address and an optional length (default=32)");
                            break;
                        }
                        String filename = parts[1];
                        addr = Integer.parseInt(parts[2], 16);
                        len = 32;
                        if (parts.length > 2) {
                            len = Integer.parseInt(parts[3]);
                        }
                        buff = new byte[len];
                        for (int i=0; i<len; i++) {
                            buff[i] = (byte) mem.readByte(addr+i);
                        }
                        try {
                            Files.write(Path.of(filename), buff);
                            System.out.printf("Wrote %d bytes to %s\n", len, filename);
                        } catch (IOException exc) {
                            System.out.println("Error writing file: "+exc.getMessage());
                        }
                        break;
                    case "mb":
                        if (parts.length < 3) {
                            System.out.println("Please supply a bank number and an address");
                            break;
                        }
                        int bankNum = Integer.parseInt(parts[1]);
                        Memory bank = banks[bankNum];
                        addr = Integer.parseInt(parts[2], 16);
                        len = 32;
                        if (parts.length > 3) {
                            len = Integer.parseInt(parts[3]);
                        }
                        buff = new byte[len];
                        for (int i=0; i<len; i++) {
                            buff[i] = (byte)bank.getData(addr+i);
                        }
                        this.dumpMemory(addr, len, buff);
                        break;
                    case "ref":
                        display.validate();
                        display.repaint();
                        break;

                    case "set":
                        if (parts.length < 3) {
                            System.out.println("Please supply and address and a byte value");
                            break;
                        }
                        addr = Integer.parseInt(parts[1], 16);
                        byte val = Byte.parseByte(parts[2], 16);
                        mem.writeByte(addr, val);
                        break;
                    case "s":
                    default:
                        z80.executeOneInstruction();
                        return;
                }
            } catch (ProcessorException exc) {
                System.out.println("Processor exception:");
                exc.printStackTrace(System.out);
            }
        }
    }
    public void dumpMemory(int addr, int len, byte[] buffer) {
        int pos = 0;
        while (pos < len) {
            StringBuilder bytes = new StringBuilder();
            StringBuilder ascii = new StringBuilder();
            for (int i=0; i < 16; i++) {
                if (pos + i < len) {
                    int b = buffer[pos+i];
                    if (b < 0) b += 256;
                    bytes.append(String.format("%02x ", b));
                    if (b >= 32) {
                        ascii.append((char) b);
                    } else {
                        ascii.append(".");
                    }
                } else {
                    bytes.append("   ");
                    ascii.append(' ');
                }
                if (i == 7) {
                    bytes.append("  ");
                }
            }
            System.out.printf("%04x:  %s  %s\n", addr+pos, bytes.toString(), ascii.toString());
            pos += 16;
        }
    }
}
