# Viking 721 Terminal Emulator
This will hopefully eventually be an emulator for a CDC Viking 721
terminal. It uses a Z80 emulator from Codesqueak (https://github.com/codesqueak/Z80Processor/tree/master).
It has a simple command-line debugger which incorporates a Z80 disassembler
from https://github.com/HanWelmer/DasmZ80/tree/master.

Although the ROM passes its checksum test, when it populates the NVRAM from the
ROM, the NVRAM fails its checksum test. I was able to set up the NVRAM so that
the startup code does not re-initialize the NVRAM, then manually call the checksum
computation routine at 0x104b and then save the resulting file.

I don't remember where I first got the annotated viking_rom.asm file, but I
have added some additional annotations, and will continue to do so as I continue
to debug.