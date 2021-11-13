; z80dasm 1.1.5
; command line: z80dasm -t -g 0 resident.bin

    ;****************************************************
    ;
    ; M O D E   I N S T A L L A T I O N   R A M / E Q U
    ;
    ;****************************************************

RAMST:  equ     0e040h
MBYTE1: equ     0e040h      ; RAMST
MODEEN: equ     01h         ; MODE ENABLED
SECEN:  equ     02h         ; SECURITY ENABLED
OPSLSF: equ     04h         ; OPERATOR SELECT SOURCE/FILE
LDEN:   equ     08h         ; LOAD ENABLED (FROM HOST OR DISK)
MBYTE2: equ     0e041h      ; MBYTE1+1
LDDISK: equ     01h         ; LOAD FROM DISK
INTMDM: equ     02h         ; USE INTERNAL 1200-BAUD MODEM
CDIAL:  equ     04h         ; CONTINUOUS DIAL
AUTODL: equ     08h         ; AUTO DIAL
MBYTE3: equ     0e042h      ; MBYTE2+1
H8BIT:  equ     01h         ; HOST 8 BITS
HPEN:   equ     02h         ; HOST PARITY ENABLED
HPEVEN: equ     04h         ; HOST PARITY EVEN
H2STOP: equ     08h         ; HOST 2 STOP BITS
MBYTE4: equ     0e043h      ; MBYTE3+1
DTRSW:  equ     01h         ; DTR SWITCHED
RTSSW:  equ     02h         ; RTS SWITCHED
RPTDIS: equ     04h         ; REPEAD DISABLED (TYPAMATIC OFF)
DTONLY: equ     08h         ; DATA ONLY OPERATION
MBYTE5: equ     0e044h      ; MBYTE4+1
HOMELL: equ     01h         ; HOME LOWER LEFT
AUTOLF: equ     02h         ; AUTO LINE FEED ENABLED
PACEEN: equ     04h         ; PACING ENABLED
BIASEN: equ     08h         ; BIAS ENABLED
MBYTE6: equ     0e045h      ; MBYTE5+1
AADVDS: equ     01h         ; AUTOMATIC ADVANCE DISABLED
;               02h         ; NOT USED
;               04h         ; NOT USED
RUNPAK: equ     08h         ; 0 = RUN CYBER  1 = RUN ROM PACK

;*******************************************************
;               O P E R A T E R   P A R A M E T E R S
;*******************************************************
OBYTE1: equ     0e046h      ; MBYTE6+1
LOCAL:  equ     01h         ; LOCAL
PTSEL:  equ     02h         ; PRINTER SELECTED
MRGEN:  equ     04h         ; MARGIN ALERT ENABLED
ALERTL: equ     08h         ; ALERT LOUD
OBYTE2: equ     0e047h      ; OBYTE1+1
SFLOCK: equ     01h         ; SHIFT LOCK
NPADIV: equ     02h         ; NUMERIC PAD SHIFTED
ROLLSC: equ     04h         ; ROLL SCREEN
PAGESC: equ     0bh         ; .PAGE SCROLL
LARGE:  equ     08h         ; LARGE CYBER
OBYTE3: equ     0e048h      ; OBYTE2+1
BGLITE: equ     01h         ; BACKGROUND LIGHT
CRBOX:  equ     02h         ; CURSOR BOX
CRSLD:  equ     04h         ; CURSOR SOLID ON
;       equ     08h         ; NOT USABLE
OBYTE4: equ     0e049h      ; OBYTE3+1
FULL:   equ     01h         ; FULL DUPLEX
CL132:  equ     02h         ; 132 CHARACTERS PER LINE
LN30:   equ     04h         ; 30 LINES
TRANS:  equ     08h         ; TRANSPARENT
; MORE MODE PARAMETERS
ADILE:  equ 0e04ah          ; OBYTE4+1  AUTO-DIAL NUMBER
DFILE:  equ 0e056h          ; ADILE+12  DEFAULT FILE NUMBER
TBAUD:  equ 0e058h          ; DFILE+2   TRANSMIT BAUD RATE
RBAUD:  equ 0e059h          ; TBAUD+1   RECEIVE BAUD RATE
SECURE: equ 0e05ah          ; RBAUD+1   SECURITY CODE
OEND:   equ 0e060h          ; END OF OPERATOR PARAMETERS

; TERMINAL PARAMETERS
TBYTE1: equ 0e060h          ; OEND
;       equ     01h         ; SPARE
TPOPT:  equ     02h         ; TOUCHPANEL OPTION IN
DSOPT:  equ     04h         ; DUAL SERIAL OPTION IN
GPOPT:  equ     08h         ; GRAPHIC PRINTER OPTION IN
TBYTE2: equ 0e061h          ; TBYTE1+1
FDOPT:  equ     01h         ; FLEXIBLE DISK OPTION IN
SGPOPT: equ     02h         ; GRAPHIC PRINTER OPTION IN
IMOPT:  equ     04h         ; INTERNAL 1200 MODEM OPTION IN
;       equ     08h         ; SPARE
TBYTE3: equ 0e062h          ; TBYTE2+1
GOPT:   equ     01h         ; GRAPHIC OPTION IN
PAROPT: equ     02h         ; PARALLEL OPTION IN
;       equ     04h         ; SPARE
FXDOPT: equ     08h         ; FIXED DISK OPTION IN
TBYTE4: equ 0e063h          ; TBYTE3+1
ASELEN: equ     01h         ; AUTO SELECT ENABLE
DLSTRS: equ     02h         ; DELAY IN PRINTER SRTS
RILOOP: equ     04h         ; RUN INTERNAL MODEM LOOPBACK
TDIAL:  equ     08h         ; TIME DIAL
TBYTE5: equ 0e064h          ; TBYTE4+1
MPTDSR: equ     01h         ; MONITOR PRINTER Ready
MBIDSR: equ     02h         ; MONITOR BIDIRECTIONAL Ready
TBYTE6: equ 0e065h          ; TBYTE5+1
ASEL:   equ 0e066h       ; TBYTE6+1 AUTO SELECT 0-7 (DEFAULT MODE)
XDELTA: equ 0e067h          ; ASEL+1     SCREEN MOVE X DELTA
YDELTA: equ 0e068h          ; XDELTA+1   SCREEN MOVE Y DELTA 0-F
LANG:   equ 0e069h          ; YDELTA+1   LANGUAGE 0-7
ID:     equ 0e06ah          ; LANG+1   TERMINAL ID NUMBER 0000-FFFF
CHAPAR: equ 0e06eh          ; ID+4       CHANNEL A PARAMETERS
DS8BIT: equ     01h         ; 7/8 DATA BITS
PAREV:  equ     02h         ; PARITY EVEN
PARDIS: equ     04h         ; PARITY DISABLED
BIDIR:  equ     08h         ; BIDIRECTIONAL PORT
CHABD:  equ 0e06fh          ; CHAPAR+1   CHANNEL A BAUD 0-F
CHBPAR: equ 0e070h          ; CHABD+1    CHANNEL B PARAMETERS
CHBBD:  equ 0e071h          ; CHAPAR+1   CHANNEL B BAUD 0-F
TEEND:  equ 0e080h          ; TERMINAL EQUATE END

; BIDIRECTIONAL PORT
BDATAR: equ 0e080h          ; BIDIR DATA IN/OUT
IER:    equ 01h             ; INTERRUPT ENABLE REGISTER
IIR:    equ 02h             ; INTERRUPT ID REGISTER INPUT
LCR:    equ 03h             ; LINE CONTROL REGISTER OUTPUT
MCR:    equ 04h             ; MODEM CONTROL REGISTER OUTPUT
LSR:    equ 05h             ; LINE STATUS REGISTER INPUT
MSR:    equ 06h             ; MODEM STATUS REGISTER INPUT

; COMM I/O STORED IN RAM
CDATAR: equ 0e081h          ; BDATAR+1  COMM DATA IN/OUT
PDATAR: equ 0e082h          ; CDATAR+1  PRINTER DATA IN/OUT

; INPUT BUFFERS
BFCNT:  equ 0e083h          ; # OF CHARACTERS IN COMM BUFFER
BFINAD: equ 0e085h          ; ADDRESS OF NEXT OPEN SLOT IN BUFFER
BDOTAD: equ 0e087h          ; ADDRESS OF NEXT CHARACTER TO BE TAKEN
;                             FROM COMM INPUT BUFFER
KBCNT:  equ 0e089h          ; # OF CHARACTERS IN KEYBOARD BUFFER
KBINAD: equ 0e08ah          ; ADDRESS OF NEXT OPEN SLOT IN BUFFER
KBOTAD: equ 0e08ch          ; ADDRESS OF NEXT CHARACTER TO BE TAKEN
;                             FROM KEYBOARD INPUT BUFFER
TXCNT:  equ 0e08eh          ; # OF CHARACTERS IN TRANSMIT BUFFER
TXINAD: equ 0e08fh          ; ADDRESS OF NEXT OPEN SLOT IN BUFFER
TXOTAD: equ 0e091h          ; ADDRESS F NEXT CHARACTER TO BE TAKEN
;                             FROM TRANSMIT BUFFER

; DELAYS
ALRACT: equ 0e093h          ; 250 MS ALARM DELAY ACTIVE
ALRTM:  equ 31              ; 31 * 8 = 248
BRKACT: equ 0e094h          ; 250MS. BREAK DELAY ACTIVE
BRKTM:  equ 31              ; 31 * 8 = 248
KBDACT: equ 0e095h          ; 1 SEC. KEYBOARD DELAY IS ACTIVE
KBDTM:  equ 125             ; 125 * 8 = 1 SEC
KBRACT: equ 0e096h          ; 60MS. KEYBOARD REPEAT IS ACTIVE
KBRTM:  equ 8               ; 8 * 8 = 64
PCDACT: equ 0e097h          ; 8 MS. PACING DELAY ACTIVE
PNTACT: equ 0e098h          ; 200MS. PRINTER DELAY ACTIVE
PNTTM:  equ 25              ;
TXDACT: equ 0e099h          ; 8MS. TRANSMIT DELAY IS ACTIVE
UD1ACT: equ 0e09ah          ; USER DELAY 1 ACTIVE
UD1ADD: equ 0e09bh          ; USER DELAY 1 ADDRESS
UD2ACT: equ 0e09dh          ; USER DELAY 2 ACTIVE
UD2ADD: equ 0e09eh          ; USER DELAY 2 ADDRESS

; INTERRUPT MASK
INTMSK: equ 0e0a0h          ; INTERRUPT MASK
INTCM:  equ 01h             ; INT. 0 COMM MASK
INTIM:  equ 02h             ; INT. 1 INTERNAL MODEM
INTDP:  equ 04h             ; INT. 2 DUAL RS-232-C PORT MASK
INTPP:  equ 08h             ; INT. 3 PARALLEL PORT/FIXED DISK MASK
INTTP:  equ 010h            ; INT. 4 TOUCHPANEL MASK
INTKB:  equ 020h            ; INT. 5 KEYBOARD MASK
INTTM:  equ 040h            ; INT. 6 TIMER MASK
INTPE:  equ 080h            ; INT. 7 PARITY ERROR

; KEYBOARD TABLE
KNSNC:  equ 0e0a1h          ; ADDRESS OF NO SHIFT, NO CONTROL TABLE
KSNC:   equ 0e0a3h          ; ADDRESS OF SHIFT, NO CONTROL TABLE
KNSC:   equ 0e0a5h          ; ADDRESS OF NO SHIFT, CONTROL TABLE
KSC:    equ 0e0a7h          ; ADDRESS OF SHIFT, CONTROL TABLE

; DISPLAY RAM
ATTRIB: equ 0e0a9h          ; ATTRIBUTES WORD
BLANK:  equ 01h             ;   2**0=BLANK
UNDLN:  equ 02h             ;   2**1=UNDERSCORE
INVERS: equ 04h             ;   2**2=INVERSE
BLINK:  equ 08h             ;   2**3=BLINK
DIM:    equ 10h             ;   2**4=DIM
MODIFY: equ 20h             ;   2**5=MODIFIED DATA
VALID:  equ 40h             ;   2**6=VALIDATE CHARACTER
PROTD:  equ 80h             ;   2**7=PROTECT
ATTSAV: equ 0e0aah          ; A PLACE TO SAVE ATTRIB
BLKMD:  equ 0e0abh          ; BLOCK MODE ACTIVE
BLKSND: equ 0e0ach          ; BLOCK SEND ACTIVE
BSCRPE: equ 0e0adh          ; BACKSPACE CURSOR IN PARAMETER ENTRY
;                             MODE
CCDSR:  equ 0e0aeh          ; CURRENT COMM DSR
CEOL:   equ 0e0afh          ; 1= CLEAR TO EOL ACTIVE
CHNCHG: equ 0e0b0h          ; CHANGE IN NUMBER OF CHARACTERS
CHRCNT: equ 0e0b1h          ; CHARACTER COUNT 0-4F, 0-83
CHRSAV: equ 0e0b2h          ; A PLACE TO SAVE CHARACTER COUNT
CLRTYP: equ 0e0b3h          ; TYPE OF CLEAR
;                             00= ALL
;                             02= UNDERSCORE
;                             08= BLINK
;                             10= DIM
;                             1F= NORMAL
COMPNT: equ 0e0b4h          ; COMM PRINT ACTIVE
CONT:   equ 0e0b5h          ; 1=CONTROL KEY ACTIVE
CPSLK:  equ 0e0b6h          ; 0=CAPS LOCK NOT ACTIVE
CURSOR: equ 0e0b7h          ; CURSOR ADDRESS
DLMENA: equ 0e0b9h          ; DELIMETER ENABLED
DRVADD: equ 0e0bah          ; 0= DRIVER NOT LOADED, ELSE ADDRESS OF
;                           ; DRIVER
DSPDIS: equ 0e0bch          ; DISPLAY DISABLED
ERROR:  equ 0e0bdh          ; 2**8 = SECURITY CODE INCORRECT
FLAG1:  equ 0e0beh          ; FLAG WORD 1
STOCR:  equ 01h             ; 2**0 SEND TOP TO CURSOR
AUTOFT: equ 02h             ; 2**1 AUTO FIELD TABBING
CBLKMD: equ 04h             ; 2**2 CLEAR KEY TO EXIT BLOCK MODE
BAUDCH: equ 08h             ; 2**3 BAUD RATE HAS CHANGED
PTXOFF: equ 10H             ; 2**4 PRINTER XOFF RECEIVED
HLCDIS: equ 20h             ; 2**5 HOST LOADED CODES DISABLED
PNTBLD: equ 40h             ; 2**6 PRINT B IS BEING LOADED
EXTATT: equ 80h             ; 2**7 EXTEND ATTRIBUTES ON CLEAR

FLAG2:  equ 0e0bfh          ; FLAG WORD 2
FLDSCR: equ 01h             ; 2**0 FIELD SCROLL ACTIVE
SRDOWN: equ 02h             ; 2**1 SCROLL DOWN
TABFLG: equ 04h             ; 2**2 TAB SEARCH FLAG
ALLPROT: equ 08h            ; 2**3 ALL PAGE IS PROTECTED
OLDATT: equ 10h             ; 2**4 USE OLD ATTRIBUTES

GRACHR: equ 0e0c0h          ; GRAPHIC CHARACTERS
GRCHR:  equ 01h             ; 2**0 GRAPHIC CHR ENABLED
RAMCHR: equ 02h             ; 2**1 RAM CHR ENABLED

HDCSER: equ 0e0c1h          ; HOST DEFINED CODE SEQUENCE
HMSGA:  equ 0e0c2h          ; HOST MESSAGE ACTIVE
HMSGSV: equ 0e0c3h          ; HOST MESSAGE STORAGE
EAANSW: equ 20h             ; 2**5 ENABLE AUTO ANSWER
BIDACT: equ 40h             ; 2**6 BIDIRECTIONAL DATA ACTIVE
SDOHLC: equ 80h             ; 2**7 SEND AND DO HOST LOADED CODES
INDON:  equ 0e0c7h          ; INDICATOR ON ACTIVE
KBCODE: equ 0e0c8h          ; KEYBOARD CODE FROM TABLE
KBINP:  equ 0e0c9h          ; 1=KEYBOARD INPUT ACTIVE
KBLKD:  equ 0e0cah          ; 2**0=KEYBOARD LOCKED
;                             2**1=COMM LOCKED
FLAG3:  equ 0e0cbh          ; NOT USED
AAACT:  equ 01h             ; 2**0 AUTO ANSWER ACTIVE
BIXOFF: equ 02h             ; 2**1 BIDIRECTIONAL X-OFF RECEIVED
LASTKY: equ 0e0cch          ; LAST KEY FROM KEYBOARD
LASTLN: equ 0e0cdh          ; LAST LINE, 23 or 29
LIGHTS: equ 0e0ceh          ; CURRENT LIGHTS, 1=ON 0=OFF
LOCK:   equ 0e0cfh          ; 1 = FIRST TIME DOWN, 2 = SECOND TIME
;                             DOWN
LOCKLT: equ 0e0d0h          ; 0 = LOCK LIGHT OFF, 2 = LOCK LIGHT ON
LNCNT:  equ 0e0d1h          ; CURRENT LINE COUNT 0-17
LNNCHG: equ 0e0d2h          ; CHANGE IN NUMBER OF LINES
LNSAV:  equ 0e0d3h          ; A PLACE TO SAVE LINE COUNT
LNSIZE: equ 0e0d4h          ; LINE SIZE, 79 or 131
MLTCNT: equ 0e0d5h          ; THE COUNTER USE WHEN MULTIPLE INPUT-
;                             ACTIVE
MLTACT: equ 0e0d6h          ; MULTIPLE CODE SEQUENCE ACTIVE
MLTADD: equ 0e0d7h          ; CALL ADDRESS STORED HERE
MODEST: equ 0e0d9h          ; MODE START IN CMOS OR RAM
PCRLF:  equ 0e0dah          ; PRINT CR, LF
PNTNXT: equ 0e0dbh          ; THIS CODE IS TO BE PRINTED NEXT
POSPRO: equ 0e0dch          ; POSITION IS PROTECTED
PRINTA: equ 0e0ddh          ; 1= PRINT ALL ACTIVE
;                             3= PRINT NORMAL ACTIVE
PROTE:  equ 0e0deh          ; PROTECT IS ENABLED
RPTACT: equ 0e0dfh          ; 1=REPEAT ACTIVE
RSRCV:  equ 0e0e0h          ; RS LAST CODE RECEIVED
RXOFF:  equ 0e0e1h          ; RECEIVED X-OFF
SAVEA:  equ 0e0e2h          ; STORAGE LOCATION A
SAVEB:  equ 0e0e3h          ; STORAGE LOCATION B
SAVEHL: equ 0e0e4h          ; STORAGE LOCATION HL
SCRSV:  equ 0e0e5h          ; STORAGE LOCATION FOR SCROLL
SHIFT:  equ 0e0e6h          ; SHIFT FLAG
SFT:    equ 01h             ; 2**0 = SHIFT KEY 1 DOWN
SFTLK:  equ 02h             ; 2**1 = SHIFT LOCK ACTIVE
SFT2:   equ 04h             ; 2**2 = SHIFT KEY 2 DOWN
SPFLAG: equ 0e0e7h          ; 1= LINE TESTED, NOT ALL SPACES TO EOL
SRLFST: equ 0e0e8h          ; 1ST LINE OF SCROLL FIELD . 0-17
SRLLST: equ 0e0e9h          ; LAST LINE OF SCROLL FIELD . 1-18
STALN:  equ 0e0eah          ; STATUS LINE ACTIVE
SXOFF:  equ 0e0ebh          ; SENT X-OFF
TABLE:  equ 0e0ech          ; 0 = ADV .TBL, 1=TABLE 1, 2=TABLE 2
TABST:  equ 0e0edh          ; 1 = TAB SET ACTIVE
TIPE:   equ 0e0eeh          ; TERMINAL INSTALLATION PARA . ENTRY
TOGAL:  equ 0e0efh          ; 2**4=0, 2**5=1, 2**6=TOGAL
TXEMPF: equ 0e0f0h          ; TRANSMIT EMPTY
XPOS:   equ 0e0f1h          ; X POSITION FROM COMM
BANKS:  equ 0e0f2h          ; CURRENT BANKS SELECTED
T3RUN:  equ 0e0f3h          ; TIMER 3 RUNNING
T3TCV:  equ 0e0f4h          ; TIMER 3 TIME CONSTANT VARIABLE
FNCODE: equ 0e0f5h          ; FUNCTION KEY CODE TO SEND AFTER
;                             BLOCK SEND
SAVECR: equ 0e0f6h          ; SAVE CURSOR POSITION FOR SEND TOP TO
;                             CURSOR
NOPTR:  equ 0e0f8h          ; NO PRINTER ASSIGNED
PTSTAT: equ 0e0f9h          ; PRINTER STATUS
COMSER: equ 01h             ; 2**1 COMM TO SERIAL PRINTER
COMPAR: equ 02h             ; 2**2 COMM TO PARALLEL ACTIVE
LOCSER: equ 04h             ; 2**3 LOCAL SERIAL PRINTER
LOCPAR: equ 08h             ; 2**4 LOCAL PARALLEL PRINTER
NOPRTI: equ 10h             ; 2**5 NO SERIAL OR PARALLEL PRINTER
SAVE8:  equ 0e0fah          ; SAVE ALL 8 BITS OF COMM INPUT

; LOAD FLAGS
LINFO:  equ 0e03ch          ; LOAD INFO
ASCIIL: equ 01h             ; ASCII LOADER
DISKL:  equ 02h             ; DISK LOADER
ROML:   equ 04h             ; ROM PACK
RS232C: equ 10h             ; USING RS232C HOST INT.
I1200:  equ 40h             ; USING INTERNAL 1200/1200
FILEN:  equ 0e0fdh          ; FILE NUMBER
MDACT:  equ 0e0feh          ; MODE ACTIVE
MD:     equ 07h             ; MODE
ERRORF: equ 0e0ffh          ; ERROR FLAG
DERROR: equ 01h             ; DIAGNOSTIC ERROR
BATTL:  equ 02h             ; BATTERY LOW
RAMEND: equ 0ffffh


; I/O PORTS
Z80CTC: equ 00h             ; 4 Timer registers at 00-03
CRT5037: equ 10h            ; 5037 CRT controller
KBDUART: equ 20h            ; Keyboard 8250 UART controller
PPIC:   equ 30h             ; 8255 Programmable Peripheral
PPIC_PORTA: equ 0           ; PPIC Port A address
PPIC_PORTB: equ 1           ; PPIC Port B address
PPIC_PORTC: equ 2           ; PPIC Port C address
PPIC_CONTROL: equ 3         ; PPIC Control Register address
;                             Interface Chip
COMMUART: equ 40h           ; COMM 8250 UART controller
LEDLATCH: equ 50h           ; LED latch
BANKSELECT: equ 70h         ; Memory Bank Select
PERIPHA:  equ 80h           ; Peripheral A 8250 UART controller
PERIPHB:  equ 90h           ; Peripheral B 8250 UART controller

	org	00000h

; Jump table for ROM routines
; From manual:
; The resident ROM firmware contains routines that
; can be used by user loaded controlware. A jump
; table has been placed at the beginning so that
; changes can be made to the resident firmware without
; requiring all eternal users to change their programs
INIT:	jp 00161h		; 000: INITIALIZATION
INIT00: jp 001f7h		; 003: INITIALIZATION00
INIT01: jp 00226h		; 006: INITIALIZATION01
INIT02: jp 0023dh		; 009: INITIALIZATION02
CRT80:	jp 002bch		; 00c: SET CRT TO 80 CHR/LINE
CRT132:	jp 002d8h		; 00f: SET CRT TO 132 CHR/LINE
CINIT:	jp 00381h		; 012: COMM INITIALIZATION
KINIT:	jp 004bdh		; 015: KEYBOARD INITIALIZATION
PINIT:  jp 00526h		; 018: PRINTER INITIALIZATION
INTDIS:	jp 005f2h		; 01b: INTERRUPT DISABLE
INTENA: jp 00601h		; 01e: INTERRUPT ENABLE
CMTRAP: jp 00617h		; 021: COMM INTERRUPT TRAP
KBTRAP: jp 006b8h		; 024: KEYBOARD INTERRUPT TRAP
TMTRAP: jp 0071eh		; 027: TIMER INTERRUPT TRAP
TPTRAP: jp 0080ah		; 02a: TOUCHPANEL INTERRUPT TRAP
ADVCR:  jp 014bdh		; 02d: ADVANCE CURSOR
ADVMD:	jp 0152fh		; 030: ADVANCED MODE
ALARM:  jp 01519h		; 033: ALARM
ALARMI: jp 01509h		; 036: ALARM IF ENABLED
BDISPN:	jp 01f4fh		; 039: DISPLAY B - PERFORM FUNCTION
BFTB:	jp 01ef8h		; 03c: COMM BUFFER TO B
BLDADD:	jp 01fcdh		; 03f: BUILD ADDRESS
CLEAR:	jp 02069h		; 042: CLEAR
CLREOL:	jp 020b8h		; 045: CLEAR TO END OF LINE
CLREOP:	jp 020bfh		; 048: CLEAR TO END OF PAGE
CRDOWN:	jp 0218dh		; 04b: CURSOR DOWN
CRGRTN:	jp 021bfh		; 04e CARRIAGE RETURN
CRLEFT:	jp 021d1h		; 051: CURSOR LEFT
CRLNFD:	jp 02201h		; 054: CARRIAGE RETURN LINE FEED
CRUP:	jp 02209h		; 057: CURSOR UP
DISPB:	jp 0221bh		; 05a: DISPLAY B - STORE ON SCREEN
DLYEN1:	jp 02290h		; 05d: DELAY ENABLE 1
DLYEN2:	jp 0229ah		; 060: DELAY ENABLE 2
DSTRNG:	jp 022a6h		; 063: DATA STRING
HASCII:	jp 01137h		; 066: HEX TO ASCII
KBDAS:	jp 025fah		; 069: CONVERT NEXT KEYBOARD CODE TO ASCII
KBDASC:	jp 02947h		; 06c: KEYBOARD TO LOWERCASE ASCII
KINPUT:	jp 02925h		; 06f: KEYBOARD INPUT
MODENE:	jp 00d9ch		; 072: DISPLAY MODE NOT ENABLED
PABI:	jp 00533h		; 075: PORT A BIDIRECTIONAL
PBBI:	jp 00544h		; 078: PORT B BIDIRECTIONAL
PRINTB:	jp 02e3fh		; 07b: PRINT B
RESET:	jp 02f3ch		; 07e: RESET
SCROLL:	jp 02f70h		; 081: SCROLL
SEND:	jp 0302fh		; 084: SEND NEXT CODE FROM COMM BUFFER
SENDB:	jp 0314ch		; 087: STORE B IN COMM SEND BUFFER
SETDE:	jp 031fbh		; 08a: SET CURSOR TO DE
SETCR:	jp 03203h		; 08d: SET CURSOR
ST_TM:	jp 0070bh		; 090: START DELAY TIMER
TABBK:	jp 0323eh		; 093: TAB BACKWARDS
TABFW:	jp 032ach		; 096: TAB FORWARDS
TABCLR:	jp 03352h		; 099: TAB CLEAR
TABSET:	jp 0334bh		; 09c: TAB SET
TPINP:	jp 00829h		; 09f: TOUCHPANEL INPUT
SENDB8:	jp 03157h		; 0a2: STORE B IN COMM SEND BUFFER
MNTOR:	jp 02d9ah		; 0a5: USER ENTRY TO MONITOR
ADVINI:	jp 0154fh		; 0a8: ADVANCED MODE INITIALIZATION
KBDINP1:	jp 02614h	; 0ab: ADVANCED MODES KEYBOARD INPUT
CMTRPU:	jp 0061ch		; 0ae: COMM INTERRUPT TRAP-USER
KBTRPU:	jp 006bdh		; 0b1: KEYBOARD INTERRUPT TRAP-USER
TMTTRPU:	jp 0072fh	; 0b4: TIMER INTERRUPT TRAP-USER
TPTRPU:	jp 0080fh		; 0b7: TOUCHPANEL INTERRUPT TRAP-USER
TIPRAM:	jp 0025dh		; 0ba: MOVE TERMINAL INSTALLATION
CRTOUT:	jp 002f6h		; 0bd: OUTPUT VALUES TO 5037 CRT CONTROLLER
ADDB15:	jp 0169ch		; 0c0: ADD BIAS OF ENABLES
BFTDSP:	jp 01f11h		; 0c3: PROCESS ONE CODE FROM COMM BUFFER
KBDLCK:	jp 02954h		; 0c6: LOCK KEYBOARD
KBDUNL:	jp 02963h		; 0c9: UNLOCK KEYBOARD
PILSR:	jp 005c1h		; 0cc: INPUT PRINTER LSR
PRINTC:	jp 02e55h		; 0cf: PRINT NEXT CHARACTER
PTTRAP:	jp 006f1h		; 0d2: PRINTER INPUT TRAP
RSETXY:	jp 02f4bh		; 0d5: RESET CURSOR TO OLD XY
SAVEXY:	jp 02f5dh		; 0d8: SAVE CURRENT XY POSITION
TBLKKY:	jp 03372h		; 0db: TEST IF BLOCK MODE + KEYBOARD INPUT
REL:	defb 033h      ; 0de: RELEASE NUMBER (ASCII)
REV:    defb 030h      ; 0df: REVISION NUMBER (ASCII)
CK1:    defb 0fah      ; 0e0: CHECKSUM

; According to the manual, there should be other
; jump table entries here, but this looks like it
; is NVRAM initialization data
; 00e1
NVRAM_INIT:
    defb 00h, 00h, 00h, 00h, 00h, 00h, 00h, 60h ; e1-e8
    defb 6ah, 00h, 00h, 00h, 00h, 00h, 00h, 10h ; e9-f0
    defb 01h, 06h, 08h, 0c6h, 40h, 00h, 00h, 00h ; f1-f8
    defb 00h, 00h, 00h, 00h, 66h, 00h, 00h, 00h ; f9-100
    defb 09h, 06h, 02h, 0c6h, 42, 00h, 00h, 00h ; 101-108
    defb 00h, 00h, 00h, 80h, 66h, 00h, 00h, 00h ; 109-110
    defb 19h, 02h, 00h, 0c6h, 52, 00h, 00h, 00h ; 111-118
    defb 00h, 00h, 00h, 00h, 66h, 00h, 00h, 00h ; 119-120
    defb 19h, 06h, 02h, 0c6h, 42h, 00h, 00h, 00h ; 121-128
    defb 00h, 00h, 00h, 00h, 66h, 00h, 00h, 00h; 129-130
    defb 01h, 05h, 00h, 44h, 12h, 00h, 00h, 00h; 131-138
    defb 00h, 00h, 00h, 00h, 99h, 00h, 00h, 00h; 139-140
    defb 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h; 141-148
    defb 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h; 149-150
    defb 34h, 05h, 0f2h, 0d4h, 44h, 94h, 35h, 0b4h; 151-158
    defb 34h, 13h, 23h, 03h, 02h, 02h, 02h, 02h; 159-160

; INIT - INITIALIZATION
	ld a,080h		;8255 bit 7 = 1 for I/O mode, all pors output
	out (PPIC+PPIC_CONTROL),a		;0163	d3 33 	. 3 
	ld sp,0e000h    ;stack at DFC0-DFFF
	call 00269h		; set up memory banks
	ld a,(0401dh)	; look up something in NV ram
	and 00fh		;016e	e6 0f 	. . 
	cp 009h		;0170	fe 09 	. . 
	jr nz,initnv	; if it wasn't zero, initialize NVRAM
	ld a,(0401eh)   ; load another value from NVRAM
	and 00fh		; look at bottom 4 bits
	cp 006h		
	jr z,skip_copy		; if bottom 4 weren't 0110, skip copy
initnv:
; Copy 80h bytes from e1h (NVRAM_INIT) to
; 4000H, the NVRAM page
	ld de,NVRAM_INIT	;017d	11 e1 00 	. . . 
	ld hl,04000h		;0180	21 00 40 	! . @ 
	ld b,080h		;0183	06 80 	. . 
initnv1:
	ld a,(de)			;0185	1a 	. 
	ld (hl),a			;0186	77 	w 
	inc hl			;0187	23 	# 
    ; It appears that maybe the NVRAM settings only
    ; care about the lower 4 bits, so 80h bytes
    ; actually fill 100h bytes of NVRAM
	rra			;0188	1f 	. 
	rra			;0189	1f 	. 
	rra			;018a	1f 	. 
	rra			;018b	1f 	. 
	ld (hl),a			;018c	77 	w 
	inc hl			;018d	23 	# 
	inc de			;018e	13 	. 
	djnz initnv1	;018f	10 f4 	. . 

;; Now that the NV ram has been copied, switch
;; pages so that 8000 points to the graphic ram bank
	ld a,030h		;0191	3e 30
	out (BANKSELECT),a		;0193	d3 70 	. p 
	ld a,099h		;0195	3e 99   try storing 99h there
	ld (08000h),a		;0197	32 00 80
	ld a,(08000h)		;019a	3a 00 80
	cp 099h		;019d	fe 99  did we get 99 back?
	jr nz,$+24		;019f	if not, there is no RAM here
	ld a,066h		;01a1	try writing 66h there
	ld (08000h),a		;01a3	32 00 80 	2 . . 
	ld a,(08000h)		;01a6	3a 00 80 	: . . 
	cp 066h		;01a9	fe 66 	did we get 66h back?
	jr nz,$+12		;01ab	20 0a if not, no RAM here
    ; set some NVRAM flags to indicate that the
    ; graphic ram page is available
	ld a,002h		;01ad	3e 02 
	ld (04000h),a		;01af	32 00 40 	2 . @ 
    ; bit 1 in 4002 (e062) is graphic option in
	ld a,001h		;01b2	3e 01 	> . 
	ld (04002h),a		;01b4	32 02 40 	2 . @ 

    ; switch pages back to default
	xor a			;01b7	af 	. 
	out (BANKSELECT),a		;01b8	d3 70 	. p 
skip_copy:
	call 0025dh		;01ba	mirror NVRAM to e060
	ld ix,001c4h		;01bd	dd 21 c4 01 	. ! . . 
    ; jump to test1(?)
	jp 03d00h		;01c1	c3 00 3d 	. . = 
	di			;01c4	f3 	. 
	ld sp,0e000h		;01c5	31 00 e0 	1 . . 
	call init_ppic		;01c8	cd 69 02 	. i . 
	ld a,(LIGHTS)		;01cb	3a ce e0 	: . . 
	push af			;01ce	f5 	. 
	call clear_buffers		;01cf	cd 7e 02 	. ~ . 
	pop af			;01d2	f1 	. 
	ld (LIGHTS),a		;01d3	32 ce e0 	2 . . 
	ld a,04fh		;01d6	3e 4f 	> O 
	ld (LNSIZE),a		;01d8	32 d4 e0 	2 . . 
	ld a,01dh		;01db	3e 1d 	> . 
	ld (LASTLN),a		;01dd	32 cd e0 	2 . . 
	call 001f7h		;01e0	cd f7 01 	. . . 
	ei			;01e3	fb 	. 
	ld a,(ERRORF)		;01e4	3a ff e0 	: . . 
	and 003h		;01e7	e6 03 	. . 
	jp nz,00c9ch		;01e9	c2 9c 0c 	. . . 
	ld a,(TBYTE4)		;01ec	3a 63 e0 	: c . 
	and 001h		;01ef	e6 01 	. . 
	jp z,00c92h		;01f1	ca 92 0c 	. . . 
	jp 00d65h		;01f4	c3 65 0d 	. e . 
	xor a			;01f7	af 	. 
	ld (T3RUN),a		;01f8	32 f3 e0 	2 . . 
	out (PPIC+PPIC_CONTROL),a		;01fb	d3 03 	. . 
	ld a,033h		;01fd	3e 33 	> 3 
	out (PPIC+PPIC_CONTROL),a		;01ff	d3 03 	. . 
	ld a,0bbh		;0201	3e bb 	> . 
	ld (T3TCV),a		;0203	32 f4 e0 	2 . . 
	call 01636h		;0206	cd 36 16 	. 6 . 
	ld hl,0086ch		;0209	21 6c 08 	! l . 
	ld de,0e100h		;020c	11 00 e1 	. . . 
	ld bc,00010h		;020f	01 10 00 	. . . 
	ldir		;0212	ed b0 	. . 
	ld a,0e1h		;0214	3e e1 	> . 
	ld i,a		;0216	ed 47 	. G 
	im 2		;0218	ed 5e 	. ^ 
	call 004bdh		;021a	cd bd 04 	. . . 
	ld a,060h		;021d	3e 60 	> ` 
	ld (INTMSK),a		;021f	32 a0 e0 	2 . . 
	cpl			;0222	2f 	/ 
	out (031h),a		;0223	d3 31 	. 1 
	ret			;0225	c9 	. 
	xor a			;0226	af 	. 
	out (020h),a		;0227	d3 20 	.   
	ld a,004h		;0229	3e 04 	> . 
	ld (OBYTE4),a		;022b	32 49 e0 	2 I . 
	call 002bch		;022e	cd bc 02 	. . . 
	ld a,002h		;0231	3e 02 	> . 
	out (033h),a		;0233	d3 33 	. 3 
	ld a,00bh		;0235	3e 0b 	> . 
	out (033h),a		;0237	d3 33 	. 3 
	ld a,008h		;0239	3e 08 	> . 
	out (033h),a		;023b	d3 33 	. 3 
	ld hl,00000h		;023d	21 00 00 	! . . 
	ld (BFCNT),hl		;0240	22 83 e0 	" . . 
	ld hl,0db20h		;0243	21 20 db 	!   . 
	ld (BFINAD),hl		;0246	22 85 e0 	" . . 
	ld (BDOTAD),hl		;0249	22 87 e0 	" . . 
	xor a			;024c	af 	. 
	ld (BLKSND),a		;024d	32 ac e0 	2 . . 
	ld (TXCNT),a		;0250	32 8e e0 	2 . . 
	ld hl,0df00h		;0253	21 00 df 	! . . 
	ld (TXINAD),hl		;0256	22 8f e0 	" . . 
	ld (TXOTAD),hl		;0259	22 91 e0 	" . . 
	ret			;025c	c9 	. 

; mirror NV ram to e060h
mirror_nvram:
	ld hl,04000h		;025d	21 00 40 	! . @ 
	ld de,TBYTE1		;0260	11 60 e0 	. ` . 
	ld bc,00020h		;0263	01 20 00 	.   . 
	ldir		;0266	ed b0 	. . 
	ret			;0268	c9 	. 
init_ppic:
; Set lower 4 bits of PPIC Port C to Input(?)
	ld a,001h		;0269	3e 01 	> . 
	out (PPIC+PPIC_CONTROL),a		;026b	d3 33 	. 3 
	xor a			; a = 0
	out (BANKSELECT),a	; bank select 0,6,5,4 (default)
	ld (BANKS),a	; store A in banks selected
	ld a,0c0h		;
	out (PPIC+PPIC_PORTA),a	; set PPIC Port a bits to 11000000
	ld a,00fh		;
	out (PPIC+PPIC_CONTROL),a
	out (0ffh),a		; ??
	ret

; This seems to zero out the areas where the buffer pointers
; and some of the host-loadable area
clear_buffers:
	ld hl,BDATAR		;027e	21 80 e0 	! . . 
	ld de,CDATAR		;0281	11 81 e0 	. . . 
	ld bc,0007bh		;0284	01 7b 00 	. { . 
	ld (hl),000h		;0287	36 00 	6 . 
	ldir		;0289	ed b0 	. . 
	ld hl,0d810h		;028b	21 10 d8 	! . . 
	ld de,0d811h		;028e	11 11 d8 	. . . 
	ld bc,002ffh		;0291	01 ff 02 	. . . 
	ld (hl),000h		;0294	36 00 	6 . 
	ldir		;0296	ed b0 	. . 
	ret			;0298	c9 	. 

	ld h,e			;0299	63 	c 
	cp (hl)			;029a	be 	. 
	ld (hl),l			;029b	75 	u 
	ld d,a			;029c	57 	W 
	dec c			;029d	0d 	. 
	dec hl			;029e	2b 	+ 
	ld bc,0be63h		;029f	01 63 be 	. c . 
	ld (hl),l			;02a2	75 	u 
	ld e,l			;02a3	5d 	] 
	dec c			;02a4	0d 	. 
	inc de			;02a5	13 	. 
	ld bc,0e79fh		;02a6	01 9f e7 	. . . 
	ld (hl),a			;02a9	77 	w 
	ld d,a			;02aa	57 	W 
	dec c			;02ab	0d 	. 
	dec hl			;02ac	2b 	+ 
	ld bc,0e79fh		;02ad	01 9f e7 	. . . 
	ld (hl),a			;02b0	77 	w 
	ld e,l			;02b1	5d 	] 
	dec c			;02b2	0d 	. 
	inc de			;02b3	13 	. 
	ld bc,0493ah		;02b4	01 3a 49 	. : I 
	ret po			;02b7	e0 	. 
	and 002h		;02b8	e6 02 	. . 
	jr nz,$+30		;02ba	20 1c 	  . 
	ld a,006h		;02bc	3e 06 	> . 
	out (033h),a		;02be	d3 33 	. 3 
	ld a,04fh		;02c0	3e 4f 	> O 
	ld (LNSIZE),a		;02c2	32 d4 e0 	2 . . 
	ld b,017h		;02c5	06 17 	. . 
	ld hl,00299h		;02c7	21 99 02 	! . . 
	ld a,(OBYTE4)		;02ca	3a 49 e0 	: I . 
	and 004h		;02cd	e6 04 	. . 
	jr z,$+35		;02cf	28 21 	( ! 
	ld b,01dh		;02d1	06 1d 	. . 
	ld hl,002a0h		;02d3	21 a0 02 	! . . 
	jr $+28		;02d6	18 1a 	. . 
	ld a,007h		;02d8	3e 07 	> . 
	out (033h),a		;02da	d3 33 	. 3 
	ld a,083h		;02dc	3e 83 	> . 
	ld (LNSIZE),a		;02de	32 d4 e0 	2 . . 
	ld b,017h		;02e1	06 17 	. . 
	ld hl,002a7h		;02e3	21 a7 02 	! . . 
	ld a,(OBYTE4)		;02e6	3a 49 e0 	: I . 
	and 004h		;02e9	e6 04 	. . 
	jr z,$+7		;02eb	28 05 	( . 
	ld b,01dh		;02ed	06 1d 	. . 
	ld hl,002aeh		;02ef	21 ae 02 	! . . 
	ld a,b			;02f2	78 	x 
	ld (LASTLN),a		;02f3	32 cd e0 	2 . . 
	xor a			;02f6	af 	. 
	out (01eh),a		;02f7	d3 1e 	. . 
	out (01ah),a		;02f9	d3 1a 	. . 
	ld c,010h		;02fb	0e 10 	. . 
	outi		;02fd	ed a3 	. . 
	inc c			;02ff	0c 	. 
	ld a,(XDELTA)		;0300	3a 67 e0 	: g . 
	bit 2,a		;0303	cb 57 	. W 
	jr z,$+10		;0305	28 08 	( . 
	and 003h		;0307	e6 03 	. . 
	rlca			;0309	07 	. 
	rlca			;030a	07 	. 
	rlca			;030b	07 	. 
	add a,(hl)			;030c	86 	. 
	jr $+7		;030d	18 05 	. . 
	and 003h		;030f	e6 03 	. . 
	ld d,a			;0311	57 	W 
	ld a,(hl)			;0312	7e 	~ 
	sub d			;0313	92 	. 
	out (c),a		;0314	ed 79 	. y 
	inc hl			;0316	23 	# 
	inc c			;0317	0c 	. 
	outi		;0318	ed a3 	. . 
	inc c			;031a	0c 	. 
	outi		;031b	ed a3 	. . 
	inc c			;031d	0c 	. 
	outi		;031e	ed a3 	. . 
	inc c			;0320	0c 	. 
	ld a,(YDELTA)		;0321	3a 68 e0 	: h . 
	bit 3,a		;0324	cb 5f 	. _ 
	jr z,$+7		;0326	28 05 	( . 
	and 007h		;0328	e6 07 	. . 
	add a,(hl)			;032a	86 	. 
	jr $+7		;032b	18 05 	. . 
	and 007h		;032d	e6 07 	. . 
	ld d,a			;032f	57 	W 
	ld a,(hl)			;0330	7e 	~ 
	sub d			;0331	92 	. 
	out (c),a		;0332	ed 79 	. y 
	inc hl			;0334	23 	# 
	inc c			;0335	0c 	. 
	outi		;0336	ed a3 	. . 
	xor a			;0338	af 	. 
	out (01ah),a		;0339	d3 1a 	. . 
	out (01eh),a		;033b	d3 1e 	. . 
	call 02069h		;033d	cd 69 20 	. i   
	ret			;0340	c9 	. 
	nop			;0341	00 	. 
	ld b,017h		;0342	06 17 	. . 
	inc b			;0344	04 	. 
	nop			;0345	00 	. 
	inc bc			;0346	03 	. 
	ld b,b			;0347	40 	@ 
	ld (bc),a			;0348	02 	. 
	add a,b			;0349	80 	. 
	ld bc,000c0h		;034a	01 c0 00 	. . . 
	ld h,b			;034d	60 	` 
	nop			;034e	00 	. 
	ld b,b			;034f	40 	@ 
	nop			;0350	00 	. 
	jr nc,$+2		;0351	30 00 	0 . 
	jr $+2		;0353	18 00 	. . 
	inc c			;0355	0c 	. 
	nop			;0356	00 	. 
	ld b,000h		;0357	06 00 	. . 
	ld b,000h		;0359	06 00 	. . 
	ld b,000h		;035b	06 00 	. . 
	ld b,000h		;035d	06 00 	. . 
	ld b,000h		;035f	06 00 	. . 
	ex af,af'			;0361	08 	. 
	ret nz			;0362	c0 	. 
	ex af,af'			;0363	08 	. 
	add a,e			;0364	83 	. 
	ex af,af'			;0365	08 	. 
	ld h,b			;0366	60 	` 
	ex af,af'			;0367	08 	. 
	ld c,b			;0368	48 	H 
	ld (bc),a			;0369	02 	. 
	ret nz			;036a	c0 	. 
	ld (bc),a			;036b	02 	. 
	ld h,b			;036c	60 	` 
	ld (bc),a			;036d	02 	. 
	jr nc,$+4		;036e	30 02 	0 . 
	jr nz,$+4		;0370	20 02 	  . 
	jr $+4		;0372	18 02 	. . 
	inc c			;0374	0c 	. 
	ld (bc),a			;0375	02 	. 
	ld b,002h		;0376	06 02 	. . 
	inc bc			;0378	03 	. 
	ld (bc),a			;0379	02 	. 
	inc bc			;037a	03 	. 
	ld (bc),a			;037b	02 	. 
	inc bc			;037c	03 	. 
	ld (bc),a			;037d	02 	. 
	inc bc			;037e	03 	. 
	ld (bc),a			;037f	02 	. 
	inc bc			;0380	03 	. 
	ld de,00617h		;0381	11 17 06 	. . . 
	ld b,002h		;0384	06 02 	. . 
	ld c,001h		;0386	0e 01 	. . 
	ld h,040h		;0388	26 40 	& @ 
	ld l,0c0h		;038a	2e c0 	. . 
	ld a,(MBYTE2)		;038c	3a 41 e0 	: A . 
	and 002h		;038f	e6 02 	. . 
	jr z,$+17		;0391	28 0f 	( . 
	ld a,(TBYTE2)		;0393	3a 61 e0 	: a . 
	and 004h		;0396	e6 04 	. . 
	jr nz,$+18		;0398	20 10 	  . 
	pop hl			;039a	e1 	. 
	ei			;039b	fb 	. 
	call 00226h		;039c	cd 26 02 	. & . 
	jp 00d9ch		;039f	c3 9c 0d 	. . . 
	ld b,001h		;03a2	06 01 	. . 
	ld c,000h		;03a4	0e 00 	. . 
	ld h,010h		;03a6	26 10 	& . 
	ld l,040h		;03a8	2e 40 	. @ 
	call 00601h		;03aa	cd 01 06 	. . . 
	ld c,l			;03ad	4d 	M 
	ld a,(0e0fch)		;03ae	3a fc e0 	: . . 
	and 00fh		;03b1	e6 0f 	. . 
	or h			;03b3	b4 	. 
	ld (0e0fch),a		;03b4	32 fc e0 	2 . . 
	ld hl,CDATAR		;03b7	21 81 e0 	! . . 
	ld a,(TBAUD)		;03ba	3a 58 e0 	: X . 
	ld b,a			;03bd	47 	G 
	call 0043dh		;03be	cd 3d 04 	. = . 
	ld a,057h		;03c1	3e 57 	> W 
	out (001h),a		;03c3	d3 01 	. . 
	ld a,(RBAUD)		;03c5	3a 59 e0 	: Y . 
	and 00fh		;03c8	e6 0f 	. . 
	rlca			;03ca	07 	. 
	ld hl,00361h		;03cb	21 61 03 	! a . 
	ld e,a			;03ce	5f 	_ 
	ld d,000h		;03cf	16 00 	. . 
	add hl,de			;03d1	19 	. 
	ld a,(hl)			;03d2	7e 	~ 
	out (001h),a		;03d3	d3 01 	. . 
	ld a,057h		;03d5	3e 57 	> W 
	out (002h),a		;03d7	d3 02 	. . 
	inc hl			;03d9	23 	# 
	ld a,(hl)			;03da	7e 	~ 
	out (002h),a		;03db	d3 02 	. . 
	ld b,002h		;03dd	06 02 	. . 
	ld a,(MBYTE3)		;03df	3a 42 e0 	: B . 
	bit 0,a		;03e2	cb 47 	. G 
	jr z,$+4		;03e4	28 02 	( . 
	set 0,b		;03e6	cb c0 	. . 
	bit 1,a		;03e8	cb 4f 	. O 
	jr z,$+4		;03ea	28 02 	( . 
	set 3,b		;03ec	cb d8 	. . 
	bit 2,a		;03ee	cb 57 	. W 
	jr z,$+4		;03f0	28 02 	( . 
	set 4,b		;03f2	cb e0 	. . 
	bit 3,a		;03f4	cb 5f 	. _ 
	jr z,$+4		;03f6	28 02 	( . 
	set 2,b		;03f8	cb d0 	. . 
	call 004abh		;03fa	cd ab 04 	. . . 
	ld b,005h		;03fd	06 05 	. . 
	ld a,(CDATAR)		;03ff	3a 81 e0 	: . . 
	add a,001h		;0402	c6 01 	. . 
	ld c,a			;0404	4f 	O 
	out (c),b		;0405	ed 41 	. A 
	call 00422h		;0407	cd 22 04 	. " . 
	call 00491h		;040a	cd 91 04 	. . . 
	call 00491h		;040d	cd 91 04 	. . . 
	call 00499h		;0410	cd 99 04 	. . . 
	call 00417h		;0413	cd 17 04 	. . . 
	ret			;0416	c9 	. 
	push hl			;0417	e5 	. 
	ld hl,000ffh		;0418	21 ff 00 	! . . 
	dec hl			;041b	2b 	+ 
	ld a,h			;041c	7c 	| 
	or l			;041d	b5 	. 
	jr nz,$-3		;041e	20 fb 	  . 
	pop hl			;0420	e1 	. 
	ret			;0421	c9 	. 
	ld a,(LIGHTS)		;0422	3a ce e0 	: . . 
	and 07fh		;0425	e6 7f 	.  
	ld b,a			;0427	47 	G 
	call 004a1h		;0428	cd a1 04 	. . . 
	and 020h		;042b	e6 20 	.   
	ld (CCDSR),a		;042d	32 ae e0 	2 . . 
	rlca			;0430	07 	. 
	rlca			;0431	07 	. 
	or b			;0432	b0 	. 
	ld (LIGHTS),a		;0433	32 ce e0 	2 . . 
	cpl			;0436	2f 	/ 
	out (050h),a		;0437	d3 50 	. P 
	call 0045ch		;0439	cd 5c 04 	. \ . 
	ret			;043c	c9 	. 
	ld (hl),c			;043d	71 	q 
	push bc			;043e	c5 	. 
	ld b,080h		;043f	06 80 	. . 
	ld a,003h		;0441	3e 03 	> . 
	or c			;0443	b1 	. 
	ld c,a			;0444	4f 	O 
	out (c),b		;0445	ed 41 	. A 
	pop bc			;0447	c1 	. 
	ld a,b			;0448	78 	x 
	and 00fh		;0449	e6 0f 	. . 
	rlca			;044b	07 	. 
	ld hl,00341h		;044c	21 41 03 	! A . 
	ld e,a			;044f	5f 	_ 
	ld d,000h		;0450	16 00 	. . 
	add hl,de			;0452	19 	. 
	ld b,(hl)			;0453	46 	F 
	out (c),b		;0454	ed 41 	. A 
	inc hl			;0456	23 	# 
	ld b,(hl)			;0457	46 	F 
	inc c			;0458	0c 	. 
	out (c),b		;0459	ed 41 	. A 
	ret			;045b	c9 	. 
	ld a,(MBYTE4)		;045c	3a 43 e0 	: C . 
	and 001h		;045f	e6 01 	. . 
	jr z,$+13		;0461	28 0b 	( . 
	ld a,(OBYTE1)		;0463	3a 46 e0 	: F . 
	and 001h		;0466	e6 01 	. . 
	jr z,$+6		;0468	28 04 	( . 
	ld b,000h		;046a	06 00 	. . 
	jr $+29		;046c	18 1b 	. . 
	ld b,001h		;046e	06 01 	. . 
	ld a,(OBYTE4)		;0470	3a 49 e0 	: I . 
	and 001h		;0473	e6 01 	. . 
	jr nz,$+9		;0475	20 07 	  . 
	ld a,(MBYTE4)		;0477	3a 43 e0 	: C . 
	and 002h		;047a	e6 02 	. . 
	jr nz,$+13		;047c	20 0b 	  . 
	call 004a1h		;047e	cd a1 04 	. . . 
	and 020h		;0481	e6 20 	.   
	jr z,$+6		;0483	28 04 	( . 
	ld a,002h		;0485	3e 02 	> . 
	or b			;0487	b0 	. 
	ld b,a			;0488	47 	G 
	ld a,004h		;0489	3e 04 	> . 
	or b			;048b	b0 	. 
	ld b,a			;048c	47 	G 
	call 004afh		;048d	cd af 04 	. . . 
	ret			;0490	c9 	. 
	ld c,000h		;0491	0e 00 	. . 
	jr $+16		;0493	18 0e 	. . 
	ld c,003h		;0495	0e 03 	. . 
	jr $+12		;0497	18 0a 	. . 
	ld c,005h		;0499	0e 05 	. . 
	jr $+8		;049b	18 06 	. . 
	ld c,004h		;049d	0e 04 	. . 
	jr $+4		;049f	18 02 	. . 
	ld c,006h		;04a1	0e 06 	. . 
	ld a,(CDATAR)		;04a3	3a 81 e0 	: . . 
	add a,c			;04a6	81 	. 
	ld c,a			;04a7	4f 	O 
	in a,(c)		;04a8	ed 78 	. x 
	ret			;04aa	c9 	. 
	ld c,003h		;04ab	0e 03 	. . 
	jr $+8		;04ad	18 06 	. . 
	ld c,004h		;04af	0e 04 	. . 
	jr $+4		;04b1	18 02 	. . 
	ld c,000h		;04b3	0e 00 	. . 
	ld a,(CDATAR)		;04b5	3a 81 e0 	: . . 
	add a,c			;04b8	81 	. 
	ld c,a			;04b9	4f 	O 
	out (c),b		;04ba	ed 41 	. A 
	ret			;04bc	c9 	. 
	xor a			;04bd	af 	. 
	ld (KBCNT),a		;04be	32 89 e0 	2 . . 
	ld hl,0db10h		;04c1	21 10 db 	! . . 
	ld (KBINAD),hl		;04c4	22 8a e0 	" . . 
	ld (KBOTAD),hl		;04c7	22 8c e0 	" . . 
	ld a,080h		;04ca	3e 80 	> . 
	out (023h),a		;04cc	d3 23 	. # 
	ld a,00ch		;04ce	3e 0c 	> . 
	out (020h),a		;04d0	d3 20 	.   
	ld a,000h		;04d2	3e 00 	> . 
	out (021h),a		;04d4	d3 21 	. ! 
	ld a,00bh		;04d6	3e 0b 	> . 
	out (023h),a		;04d8	d3 23 	. # 
	ld a,001h		;04da	3e 01 	> . 
	out (021h),a		;04dc	d3 21 	. ! 
	ld b,000h		;04de	06 00 	. . 
	ld a,(LANG)		;04e0	3a 69 e0 	: i . 
	bit 0,a		;04e3	cb 47 	. G 
	jr nz,$+4		;04e5	20 02 	  . 
	set 3,b		;04e7	cb d8 	. . 
	bit 1,a		;04e9	cb 4f 	. O 
	jr nz,$+4		;04eb	20 02 	  . 
	set 2,b		;04ed	cb d0 	. . 
	bit 2,a		;04ef	cb 57 	. W 
	jr nz,$+4		;04f1	20 02 	  . 
	set 0,b		;04f3	cb c0 	. . 
	ld a,(OBYTE1)		;04f5	3a 46 e0 	: F . 
	and 008h		;04f8	e6 08 	. . 
	jr z,$+4		;04fa	28 02 	( . 
	set 1,b		;04fc	cb c8 	. . 
	ld a,b			;04fe	78 	x 
	out (024h),a		;04ff	d3 24 	. $ 
	call 02963h		;0501	cd 63 29 	. c ) 
	call 00518h		;0504	cd 18 05 	. . . 
	in a,(025h)		;0507	db 25 	. % 
	and 01fh		;0509	e6 1f 	. . 
	ret z			;050b	c8 	. 
	in a,(020h)		;050c	db 20 	.   
	jr $-7		;050e	18 f7 	. . 
	di			;0510	f3 	. 
	add hl,hl			;0511	29 	) 
	add a,e			;0512	83 	. 
	ld hl,(02b13h)		;0513	2a 13 2b 	* . + 
	and e			;0516	a3 	. 
	dec hl			;0517	2b 	+ 
	push bc			;0518	c5 	. 
	ld hl,00510h		;0519	21 10 05 	! . . 
	ld de,KNSNC		;051c	11 a1 e0 	. . . 
	ld bc,00008h		;051f	01 08 00 	. . . 
	ldir		;0522	ed b0 	. . 
	pop bc			;0524	c1 	. 
	ret			;0525	c9 	. 
	ld hl,PDATAR		;0526	21 82 e0 	! . . 
	ld a,(CHAPAR)		;0529	3a 6e e0 	: n . 
	ld (SAVEA),a		;052c	32 e2 e0 	2 . . 
	and 008h		;052f	e6 08 	. . 
	jr nz,$+9		;0531	20 07 	  . 
	ld c,080h		;0533	0e 80 	. . 
	ld a,(CHABD)		;0535	3a 6f e0 	: o . 
	jr $+17		;0538	18 0f 	. . 
	ld a,(CHBPAR)		;053a	3a 70 e0 	: p . 
	ld (SAVEA),a		;053d	32 e2 e0 	2 . . 
	and 008h		;0540	e6 08 	. . 
	jr nz,$+77		;0542	20 4b 	  K 
	ld c,090h		;0544	0e 90 	. . 
	ld a,(CHBBD)		;0546	3a 71 e0 	: q . 
	ld b,a			;0549	47 	G 
	ld a,c			;054a	79 	y 
	ld (SAVEB),a		;054b	32 e3 e0 	2 . . 
	call 0043dh		;054e	cd 3d 04 	. = . 
	ld hl,SAVEB		;0551	21 e3 e0 	! . . 
	ld b,003h		;0554	06 03 	. . 
	ld a,(SAVEA)		;0556	3a e2 e0 	: . . 
	and 004h		;0559	e6 04 	. . 
	jr nz,$+4		;055b	20 02 	  . 
	ld b,00ah		;055d	06 0a 	. . 
	ld a,(SAVEA)		;055f	3a e2 e0 	: . . 
	and 002h		;0562	e6 02 	. . 
	jr z,$+6		;0564	28 04 	( . 
	ld a,010h		;0566	3e 10 	> . 
	or b			;0568	b0 	. 
	ld b,a			;0569	47 	G 
	ld a,(SAVEA)		;056a	3a e2 e0 	: . . 
	and 001h		;056d	e6 01 	. . 
	jr z,$+6		;056f	28 04 	( . 
	ld a,004h		;0571	3e 04 	> . 
	or b			;0573	b0 	. 
	ld b,a			;0574	47 	G 
	ld a,003h		;0575	3e 03 	> . 
	or (hl)			;0577	b6 	. 
	ld c,a			;0578	4f 	O 
	out (c),b		;0579	ed 41 	. A 
	ld b,007h		;057b	06 07 	. . 
	ld a,004h		;057d	3e 04 	> . 
	or (hl)			;057f	b6 	. 
	ld c,a			;0580	4f 	O 
	out (c),b		;0581	ed 41 	. A 
	ld b,000h		;0583	06 00 	. . 
	ld a,001h		;0585	3e 01 	> . 
	or (hl)			;0587	b6 	. 
	ld c,a			;0588	4f 	O 
	out (c),b		;0589	ed 41 	. A 
	call 00417h		;058b	cd 17 04 	. . . 
	ret			;058e	c9 	. 
	ld a,(OBYTE1)		;058f	3a 46 e0 	: F . 
	and 0fdh		;0592	e6 fd 	. . 
	ld (OBYTE1),a		;0594	32 46 e0 	2 F . 
	ld a,001h		;0597	3e 01 	> . 
	ld (NOPTR),a		;0599	32 f8 e0 	2 . . 
	ret			;059c	c9 	. 
	ld a,(BDATAR)		;059d	3a 80 e0 	: . . 
	jr $+45		;05a0	18 2b 	. + 
	ld a,(BDATAR)		;05a2	3a 80 e0 	: . . 
	add a,005h		;05a5	c6 05 	. . 
	jr $+38		;05a7	18 24 	. $ 
	ld a,(BDATAR)		;05a9	3a 80 e0 	: . . 
	add a,006h		;05ac	c6 06 	. . 
	jr $+31		;05ae	18 1d 	. . 
	ld a,(BDATAR)		;05b0	3a 80 e0 	: . . 
	jr $+33		;05b3	18 1f 	. . 
	ld a,(BDATAR)		;05b5	3a 80 e0 	: . . 
	add a,001h		;05b8	c6 01 	. . 
	jr $+26		;05ba	18 18 	. . 
	ld a,(PDATAR)		;05bc	3a 82 e0 	: . . 
	jr $+14		;05bf	18 0c 	. . 
	ld a,(PDATAR)		;05c1	3a 82 e0 	: . . 
	add a,005h		;05c4	c6 05 	. . 
	jr $+7		;05c6	18 05 	. . 
	ld a,(PDATAR)		;05c8	3a 82 e0 	: . . 
	add a,006h		;05cb	c6 06 	. . 
	ld c,a			;05cd	4f 	O 
	in a,(c)		;05ce	ed 78 	. x 
	ret			;05d0	c9 	. 
	ld a,(PDATAR)		;05d1	3a 82 e0 	: . . 
	ld c,a			;05d4	4f 	O 
	push bc			;05d5	c5 	. 
	cp 080h		;05d6	fe 80 	. . 
	jr nz,$+7		;05d8	20 05 	  . 
	ld a,(CHAPAR)		;05da	3a 6e e0 	: n . 
	jr $+9		;05dd	18 07 	. . 
	cp 090h		;05df	fe 90 	. . 
	jr nz,$+13		;05e1	20 0b 	  . 
	ld a,(CHBPAR)		;05e3	3a 70 e0 	: p . 
	res 7,b		;05e6	cb b8 	. . 
	and 002h		;05e8	e6 02 	. . 
	jr z,$+4		;05ea	28 02 	( . 
	set 7,b		;05ec	cb f8 	. . 
	out (c),b		;05ee	ed 41 	. A 
	pop bc			;05f0	c1 	. 
	ret			;05f1	c9 	. 
	push hl			;05f2	e5 	. 
	ld a,b			;05f3	78 	x 
	cpl			;05f4	2f 	/ 
	ld hl,INTMSK		;05f5	21 a0 e0 	! . . 
	and (hl)			;05f8	a6 	. 
	ld (INTMSK),a		;05f9	32 a0 e0 	2 . . 
	cpl			;05fc	2f 	/ 
	out (031h),a		;05fd	d3 31 	. 1 
	pop hl			;05ff	e1 	. 
	ret			;0600	c9 	. 
	push hl			;0601	e5 	. 
	ld a,c			;0602	79 	y 
	rlca			;0603	07 	. 
	ld h,0e1h		;0604	26 e1 	& . 
	ld l,a			;0606	6f 	o 
	ld (hl),e			;0607	73 	s 
	inc hl			;0608	23 	# 
	ld (hl),d			;0609	72 	r 
	ld a,b			;060a	78 	x 
	ld hl,INTMSK		;060b	21 a0 e0 	! . . 
	or (hl)			;060e	b6 	. 
	ld (INTMSK),a		;060f	32 a0 e0 	2 . . 
	cpl			;0612	2f 	/ 
	out (031h),a		;0613	d3 31 	. 1 
	pop hl			;0615	e1 	. 
	ret			;0616	c9 	. 
	call 0061ch		;0617	cd 1c 06 	. . . 
	ei			;061a	fb 	. 
	ret			;061b	c9 	. 
	push af			;061c	f5 	. 
	push bc			;061d	c5 	. 
	push de			;061e	d5 	. 
	push hl			;061f	e5 	. 
	ld a,(CDATAR)		;0620	3a 81 e0 	: . . 
	add a,004h		;0623	c6 04 	. . 
	ld c,a			;0625	4f 	O 
	in h,(c)		;0626	ed 60 	. ` 
	inc c			;0628	0c 	. 
	in d,(c)		;0629	ed 50 	. P 
	inc c			;062b	0c 	. 
	in e,(c)		;062c	ed 58 	. X 
	ld a,c			;062e	79 	y 
	and 0f0h		;062f	e6 f0 	. . 
	ld c,a			;0631	4f 	O 
	in b,(c)		;0632	ed 40 	. @ 
	ld a,h			;0634	7c 	| 
	and 001h		;0635	e6 01 	. . 
	jr z,$+96		;0637	28 5e 	( ^ 
	ld a,(MBYTE4)		;0639	3a 43 e0 	: C . 
	and 008h		;063c	e6 08 	. . 
	jr nz,$+26		;063e	20 18 	  . 
	ld a,e			;0640	7b 	{ 
	and 020h		;0641	e6 20 	.   
	jr z,$+84		;0643	28 52 	( R 
	ld a,e			;0645	7b 	{ 
	and 080h		;0646	e6 80 	. . 
	jr nz,$+16		;0648	20 0e 	  . 
	ld a,(MBYTE4)		;064a	3a 43 e0 	: C . 
	and 002h		;064d	e6 02 	. . 
	jr z,$+9		;064f	28 07 	( . 
	ld a,(OBYTE4)		;0651	3a 49 e0 	: I . 
	and 001h		;0654	e6 01 	. . 
	jr z,$+65		;0656	28 3f 	( ? 
	ld a,d			;0658	7a 	z 
	and 010h		;0659	e6 10 	. . 
	jr z,$+13		;065b	28 0b 	( . 
	call 01519h		;065d	cd 19 15 	. . . 
	call 0045ch		;0660	cd 5c 04 	. \ . 
	call 0024ch		;0663	cd 4c 02 	. L . 
	jr $+7		;0666	18 05 	. . 
	ld a,d			;0668	7a 	z 
	and 00eh		;0669	e6 0e 	. . 
	jr z,$+4		;066b	28 02 	( . 
	ld b,0ffh		;066d	06 ff 	. . 
	ld hl,(BFCNT)		;066f	2a 83 e0 	* . . 
	inc hl			;0672	23 	# 
	ld a,h			;0673	7c 	| 
	cp 003h		;0674	fe 03 	. . 
	jr nz,$+14		;0676	20 0c 	  . 
	push hl			;0678	e5 	. 
	push bc			;0679	c5 	. 
	call 01deah		;067a	cd ea 1d 	. . . 
	pop bc			;067d	c1 	. 
	pop hl			;067e	e1 	. 
	ld a,l			;067f	7d 	} 
	cp 0dfh		;0680	fe df 	. . 
	jr z,$+21		;0682	28 13 	( . 
	ld (BFCNT),hl		;0684	22 83 e0 	" . . 
	ld hl,(BFINAD)		;0687	2a 85 e0 	* . . 
	ld (hl),b			;068a	70 	p 
	inc hl			;068b	23 	# 
	ld a,h			;068c	7c 	| 
	cp 0dfh		;068d	fe df 	. . 
	jr nz,$+5		;068f	20 03 	  . 
	ld hl,0db20h		;0691	21 20 db 	!   . 
	ld (BFINAD),hl		;0694	22 85 e0 	" . . 
	pop hl			;0697	e1 	. 
	pop de			;0698	d1 	. 
	pop bc			;0699	c1 	. 
	pop af			;069a	f1 	. 
	ret			;069b	c9 	. 
	call 006a1h		;069c	cd a1 06 	. . . 
	ei			;069f	fb 	. 
	ret			;06a0	c9 	. 
	push af			;06a1	f5 	. 
	push bc			;06a2	c5 	. 
	push de			;06a3	d5 	. 
	call 0059dh		;06a4	cd 9d 05 	. . . 
	ld b,a			;06a7	47 	G 
	call 005a2h		;06a8	cd a2 05 	. . . 
	and 01eh		;06ab	e6 1e 	. . 
	jr z,$+4		;06ad	28 02 	( . 
	ld b,07fh		;06af	06 7f 	.  
	call 0314ch		;06b1	cd 4c 31 	. L 1 
	pop de			;06b4	d1 	. 
	pop bc			;06b5	c1 	. 
	pop af			;06b6	f1 	. 
	ret			;06b7	c9 	. 
	call 006bdh		;06b8	cd bd 06 	. . . 
	ei			;06bb	fb 	. 
	ret			;06bc	c9 	. 
	push af			;06bd	f5 	. 
	push bc			;06be	c5 	. 
	push hl			;06bf	e5 	. 
	in a,(025h)		;06c0	db 25 	. % 
	ld b,a			;06c2	47 	G 
	and 01eh		;06c3	e6 1e 	. . 
	jr nz,$+37		;06c5	20 23 	  # 
	ld a,b			;06c7	78 	x 
	and 001h		;06c8	e6 01 	. . 
	jr z,$+32		;06ca	28 1e 	( . 
	ld hl,(KBINAD)		;06cc	2a 8a e0 	* . . 
	in a,(020h)		;06cf	db 20 	.   
	cp 067h		;06d1	fe 67 	. g 
	jr z,$+26		;06d3	28 18 	( . 
	cp 0e7h		;06d5	fe e7 	. . 
	jr z,$+22		;06d7	28 14 	( . 
	ld (hl),a			;06d9	77 	w 
	inc hl			;06da	23 	# 
	ld a,l			;06db	7d 	} 
	cp 020h		;06dc	fe 20 	.   
	jr nz,$+5		;06de	20 03 	  . 
	ld hl,0db10h		;06e0	21 10 db 	! . . 
	ld (KBINAD),hl		;06e3	22 8a e0 	" . . 
	ld hl,KBCNT		;06e6	21 89 e0 	! . . 
	inc (hl)			;06e9	34 	4 
	call 00507h		;06ea	cd 07 05 	. . . 
	pop hl			;06ed	e1 	. 
	pop bc			;06ee	c1 	. 
	pop af			;06ef	f1 	. 
	ret			;06f0	c9 	. 
	call 005bch		;06f1	cd bc 05 	. . . 
	cp 011h		;06f4	fe 11 	. . 
	jr z,$+16		;06f6	28 0e 	( . 
	cp 013h		;06f8	fe 13 	. . 
	ret nz			;06fa	c0 	. 
	ld a,(OBYTE1)		;06fb	3a 46 e0 	: F . 
	and 002h		;06fe	e6 02 	. . 
	jr z,$+6		;0700	28 04 	( . 
	ld a,001h		;0702	3e 01 	> . 
	jr $+3		;0704	18 01 	. . 
	xor a			;0706	af 	. 
	ld (0e0f7h),a		;0707	32 f7 e0 	2 . . 
	ret			;070a	c9 	. 
	ld a,(T3RUN)		;070b	3a f3 e0 	: . . 
	and a			;070e	a7 	. 
	ret nz			;070f	c0 	. 
	inc a			;0710	3c 	< 
	ld (T3RUN),a		;0711	32 f3 e0 	2 . . 
	ld a,0b7h		;0714	3e b7 	> . 
	out (PPIC+PPIC_CONTROL),a		;0716	d3 03 	. . 
	ld a,(T3TCV)		;0718	3a f4 e0 	: . . 
	out (PPIC+PPIC_CONTROL),a		;071b	d3 03 	. . 
	ret			;071d	c9 	. 
	push af			;071e	f5 	. 
	push bc			;071f	c5 	. 
	push de			;0720	d5 	. 
	push hl			;0721	e5 	. 
	ld a,033h		;0722	3e 33 	> 3 
	out (PPIC+PPIC_CONTROL),a		;0724	d3 03 	. . 
	ei			;0726	fb 	. 
	call 00733h		;0727	cd 33 07 	. 3 . 
	pop hl			;072a	e1 	. 
	pop de			;072b	d1 	. 
	pop bc			;072c	c1 	. 
	pop af			;072d	f1 	. 
	ret			;072e	c9 	. 
	ld a,033h		;072f	3e 33 	> 3 
	out (PPIC+PPIC_CONTROL),a		;0731	d3 03 	. . 
	xor a			;0733	af 	. 
	ld (T3RUN),a		;0734	32 f3 e0 	2 . . 
	ld a,(UD2ACT)		;0737	3a 9d e0 	: . . 
	and a			;073a	a7 	. 
	jr z,$+19		;073b	28 11 	( . 
	dec a			;073d	3d 	= 
	ld (UD2ACT),a		;073e	32 9d e0 	2 . . 
	jr nz,$+10		;0741	20 08 	  . 
	ld hl,(UD2ADD)		;0743	2a 9e e0 	* . . 
	call 022f6h		;0746	cd f6 22 	. . " 
	jr $+5		;0749	18 03 	. . 
	call 0070bh		;074b	cd 0b 07 	. . . 
	ld a,(KBDACT)		;074e	3a 95 e0 	: . . 
	and a			;0751	a7 	. 
	jr z,$+16		;0752	28 0e 	( . 
	dec a			;0754	3d 	= 
	ld (KBDACT),a		;0755	32 95 e0 	2 . . 
	jr nz,$+7		;0758	20 05 	  . 
	ld a,008h		;075a	3e 08 	> . 
	ld (KBRACT),a		;075c	32 96 e0 	2 . . 
	call 0070bh		;075f	cd 0b 07 	. . . 
	ld a,(KBRACT)		;0762	3a 96 e0 	: . . 
	and a			;0765	a7 	. 
	jr z,$+31		;0766	28 1d 	( . 
	dec a			;0768	3d 	= 
	ld (KBRACT),a		;0769	32 96 e0 	2 . . 
	jr nz,$+22		;076c	20 14 	  . 
	ld a,(LOCKLT)		;076e	3a d0 e0 	: . . 
	or 001h		;0771	f6 01 	. . 
	out (020h),a		;0773	d3 20 	.   
	call 026f6h		;0775	cd f6 26 	. . & 
	ld a,(LOCKLT)		;0778	3a d0 e0 	: . . 
	out (020h),a		;077b	d3 20 	.   
	ld a,008h		;077d	3e 08 	> . 
	ld (KBRACT),a		;077f	32 96 e0 	2 . . 
	call 0070bh		;0782	cd 0b 07 	. . . 
	ld a,(ALRACT)		;0785	3a 93 e0 	: . . 
	and a			;0788	a7 	. 
	jr z,$+17		;0789	28 0f 	( . 
	dec a			;078b	3d 	= 
	ld (ALRACT),a		;078c	32 93 e0 	2 . . 
	jr nz,$+8		;078f	20 06 	  . 
	ld a,001h		;0791	3e 01 	> . 
	out (033h),a		;0793	d3 33 	. 3 
	jr $+5		;0795	18 03 	. . 
	call 0070bh		;0797	cd 0b 07 	. . . 
	ld a,(TXDACT)		;079a	3a 99 e0 	: . . 
	and a			;079d	a7 	. 
	jr z,$+9		;079e	28 07 	( . 
	xor a			;07a0	af 	. 
	ld (TXDACT),a		;07a1	32 99 e0 	2 . . 
	call 03188h		;07a4	cd 88 31 	. . 1 
	ld a,(PNTACT)		;07a7	3a 98 e0 	: . . 
	and a			;07aa	a7 	. 
	jr z,$+11		;07ab	28 09 	( . 
	dec a			;07ad	3d 	= 
	ld (PNTACT),a		;07ae	32 98 e0 	2 . . 
	jr z,$+5		;07b1	28 03 	( . 
	call 0070bh		;07b3	cd 0b 07 	. . . 
	ld a,(PCDACT)		;07b6	3a 97 e0 	: . . 
	and a			;07b9	a7 	. 
	jr z,$+6		;07ba	28 04 	( . 
	xor a			;07bc	af 	. 
	ld (PCDACT),a		;07bd	32 97 e0 	2 . . 
	ld a,(BRKACT)		;07c0	3a 94 e0 	: . . 
	and a			;07c3	a7 	. 
	jr z,$+16		;07c4	28 0e 	( . 
	dec a			;07c6	3d 	= 
	ld (BRKACT),a		;07c7	32 94 e0 	2 . . 
	jr nz,$+7		;07ca	20 05 	  . 
	call 003ddh		;07cc	cd dd 03 	. . . 
	jr $+5		;07cf	18 03 	. . 
	call 0070bh		;07d1	cd 0b 07 	. . . 
	ld a,(UD1ACT)		;07d4	3a 9a e0 	: . . 
	and a			;07d7	a7 	. 
	ret z			;07d8	c8 	. 
	dec a			;07d9	3d 	= 
	ld (UD1ACT),a		;07da	32 9a e0 	2 . . 
	jr nz,$+9		;07dd	20 07 	  . 
	ld hl,(UD1ADD)		;07df	2a 9b e0 	* . . 
	call 022f6h		;07e2	cd f6 22 	. . " 
	ret			;07e5	c9 	. 
	call 0070bh		;07e6	cd 0b 07 	. . . 
	ret			;07e9	c9 	. 
	ld a,(bc)			;07ea	0a 	. 
	ld c,012h		;07eb	0e 12 	. . 
	ld d,01ah		;07ed	16 1a 	. . 
	ld e,022h		;07ef	1e 22 	. " 
	ld h,02ah		;07f1	26 2a 	& * 
	ld l,032h		;07f3	2e 32 	. 2 
	dec (hl)			;07f5	35 	5 
	add hl,sp			;07f6	39 	9 
	dec a			;07f7	3d 	= 
	ld b,c			;07f8	41 	A 
	ld b,l			;07f9	45 	E 
	inc de			;07fa	13 	. 
	add hl,de			;07fb	19 	. 
	jr nz,$+40		;07fc	20 26 	  & 
	inc l			;07fe	2c 	, 
	ld (03f38h),a		;07ff	32 38 3f 	2 8 ? 
	ld b,l			;0802	45 	E 
	ld c,e			;0803	4b 	K 
	ld d,c			;0804	51 	Q 
	ld d,a			;0805	57 	W 
	ld e,(hl)			;0806	5e 	^ 
	ld h,h			;0807	64 	d 
	ld l,d			;0808	6a 	j 
	ld (hl),b			;0809	70 	p 
	call 0080fh		;080a	cd 0f 08 	. . . 
	ei			;080d	fb 	. 
	ret			;080e	c9 	. 
	push af			;080f	f5 	. 
	push bc			;0810	c5 	. 
	push de			;0811	d5 	. 
	push hl			;0812	e5 	. 
	call 00829h		;0813	cd 29 08 	. ) . 
	call 031fbh		;0816	cd fb 31 	. . 1 
	ld c,04dh		;0819	0e 4d 	. M 
	call 01d85h		;081b	cd 85 1d 	. . . 
	call 01d2ch		;081e	cd 2c 1d 	. , . 
	call 031e2h		;0821	cd e2 31 	. . 1 
	pop hl			;0824	e1 	. 
	pop de			;0825	d1 	. 
	pop bc			;0826	c1 	. 
	pop af			;0827	f1 	. 
	ret			;0828	c9 	. 
	in a,(0fch)		;0829	db fc 	. . 
	ld b,a			;082b	47 	G 
	rrca			;082c	0f 	. 
	rrca			;082d	0f 	. 
	rrca			;082e	0f 	. 
	rrca			;082f	0f 	. 
	and 00fh		;0830	e6 0f 	. . 
	ld e,a			;0832	5f 	_ 
	ld d,000h		;0833	16 00 	. . 
	ld hl,007eah		;0835	21 ea 07 	! . . 
	ld a,(OBYTE4)		;0838	3a 49 e0 	: I . 
	and 002h		;083b	e6 02 	. . 
	jr z,$+5		;083d	28 03 	( . 
	ld hl,007fah		;083f	21 fa 07 	! . . 
	add hl,de			;0842	19 	. 
	ld d,(hl)			;0843	56 	V 
	ld e,000h		;0844	1e 00 	. . 
	ld a,(OBYTE4)		;0846	3a 49 e0 	: I . 
	and 004h		;0849	e6 04 	. . 
	jr nz,$+17		;084b	20 0f 	  . 
	ld a,b			;084d	78 	x 
	cpl			;084e	2f 	/ 
	and 00fh		;084f	e6 0f 	. . 
	cp 00eh		;0851	fe 0e 	. . 
	jr nc,$+17		;0853	30 0f 	0 . 
	sub 002h		;0855	d6 02 	. . 
	ret m			;0857	f8 	. 
	rlca			;0858	07 	. 
	inc a			;0859	3c 	< 
	jr $+16		;085a	18 0e 	. . 
	ld a,b			;085c	78 	x 
	cpl			;085d	2f 	/ 
	and 00fh		;085e	e6 0f 	. . 
	cp 00fh		;0860	fe 0f 	. . 
	jr nz,$+7		;0862	20 05 	  . 
	ld a,(LASTLN)		;0864	3a cd e0 	: . . 
	jr $+3		;0867	18 01 	. . 
	rlca			;0869	07 	. 
	ld e,a			;086a	5f 	_ 
	ret			;086b	c9 	. 
	rla			;086c	17 	. 
	ld b,017h		;086d	06 17 	. . 
	ld b,09ch		;086f	06 9c 	. . 
	ld b,03eh		;0871	06 3e 	. > 
	dec h			;0873	25 	% 
	ld a,(bc)			;0874	0a 	. 
	ex af,af'			;0875	08 	. 
	cp b			;0876	b8 	. 
	ld b,01eh		;0877	06 1e 	. . 
	rlca			;0879	07 	. 
	ld a,025h		;087a	3e 25 	> % 
	ld d,b			;087c	50 	P 
	nop			;087d	00 	. 
	inc b			;087e	04 	. 
	inc b			;087f	04 	. 
	inc b			;0880	04 	. 
	inc b			;0881	04 	. 
	inc b			;0882	04 	. 
	inc b			;0883	04 	. 
	nop			;0884	00 	. 
	nop			;0885	00 	. 
	inc b			;0886	04 	. 
	inc b			;0887	04 	. 
	inc b			;0888	04 	. 
	inc b			;0889	04 	. 
	inc b			;088a	04 	. 
	inc b			;088b	04 	. 
	nop			;088c	00 	. 
	nop			;088d	00 	. 
	inc b			;088e	04 	. 
	inc b			;088f	04 	. 
	inc b			;0890	04 	. 
	inc b			;0891	04 	. 
	inc b			;0892	04 	. 
	inc b			;0893	04 	. 
	nop			;0894	00 	. 
	nop			;0895	00 	. 
	inc b			;0896	04 	. 
	inc b			;0897	04 	. 
	inc b			;0898	04 	. 
	inc b			;0899	04 	. 
	inc b			;089a	04 	. 
	inc b			;089b	04 	. 
	nop			;089c	00 	. 
	nop			;089d	00 	. 
	inc b			;089e	04 	. 
	inc b			;089f	04 	. 
	inc b			;08a0	04 	. 
	inc b			;08a1	04 	. 
	inc b			;08a2	04 	. 
	inc b			;08a3	04 	. 
	nop			;08a4	00 	. 
	nop			;08a5	00 	. 
	inc b			;08a6	04 	. 
	inc b			;08a7	04 	. 
	inc b			;08a8	04 	. 
	inc b			;08a9	04 	. 
	inc b			;08aa	04 	. 
	inc b			;08ab	04 	. 
	nop			;08ac	00 	. 
	nop			;08ad	00 	. 
	nop			;08ae	00 	. 
	inc b			;08af	04 	. 
	inc b			;08b0	04 	. 
	inc b			;08b1	04 	. 
	inc b			;08b2	04 	. 
	inc b			;08b3	04 	. 
	inc b			;08b4	04 	. 
	nop			;08b5	00 	. 
	nop			;08b6	00 	. 
	inc b			;08b7	04 	. 
	inc b			;08b8	04 	. 
	inc b			;08b9	04 	. 
	inc b			;08ba	04 	. 
	inc b			;08bb	04 	. 
	inc b			;08bc	04 	. 
	nop			;08bd	00 	. 
	nop			;08be	00 	. 
	inc b			;08bf	04 	. 
	inc b			;08c0	04 	. 
	inc b			;08c1	04 	. 
	inc b			;08c2	04 	. 
	inc b			;08c3	04 	. 
	inc b			;08c4	04 	. 
	nop			;08c5	00 	. 
	nop			;08c6	00 	. 
	inc b			;08c7	04 	. 
	inc b			;08c8	04 	. 
	inc b			;08c9	04 	. 
	inc b			;08ca	04 	. 
	inc b			;08cb	04 	. 
	inc b			;08cc	04 	. 
	ld b,l			;08cd	45 	E 
	ld c,(hl)			;08ce	4e 	N 
	ld d,h			;08cf	54 	T 
	ld b,l			;08d0	45 	E 
	ld d,d			;08d1	52 	R 
	jr nz,$+67		;08d2	20 41 	  A 
	ld b,e			;08d4	43 	C 
	ld b,e			;08d5	43 	C 
	ld b,l			;08d6	45 	E 
	ld d,e			;08d7	53 	S 
	ld d,e			;08d8	53 	S 
	jr nz,$+69		;08d9	20 43 	  C 
	ld c,a			;08db	4f 	O 
	ld b,h			;08dc	44 	D 
	ld b,l			;08dd	45 	E 
	jr nz,$+1		;08de	20 ff 	  . 
	inc b			;08e0	04 	. 
	add a,h			;08e1	84 	. 
	add a,h			;08e2	84 	. 
	add a,h			;08e3	84 	. 
	add a,h			;08e4	84 	. 
	ld b,l			;08e5	45 	E 
	ld c,(hl)			;08e6	4e 	N 
	ld d,h			;08e7	54 	T 
	ld b,l			;08e8	45 	E 
	ld d,d			;08e9	52 	R 
	jr nz,$+79		;08ea	20 4d 	  M 
	ld c,a			;08ec	4f 	O 
	ld b,h			;08ed	44 	D 
	ld b,l			;08ee	45 	E 
	jr nz,$+112		;08ef	20 6e 	  n 
	jr nz,$+42		;08f1	20 28 	  ( 
	ld sp,0362dh		;08f3	31 2d 36 	1 - 6 
	add hl,hl			;08f6	29 	) 
	jr nz,$+1		;08f7	20 ff 	  . 
	ld d,b			;08f9	50 	P 
	ld b,(hl)			;08fa	46 	F 
	ld c,l			;08fb	4d 	M 
	ld c,a			;08fc	4f 	O 
	ld b,h			;08fd	44 	D 
	ld b,l			;08fe	45 	E 
	jr nz,$+51		;08ff	20 31 	  1 
	jr nz,$+72		;0901	20 46 	  F 
	ld c,l			;0903	4d 	M 
	ld c,a			;0904	4f 	O 
	ld b,h			;0905	44 	D 
	ld b,l			;0906	45 	E 
	jr nz,$+52		;0907	20 32 	  2 
	jr nz,$+72		;0909	20 46 	  F 
	ld c,l			;090b	4d 	M 
	ld c,a			;090c	4f 	O 
	ld b,h			;090d	44 	D 
	ld b,l			;090e	45 	E 
	jr nz,$+53		;090f	20 33 	  3 
	jr nz,$+72		;0911	20 46 	  F 
	ld c,l			;0913	4d 	M 
	ld c,a			;0914	4f 	O 
	ld b,h			;0915	44 	D 
	ld b,l			;0916	45 	E 
	jr nz,$+54		;0917	20 34 	  4 
	jr nz,$+72		;0919	20 46 	  F 
	ld c,l			;091b	4d 	M 
	ld c,a			;091c	4f 	O 
	ld b,h			;091d	44 	D 
	ld b,l			;091e	45 	E 
	jr nz,$+55		;091f	20 35 	  5 
	jr nz,$+72		;0921	20 46 	  F 
	ld c,l			;0923	4d 	M 
	ld c,a			;0924	4f 	O 
	ld b,h			;0925	44 	D 
	ld b,l			;0926	45 	E 
	jr nz,$+56		;0927	20 36 	  6 
	jr nz,$+34		;0929	20 20 	    
	ld b,(hl)			;092b	46 	F 
	ld c,l			;092c	4d 	M 
	ld c,a			;092d	4f 	O 
	ld b,h			;092e	44 	D 
	ld b,l			;092f	45 	E 
	jr nz,$+57		;0930	20 37 	  7 
	jr nz,$+72		;0932	20 46 	  F 
	ld d,h			;0934	54 	T 
	ld b,l			;0935	45 	E 
	ld d,d			;0936	52 	R 
	ld c,l			;0937	4d 	M 
	ld c,(hl)			;0938	4e 	N 
	ld c,h			;0939	4c 	L 
	jr nz,$+72		;093a	20 46 	  F 
	jr nz,$+34		;093c	20 20 	    
	jr nz,$+34		;093e	20 20 	    
	jr nz,$+34		;0940	20 20 	    
	jr nz,$+72		;0942	20 46 	  F 
	jr nz,$+34		;0944	20 20 	    
	jr nz,$+34		;0946	20 20 	    
	jr nz,$+34		;0948	20 20 	    
	ld d,b			;094a	50 	P 
	ld sp,05943h		;094b	31 43 59 	1 C Y 
	ld b,d			;094e	42 	B 
	ld b,l			;094f	45 	E 
	ld d,d			;0950	52 	R 
	jr nz,$+34		;0951	20 20 	    
	ld (04c50h),a		;0953	32 50 4c 	2 P L 
	ld b,c			;0956	41 	A 
	ld d,h			;0957	54 	T 
	ld c,a			;0958	4f 	O 
	jr nz,$+34		;0959	20 20 	    
	inc sp			;095b	33 	3 
	jr nz,$+90		;095c	20 58 	  X 
	ld e,b			;095e	58 	X 
	ld e,b			;095f	58 	X 
	ld e,b			;0960	58 	X 
	jr nz,$+34		;0961	20 20 	    
	inc (hl)			;0963	34 	4 
	jr nz,$+90		;0964	20 58 	  X 
	ld e,b			;0966	58 	X 
	ld e,b			;0967	58 	X 
	ld e,b			;0968	58 	X 
	jr nz,$+34		;0969	20 20 	    
	dec (hl)			;096b	35 	5 
	jr nz,$+90		;096c	20 58 	  X 
	ld e,b			;096e	58 	X 
	ld e,b			;096f	58 	X 
	ld e,b			;0970	58 	X 
	jr nz,$+34		;0971	20 20 	    
	ld (hl),020h		;0973	36 20 	6   
	ld e,b			;0975	58 	X 
	ld e,b			;0976	58 	X 
	ld e,b			;0977	58 	X 
	ld e,b			;0978	58 	X 
	jr nz,$+34		;0979	20 20 	    
	jr nz,$+57		;097b	20 37 	  7 
	jr nz,$+82		;097d	20 50 	  P 
	ld b,c			;097f	41 	A 
	ld b,e			;0980	43 	C 
	ld c,e			;0981	4b 	K 
	jr nz,$+34		;0982	20 20 	    
	jr c,$+34		;0984	38 20 	8   
	ld d,h			;0986	54 	T 
	ld b,l			;0987	45 	E 
	ld d,e			;0988	53 	S 
	ld d,h			;0989	54 	T 
	jr nz,$+34		;098a	20 20 	    
	add hl,sp			;098c	39 	9 
	jr nz,$+34		;098d	20 20 	    
	jr nz,$+34		;098f	20 20 	    
	jr nz,$+34		;0991	20 20 	    
	ld sp,02030h		;0993	31 30 20 	1 0   
	jr nz,$+34		;0996	20 20 	    
	jr nz,$+34		;0998	20 20 	    
	jr nz,$+42		;099a	20 28 	  ( 
	ld b,(hl)			;099c	46 	F 
	ld (hl),d			;099d	72 	r 
	ld h,l			;099e	65 	e 
	ld (hl),h			;099f	74 	t 
	ld (hl),l			;09a0	75 	u 
	ld (hl),d			;09a1	72 	r 
	ld l,(hl)			;09a2	6e 	n 
	jr nz,$+72		;09a3	20 46 	  F 
	ld b,e			;09a5	43 	C 
	ld c,a			;09a6	4f 	O 
	ld c,(hl)			;09a7	4e 	N 
	ld b,(hl)			;09a8	46 	F 
	ld c,c			;09a9	49 	I 
	ld b,a			;09aa	47 	G 
	jr nz,$+72		;09ab	20 46 	  F 
	ld b,e			;09ad	43 	C 
	ld c,a			;09ae	4f 	O 
	ld c,(hl)			;09af	4e 	N 
	ld b,(hl)			;09b0	46 	F 
	ld c,c			;09b1	49 	I 
	ld b,a			;09b2	47 	G 
	jr nz,$+72		;09b3	20 46 	  F 
	ld b,e			;09b5	43 	C 
	ld c,a			;09b6	4f 	O 
	ld c,(hl)			;09b7	4e 	N 
	ld b,(hl)			;09b8	46 	F 
	ld c,c			;09b9	49 	I 
	ld b,a			;09ba	47 	G 
	jr nz,$+72		;09bb	20 46 	  F 
	ld b,e			;09bd	43 	C 
	ld c,a			;09be	4f 	O 
	ld c,(hl)			;09bf	4e 	N 
	ld b,(hl)			;09c0	46 	F 
	ld c,c			;09c1	49 	I 
	ld b,a			;09c2	47 	G 
	jr nz,$+42		;09c3	20 28 	  ( 
	ld b,(hl)			;09c5	46 	F 
	ld b,c			;09c6	41 	A 
	ld d,e			;09c7	53 	S 
	jr nz,$+90		;09c8	20 58 	  X 
	jr nz,$+91		;09ca	20 59 	  Y 
	jr nz,$+34		;09cc	20 20 	    
	ld b,(hl)			;09ce	46 	F 
	ld c,h			;09cf	4c 	L 
	jr nz,$+34		;09d0	20 20 	    
	ld c,c			;09d2	49 	I 
	ld b,h			;09d3	44 	D 
	jr nz,$+34		;09d4	20 20 	    
	ld b,(hl)			;09d6	46 	F 
	ld d,b			;09d7	50 	P 
	ld c,a			;09d8	4f 	O 
	ld d,d			;09d9	52 	R 
	ld d,h			;09da	54 	T 
	jr nz,$+67		;09db	20 41 	  A 
	jr nz,$+72		;09dd	20 46 	  F 
	ld d,b			;09df	50 	P 
	ld c,a			;09e0	4f 	O 
	ld d,d			;09e1	52 	R 
	ld d,h			;09e2	54 	T 
	jr nz,$+68		;09e3	20 42 	  B 
	jr nz,$+72		;09e5	20 46 	  F 
	ld l,c			;09e7	69 	i 
	ld l,(hl)			;09e8	6e 	n 
	ld (hl),e			;09e9	73 	s 
	ld (hl),h			;09ea	74 	t 
	ld l,h			;09eb	6c 	l 
	jr nz,$+76		;09ec	20 4a 	  J 
	ld sp,02020h		;09ee	31 20 20 	1     
	jr nz,$+34		;09f1	20 20 	    
	jr nz,$+34		;09f3	20 20 	    
	jr nz,$+52		;09f5	20 32 	  2 
	jr nz,$+34		;09f7	20 20 	    
	jr nz,$+34		;09f9	20 20 	    
	jr nz,$+34		;09fb	20 20 	    
	jr nz,$+53		;09fd	20 33 	  3 
	jr nz,$+34		;09ff	20 20 	    
	jr nz,$+34		;0a01	20 20 	    
	jr nz,$+34		;0a03	20 20 	    
	jr nz,$+54		;0a05	20 34 	  4 
	jr nz,$+34		;0a07	20 20 	    
	jr nz,$+34		;0a09	20 20 	    
	jr nz,$+34		;0a0b	20 20 	    
	jr nz,$+55		;0a0d	20 35 	  5 
	jr nz,$+34		;0a0f	20 20 	    
	jr nz,$+34		;0a11	20 20 	    
	jr nz,$+34		;0a13	20 20 	    
	jr nz,$+56		;0a15	20 36 	  6 
	jr nz,$+34		;0a17	20 20 	    
	jr nz,$+34		;0a19	20 20 	    
	jr nz,$+34		;0a1b	20 20 	    
	jr nz,$+34		;0a1d	20 20 	    
	scf			;0a1f	37 	7 
	jr nz,$+34		;0a20	20 20 	    
	jr nz,$+34		;0a22	20 20 	    
	jr nz,$+34		;0a24	20 20 	    
	jr nz,$+58		;0a26	20 38 	  8 
	jr nz,$+34		;0a28	20 20 	    
	jr nz,$+34		;0a2a	20 20 	    
	jr nz,$+34		;0a2c	20 20 	    
	jr nz,$+59		;0a2e	20 39 	  9 
	jr nz,$+34		;0a30	20 20 	    
	jr nz,$+34		;0a32	20 20 	    
	jr nz,$+34		;0a34	20 20 	    
	ld sp,00630h		;0a36	31 30 06 	1 0 . 
	ld l,l			;0a39	6d 	m 
	ld l,a			;0a3a	6f 	o 
	ld h,h			;0a3b	64 	d 
	ld h,l			;0a3c	65 	e 
	jr nz,$+112		;0a3d	20 6e 	  n 
	jr z,$+2		;0a3f	28 00 	( . 
	inc b			;0a41	04 	. 
	inc b			;0a42	04 	. 
	inc b			;0a43	04 	. 
	inc b			;0a44	04 	. 
	inc b			;0a45	04 	. 
	inc b			;0a46	04 	. 
	nop			;0a47	00 	. 
	nop			;0a48	00 	. 
	add a,h			;0a49	84 	. 
	add a,h			;0a4a	84 	. 
	add a,h			;0a4b	84 	. 
	add a,h			;0a4c	84 	. 
	add a,h			;0a4d	84 	. 
	add a,h			;0a4e	84 	. 
	nop			;0a4f	00 	. 
	nop			;0a50	00 	. 
	add a,h			;0a51	84 	. 
	add a,h			;0a52	84 	. 
	add a,h			;0a53	84 	. 
	add a,h			;0a54	84 	. 
	add a,h			;0a55	84 	. 
	add a,h			;0a56	84 	. 
	nop			;0a57	00 	. 
	nop			;0a58	00 	. 
	add a,h			;0a59	84 	. 
	add a,h			;0a5a	84 	. 
	add a,h			;0a5b	84 	. 
	add a,h			;0a5c	84 	. 
	add a,h			;0a5d	84 	. 
	add a,h			;0a5e	84 	. 
	nop			;0a5f	00 	. 
	nop			;0a60	00 	. 
	add a,h			;0a61	84 	. 
	add a,h			;0a62	84 	. 
	add a,h			;0a63	84 	. 
	add a,h			;0a64	84 	. 
	add a,h			;0a65	84 	. 
	add a,h			;0a66	84 	. 
	nop			;0a67	00 	. 
	jr z,$+2		;0a68	28 00 	( . 
	call nz,00404h		;0a6a	c4 04 04 	. . . 
	call nz,0e404h		;0a6d	c4 04 e4 	. . . 
	nop			;0a70	00 	. 
	nop			;0a71	00 	. 
	nop			;0a72	00 	. 
	call nz,0e404h		;0a73	c4 04 e4 	. . . 
	call po,0e4e4h		;0a76	e4 e4 e4 	. . . 
	nop			;0a79	00 	. 
	nop			;0a7a	00 	. 
	inc b			;0a7b	04 	. 
	call po,00404h		;0a7c	e4 04 04 	. . . 
	call po,00004h		;0a7f	e4 04 00 	. . . 
	nop			;0a82	00 	. 
	inc b			;0a83	04 	. 
	call po,00404h		;0a84	e4 04 04 	. . . 
	call po,00004h		;0a87	e4 04 00 	. . . 
	nop			;0a8a	00 	. 
	inc b			;0a8b	04 	. 
	inc b			;0a8c	04 	. 
	inc b			;0a8d	04 	. 
	inc b			;0a8e	04 	. 
	inc b			;0a8f	04 	. 
	inc b			;0a90	04 	. 
	jr z,$+72		;0a91	28 46 	( F 
	ld c,a			;0a93	4f 	O 
	ld d,b			;0a94	50 	P 
	ld d,d			;0a95	52 	R 
	jr nz,$+70		;0a96	20 44 	  D 
	ld b,(hl)			;0a98	46 	F 
	jr nz,$+34		;0a99	20 20 	    
	ld b,(hl)			;0a9b	46 	F 
	ld b,c			;0a9c	41 	A 
	dec l			;0a9d	2d 	- 
	ld b,h			;0a9e	44 	D 
	ld c,c			;0a9f	49 	I 
	ld b,c			;0aa0	41 	A 
	ld c,h			;0aa1	4c 	L 
	jr nz,$+72		;0aa2	20 46 	  F 
	ld b,c			;0aa4	41 	A 
	dec l			;0aa5	2d 	- 
	ld b,h			;0aa6	44 	D 
	ld c,c			;0aa7	49 	I 
	ld b,c			;0aa8	41 	A 
	ld c,h			;0aa9	4c 	L 
	jr nz,$+72		;0aaa	20 46 	  F 
	ld b,h			;0aac	44 	D 
	ld b,(hl)			;0aad	46 	F 
	jr nz,$+86		;0aae	20 54 	  T 
	jr nz,$+84		;0ab0	20 52 	  R 
	jr nz,$+72		;0ab2	20 46 	  F 
	ld b,c			;0ab4	41 	A 
	ld b,e			;0ab5	43 	C 
	ld b,e			;0ab6	43 	C 
	ld b,l			;0ab7	45 	E 
	ld d,e			;0ab8	53 	S 
	ld d,e			;0ab9	53 	S 
	jr z,$+2		;0aba	28 00 	( . 
	inc b			;0abc	04 	. 
	call po,0e4e4h		;0abd	e4 e4 e4 	. . . 
	call po,00004h		;0ac0	e4 04 00 	. . . 
	nop			;0ac3	00 	. 
	nop			;0ac4	00 	. 
	call po,0e4e4h		;0ac5	e4 e4 e4 	. . . 
	call po,0e4e4h		;0ac8	e4 e4 e4 	. . . 
	nop			;0acb	00 	. 
	nop			;0acc	00 	. 
	call po,0e4e4h		;0acd	e4 e4 e4 	. . . 
	call po,0e4e4h		;0ad0	e4 e4 e4 	. . . 
	nop			;0ad3	00 	. 
	nop			;0ad4	00 	. 
	call nz,004e4h		;0ad5	c4 e4 04 	. . . 
	call po,0e404h		;0ad8	e4 04 e4 	. . . 
	nop			;0adb	00 	. 
	nop			;0adc	00 	. 
	inc b			;0add	04 	. 
	call po,0e4e4h		;0ade	e4 e4 e4 	. . . 
	call po,04504h		;0ae1	e4 04 45 	. . E 
	ld c,(hl)			;0ae4	4e 	N 
	ld d,h			;0ae5	54 	T 
	ld b,l			;0ae6	45 	E 
	ld d,d			;0ae7	52 	R 
	jr nz,$+79		;0ae8	20 4d 	  M 
	ld c,a			;0aea	4f 	O 
	ld b,h			;0aeb	44 	D 
	ld b,l			;0aec	45 	E 
	jr nz,$+80		;0aed	20 4e 	  N 
	ld b,c			;0aef	41 	A 
	ld c,l			;0af0	4d 	M 
	ld b,l			;0af1	45 	E 
	jr nz,$+1		;0af2	20 ff 	  . 
	inc b			;0af4	04 	. 
	add a,h			;0af5	84 	. 
	add a,h			;0af6	84 	. 
	add a,h			;0af7	84 	. 
	add a,h			;0af8	84 	. 
	ld b,(hl)			;0af9	46 	F 
	ld b,c			;0afa	41 	A 
	ld c,c			;0afb	49 	I 
	ld c,h			;0afc	4c 	L 
	ld d,l			;0afd	55 	U 
	ld d,d			;0afe	52 	R 
	ld b,l			;0aff	45 	E 
	jr nz,$+78		;0b00	20 4c 	  L 
	ld c,a			;0b02	4f 	O 
	ld b,c			;0b03	41 	A 
	ld b,h			;0b04	44 	D 
	ld c,c			;0b05	49 	I 
	ld c,(hl)			;0b06	4e 	N 
	ld b,a			;0b07	47 	G 
	jr nz,$+79		;0b08	20 4d 	  M 
	ld c,a			;0b0a	4f 	O 
	ld b,h			;0b0b	44 	D 
	ld b,l			;0b0c	45 	E 
	rst 38h			;0b0d	ff 	. 
	ld d,e			;0b0e	53 	S 
	ld c,a			;0b0f	4f 	O 
	ld d,d			;0b10	52 	R 
	ld d,d			;0b11	52 	R 
	ld e,c			;0b12	59 	Y 
	rst 38h			;0b13	ff 	. 
	ld d,b			;0b14	50 	P 
	ld b,(hl)			;0b15	46 	F 
	ld (hl),d			;0b16	72 	r 
	ld h,l			;0b17	65 	e 
	ld (hl),h			;0b18	74 	t 
	ld (hl),l			;0b19	75 	u 
	ld (hl),d			;0b1a	72 	r 
	ld l,(hl)			;0b1b	6e 	n 
	jr nz,$+72		;0b1c	20 46 	  F 
	jr nz,$+78		;0b1e	20 4c 	  L 
	ld c,c			;0b20	49 	I 
	ld c,(hl)			;0b21	4e 	N 
	ld b,l			;0b22	45 	E 
	jr nz,$+34		;0b23	20 20 	    
	ld b,(hl)			;0b25	46 	F 
	ld d,b			;0b26	50 	P 
	ld d,d			;0b27	52 	R 
	ld c,c			;0b28	49 	I 
	ld c,(hl)			;0b29	4e 	N 
	ld d,h			;0b2a	54 	T 
	ld d,d			;0b2b	52 	R 
	jr nz,$+72		;0b2c	20 46 	  F 
	ld c,l			;0b2e	4d 	M 
	ld b,c			;0b2f	41 	A 
	ld d,d			;0b30	52 	R 
	ld b,a			;0b31	47 	G 
	ld c,c			;0b32	49 	I 
	ld c,(hl)			;0b33	4e 	N 
	jr nz,$+72		;0b34	20 46 	  F 
	ld b,c			;0b36	41 	A 
	ld c,h			;0b37	4c 	L 
	ld b,l			;0b38	45 	E 
	ld d,d			;0b39	52 	R 
	ld d,h			;0b3a	54 	T 
	jr nz,$+34		;0b3b	20 20 	    
	ld b,(hl)			;0b3d	46 	F 
	jr nz,$+78		;0b3e	20 4c 	  L 
	ld c,a			;0b40	4f 	O 
	ld b,e			;0b41	43 	C 
	ld c,e			;0b42	4b 	K 
	jr nz,$+34		;0b43	20 20 	    
	jr nz,$+72		;0b45	20 46 	  F 
	ld c,(hl)			;0b47	4e 	N 
	jr nz,$+82		;0b48	20 50 	  P 
	ld b,c			;0b4a	41 	A 
	ld b,h			;0b4b	44 	D 
	jr nz,$+34		;0b4c	20 20 	    
	ld b,(hl)			;0b4e	46 	F 
	ld d,e			;0b4f	53 	S 
	ld b,e			;0b50	43 	C 
	ld d,d			;0b51	52 	R 
	ld b,l			;0b52	45 	E 
	ld b,l			;0b53	45 	E 
	ld c,(hl)			;0b54	4e 	N 
	jr nz,$+72		;0b55	20 46 	  F 
	ld b,e			;0b57	43 	C 
	ld e,c			;0b58	59 	Y 
	ld b,d			;0b59	42 	B 
	ld b,l			;0b5a	45 	E 
	ld d,d			;0b5b	52 	R 
	jr nz,$+34		;0b5c	20 20 	    
	ld b,(hl)			;0b5e	46 	F 
	jr nz,$+79		;0b5f	20 4d 	  M 
	ld c,a			;0b61	4f 	O 
	ld d,d			;0b62	52 	R 
	ld b,l			;0b63	45 	E 
	jr nz,$+73		;0b64	20 47 	  G 
	ld b,d			;0b66	42 	B 
	ld b,c			;0b67	41 	A 
	ld b,e			;0b68	43 	C 
	ld c,e			;0b69	4b 	K 
	ld b,a			;0b6a	47 	G 
	ld b,h			;0b6b	44 	D 
	jr nz,$+72		;0b6c	20 46 	  F 
	ld b,e			;0b6e	43 	C 
	ld d,l			;0b6f	55 	U 
	ld d,d			;0b70	52 	R 
	ld d,e			;0b71	53 	S 
	ld c,a			;0b72	4f 	O 
	ld d,d			;0b73	52 	R 
	jr nz,$+72		;0b74	20 46 	  F 
	ld b,e			;0b76	43 	C 
	ld d,l			;0b77	55 	U 
	ld d,d			;0b78	52 	R 
	ld d,e			;0b79	53 	S 
	ld c,a			;0b7a	4f 	O 
	ld d,d			;0b7b	52 	R 
	jr nz,$+72		;0b7c	20 46 	  F 
	jr nz,$+68		;0b7e	20 42 	  B 
	ld b,c			;0b80	41 	A 
	ld d,l			;0b81	55 	U 
	ld b,h			;0b82	44 	D 
	jr nz,$+34		;0b83	20 20 	    
	ld b,(hl)			;0b85	46 	F 
	ld b,h			;0b86	44 	D 
	ld d,l			;0b87	55 	U 
	ld d,b			;0b88	50 	P 
	ld c,h			;0b89	4c 	L 
	ld b,l			;0b8a	45 	E 
	ld e,b			;0b8b	58 	X 
	jr nz,$+34		;0b8c	20 20 	    
	ld b,(hl)			;0b8e	46 	F 
	ld b,e			;0b8f	43 	C 
	ld c,b			;0b90	48 	H 
	ld d,d			;0b91	52 	R 
	cpl			;0b92	2f 	/ 
	ld c,h			;0b93	4c 	L 
	ld c,(hl)			;0b94	4e 	N 
	jr nz,$+72		;0b95	20 46 	  F 
	ld c,h			;0b97	4c 	L 
	ld c,c			;0b98	49 	I 
	ld c,(hl)			;0b99	4e 	N 
	ld b,l			;0b9a	45 	E 
	ld d,e			;0b9b	53 	S 
	jr nz,$+34		;0b9c	20 20 	    
	ld b,(hl)			;0b9e	46 	F 
	ld e,b			;0b9f	58 	X 
	ld d,b			;0ba0	50 	P 
	ld b,c			;0ba1	41 	A 
	ld d,d			;0ba2	52 	R 
	ld c,(hl)			;0ba3	4e 	N 
	ld d,h			;0ba4	54 	T 
	jr nz,$+72		;0ba5	20 46 	  F 
	jr nz,$+111		;0ba7	20 6d 	  m 
	ld l,a			;0ba9	6f 	o 
	ld h,h			;0baa	64 	d 
	ld h,l			;0bab	65 	e 
	jr nz,$+8		;0bac	20 06 	  . 
	ld d,e			;0bae	53 	S 
	ld b,l			;0baf	45 	E 
	ld c,h			;0bb0	4c 	L 
	ld b,l			;0bb1	45 	E 
	ld b,e			;0bb2	43 	C 
	ld d,h			;0bb3	54 	T 
	jr nz,$+34		;0bb4	20 20 	    
	ld c,a			;0bb6	4f 	O 
	ld b,(hl)			;0bb7	46 	F 
	ld b,(hl)			;0bb8	46 	F 
	jr nz,$+34		;0bb9	20 20 	    
	jr nz,$+81		;0bbb	20 4f 	  O 
	ld c,(hl)			;0bbd	4e 	N 
	jr nz,$+34		;0bbe	20 20 	    
	jr nz,$+85		;0bc0	20 53 	  S 
	ld c,a			;0bc2	4f 	O 
	ld b,(hl)			;0bc3	46 	F 
	ld d,h			;0bc4	54 	T 
	jr nz,$+34		;0bc5	20 20 	    
	ld c,h			;0bc7	4c 	L 
	ld c,a			;0bc8	4f 	O 
	ld d,l			;0bc9	55 	U 
	ld b,h			;0bca	44 	D 
	jr nz,$+34		;0bcb	20 20 	    
	ld b,c			;0bcd	41 	A 
	ld c,h			;0bce	4c 	L 
	ld d,b			;0bcf	50 	P 
	ld c,b			;0bd0	48 	H 
	ld b,c			;0bd1	41 	A 
	jr nz,$+85		;0bd2	20 53 	  S 
	ld c,b			;0bd4	48 	H 
	ld c,c			;0bd5	49 	I 
	ld b,(hl)			;0bd6	46 	F 
	ld d,h			;0bd7	54 	T 
	ld c,(hl)			;0bd8	4e 	N 
	ld c,a			;0bd9	4f 	O 
	ld d,d			;0bda	52 	R 
	ld c,l			;0bdb	4d 	M 
	ld b,c			;0bdc	41 	A 
	ld c,h			;0bdd	4c 	L 
	jr nz,$+84		;0bde	20 52 	  R 
	ld c,a			;0be0	4f 	O 
	ld c,h			;0be1	4c 	L 
	ld c,h			;0be2	4c 	L 
	jr nz,$+34		;0be3	20 20 	    
	ld d,b			;0be5	50 	P 
	ld b,c			;0be6	41 	A 
	ld b,a			;0be7	47 	G 
	ld b,l			;0be8	45 	E 
	jr nz,$+34		;0be9	20 20 	    
	ld d,e			;0beb	53 	S 
	ld c,l			;0bec	4d 	M 
	ld b,c			;0bed	41 	A 
	ld c,h			;0bee	4c 	L 
	ld c,h			;0bef	4c 	L 
	jr nz,$+78		;0bf0	20 4c 	  L 
	ld b,c			;0bf2	41 	A 
	ld d,d			;0bf3	52 	R 
	ld b,a			;0bf4	47 	G 
	ld b,l			;0bf5	45 	E 
	jr nz,$+70		;0bf6	20 44 	  D 
	ld b,c			;0bf8	41 	A 
	ld d,d			;0bf9	52 	R 
	ld c,e			;0bfa	4b 	K 
	jr nz,$+34		;0bfb	20 20 	    
	ld c,h			;0bfd	4c 	L 
	ld c,c			;0bfe	49 	I 
	ld b,a			;0bff	47 	G 
	ld c,b			;0c00	48 	H 
	ld d,h			;0c01	54 	T 
	jr nz,$+78		;0c02	20 4c 	  L 
	ld c,c			;0c04	49 	I 
	ld c,(hl)			;0c05	4e 	N 
	ld b,l			;0c06	45 	E 
	jr nz,$+34		;0c07	20 20 	    
	ld b,d			;0c09	42 	B 
	ld c,h			;0c0a	4c 	L 
	ld c,a			;0c0b	4f 	O 
	ld b,e			;0c0c	43 	C 
	ld c,e			;0c0d	4b 	K 
	jr nz,$+68		;0c0e	20 42 	  B 
	ld c,h			;0c10	4c 	L 
	ld c,c			;0c11	49 	I 
	ld c,(hl)			;0c12	4e 	N 
	ld c,e			;0c13	4b 	K 
	jr nz,$+85		;0c14	20 53 	  S 
	ld c,a			;0c16	4f 	O 
	ld c,h			;0c17	4c 	L 
	ld c,c			;0c18	49 	I 
	ld b,h			;0c19	44 	D 
	jr nz,$+74		;0c1a	20 48 	  H 
	ld b,c			;0c1c	41 	A 
	ld c,h			;0c1d	4c 	L 
	ld b,(hl)			;0c1e	46 	F 
	jr nz,$+34		;0c1f	20 20 	    
	ld b,(hl)			;0c21	46 	F 
	ld d,l			;0c22	55 	U 
	ld c,h			;0c23	4c 	L 
	ld c,h			;0c24	4c 	L 
	jr nz,$+34		;0c25	20 20 	    
	jr nz,$+58		;0c27	20 38 	  8 
	jr nc,$+34		;0c29	30 20 	0   
	jr nz,$+34		;0c2b	20 20 	    
	jr nz,$+51		;0c2d	20 31 	  1 
	inc sp			;0c2f	33 	3 
	ld (02020h),a		;0c30	32 20 20 	2     
	jr nz,$+52		;0c33	20 32 	  2 
	inc (hl)			;0c35	34 	4 
	jr nz,$+34		;0c36	20 20 	    
	jr nz,$+34		;0c38	20 20 	    
	inc sp			;0c3a	33 	3 
	jr nc,$+34		;0c3b	30 20 	0   
	jr nz,$+34		;0c3d	20 20 	    
	ld e,d			;0c3f	5a 	Z 
	ld b,l			;0c40	45 	E 
	ld d,d			;0c41	52 	R 
	ld c,a			;0c42	4f 	O 
	jr nz,$+34		;0c43	20 20 	    
	ld c,a			;0c45	4f 	O 
	ld c,(hl)			;0c46	4e 	N 
	ld b,l			;0c47	45 	E 
	jr nz,$+34		;0c48	20 20 	    
	jr nz,$+34		;0c4a	20 20 	    
	scf			;0c4c	37 	7 
	dec (hl)			;0c4d	35 	5 
	jr nz,$+34		;0c4e	20 20 	    
	jr nz,$+34		;0c50	20 20 	    
	ld sp,03031h		;0c52	31 31 30 	1 1 0 
	jr nz,$+34		;0c55	20 20 	    
	jr nz,$+51		;0c57	20 31 	  1 
	dec (hl)			;0c59	35 	5 
	jr nc,$+34		;0c5a	30 20 	0   
	jr nz,$+34		;0c5c	20 20 	    
	ld (03030h),a		;0c5e	32 30 30 	2 0 0 
	jr nz,$+34		;0c61	20 20 	    
	jr nz,$+53		;0c63	20 33 	  3 
	jr nc,$+50		;0c65	30 30 	0 0 
	jr nz,$+34		;0c67	20 20 	    
	jr nz,$+56		;0c69	20 36 	  6 
	jr nc,$+50		;0c6b	30 30 	0 0 
	jr nz,$+34		;0c6d	20 20 	    
	ld sp,03032h		;0c6f	31 32 30 	1 2 0 
	jr nc,$+34		;0c72	30 20 	0   
	jr nz,$+51		;0c74	20 31 	  1 
	jr c,$+50		;0c76	38 30 	8 0 
	jr nc,$+34		;0c78	30 20 	0   
	jr nz,$+52		;0c7a	20 32 	  2 
	inc (hl)			;0c7c	34 	4 
	jr nc,$+50		;0c7d	30 30 	0 0 
	jr nz,$+34		;0c7f	20 20 	    
	inc (hl)			;0c81	34 	4 
	jr c,$+50		;0c82	38 30 	8 0 
	jr nc,$+34		;0c84	30 20 	0   
	jr nz,$+59		;0c86	20 39 	  9 
	ld (hl),030h		;0c88	36 30 	6 0 
	jr nc,$+34		;0c8a	30 20 	0   
	jr nz,$+51		;0c8c	20 31 	  1 
	add hl,sp			;0c8e	39 	9 
	ld l,032h		;0c8f	2e 32 	. 2 
	jr nz,$-49		;0c91	20 cd 	  . 
	ld h,002h		;0c93	26 02 	& . 
	call 001f7h		;0c95	cd f7 01 	. . . 
	ei			;0c98	fb 	. 
	call 02069h		;0c99	cd 69 20 	. i   
	call 0026dh		;0c9c	cd 6d 02 	. m . 
	call 0025dh		;0c9f	cd 5d 02 	. ] . 
	ld a,004h		;0ca2	3e 04 	> . 
	ld (OBYTE4),a		;0ca4	32 49 e0 	2 I . 
	xor a			;0ca7	af 	. 
	ld (ATTRIB),a		;0ca8	32 a9 e0 	2 . . 
	call 00e47h		;0cab	cd 47 0e 	. G . 
	ld hl,008f9h		;0cae	21 f9 08 	! . . 
	call 00e80h		;0cb1	cd 80 0e 	. . . 
	call 021f5h		;0cb4	cd f5 21 	. . ! 
	ld hl,0094ah		;0cb7	21 4a 09 	! J . 
	call 00e80h		;0cba	cd 80 0e 	. . . 
	ld a,012h		;0cbd	3e 12 	> . 
	ld (CHRCNT),a		;0cbf	32 b1 e0 	2 . . 
	call 03203h		;0cc2	cd 03 32 	. . 2 
	ld de,040e0h		;0cc5	11 e0 40 	. . @ 
	ld b,004h		;0cc8	06 04 	. . 
	call 00e5ah		;0cca	cd 5a 0e 	. Z . 
	ld a,01ah		;0ccd	3e 1a 	> . 
	ld (CHRCNT),a		;0ccf	32 b1 e0 	2 . . 
	call 03203h		;0cd2	cd 03 32 	. . 2 
	ld de,040e8h		;0cd5	11 e8 40 	. . @ 
	ld b,004h		;0cd8	06 04 	. . 
	call 00e5ah		;0cda	cd 5a 0e 	. Z . 
	ld a,022h		;0cdd	3e 22 	> " 
	ld (CHRCNT),a		;0cdf	32 b1 e0 	2 . . 
	call 03203h		;0ce2	cd 03 32 	. . 2 
	ld de,040f0h		;0ce5	11 f0 40 	. . @ 
	ld b,004h		;0ce8	06 04 	. . 
	call 00e5ah		;0cea	cd 5a 0e 	. Z . 
	ld a,02ah		;0ced	3e 2a 	> * 
	ld (CHRCNT),a		;0cef	32 b1 e0 	2 . . 
	call 03203h		;0cf2	cd 03 32 	. . 2 
	ld de,040f8h		;0cf5	11 f8 40 	. . @ 
	ld b,004h		;0cf8	06 04 	. . 
	call 00e5ah		;0cfa	cd 5a 0e 	. Z . 
	ld a,(ASEL)		;0cfd	3a 66 e0 	: f . 
	and 007h		;0d00	e6 07 	. . 
	ld hl,00d5dh		;0d02	21 5d 0d 	! ] . 
	ld e,a			;0d05	5f 	_ 
	ld d,000h		;0d06	16 00 	. . 
	add hl,de			;0d08	19 	. 
	ld a,(hl)			;0d09	7e 	~ 
	ld (CHRCNT),a		;0d0a	32 b1 e0 	2 . . 
	call 03203h		;0d0d	cd 03 32 	. . 2 
	ld hl,(CURSOR)		;0d10	2a b7 e0 	* . . 
	ld (hl),02ah		;0d13	36 2a 	6 * 
	jr $+5		;0d15	18 03 	. . 
	call 01519h		;0d17	cd 19 15 	. . . 
	ld a,085h		;0d1a	3e 85 	> . 
	out (01ch),a		;0d1c	d3 1c 	. . 
	call 02925h		;0d1e	cd 25 29 	. % ) 
	ld a,b			;0d21	78 	x 
	bit 7,b		;0d22	cb 78 	. x 
	jr z,$+12		;0d24	28 0a 	( . 
	cp 0a5h		;0d26	fe a5 	. . 
	jr nz,$-10		;0d28	20 f4 	  . 
	xor a			;0d2a	af 	. 
	ld (CONT),a		;0d2b	32 b5 e0 	2 . . 
	jr $-16		;0d2e	18 ee 	. . 
	cp 025h		;0d30	fe 25 	. % 
	jp nz,00d3ch		;0d32	c2 3c 0d 	. < . 
	ld a,001h		;0d35	3e 01 	> . 
	ld (CONT),a		;0d37	32 b5 e0 	2 . . 
	jr $-28		;0d3a	18 e2 	. . 
	cp 018h		;0d3c	fe 18 	. . 
	jr nz,$+9		;0d3e	20 07 	  . 
	ld a,(CONT)		;0d40	3a b5 e0 	: . . 
	rra			;0d43	1f 	. 
	jp c,00ed6h		;0d44	da d6 0e 	. . . 
	call 02947h		;0d47	cd 47 29 	. G ) 
	cp 081h		;0d4a	fe 81 	. . 
	jr c,$-53		;0d4c	38 c9 	8 . 
	cp 089h		;0d4e	fe 89 	. . 
	jr nc,$-57		;0d50	30 c5 	0 . 
	push af			;0d52	f5 	. 
	call 02069h		;0d53	cd 69 20 	. i   
	pop af			;0d56	f1 	. 
	ld hl,01194h		;0d57	21 94 11 	! . . 
	jp 01186h		;0d5a	c3 86 11 	. . . 
	ld b,006h		;0d5d	06 06 	. . 
	ld c,016h		;0d5f	0e 16 	. . 
	ld e,026h		;0d61	1e 26 	. & 
	ld l,037h		;0d63	2e 37 	. 7 
	ld a,(ASEL)		;0d65	3a 66 e0 	: f . 
	and 007h		;0d68	e6 07 	. . 
	jr nz,$+6		;0d6a	20 04 	  . 
	inc a			;0d6c	3c 	< 
	jr $+3		;0d6d	18 01 	. . 
	ld a,b			;0d6f	78 	x 
	ld (MDACT),a		;0d70	32 fe e0 	2 . . 
	cp 007h		;0d73	fe 07 	. . 
	jp z,00e32h		;0d75	ca 32 0e 	. 2 . 
	rrca			;0d78	0f 	. 
	rrca			;0d79	0f 	. 
	rrca			;0d7a	0f 	. 
	ld hl,04000h		;0d7b	21 00 40 	! . @ 
	ld l,a			;0d7e	6f 	o 
	ld de,MBYTE1		;0d7f	11 40 e0 	. @ . 
	ld bc,00020h		;0d82	01 20 00 	.   . 
	ld (MODEST),hl		;0d85	22 d9 e0 	" . . 
	ldir		;0d88	ed b0 	. . 
	ld a,(OBYTE4)		;0d8a	3a 49 e0 	: I . 
	ld (CHRSAV),a		;0d8d	32 b2 e0 	2 . . 
	or 004h		;0d90	f6 04 	. . 
	ld (OBYTE4),a		;0d92	32 49 e0 	2 I . 
	ld a,(MBYTE1)		;0d95	3a 40 e0 	: @ . 
	and 001h		;0d98	e6 01 	. . 
	jr nz,$+31		;0d9a	20 1d 	  . 
	call 0026dh		;0d9c	cd 6d 02 	. m . 
	ld d,000h		;0d9f	16 00 	. . 
	ld e,01ah		;0da1	1e 1a 	. . 
	call 031fbh		;0da3	cd fb 31 	. . 1 
	call 0210fh		;0da6	cd 0f 21 	. . ! 
	ld hl,00af9h		;0da9	21 f9 0a 	! . . 
	call 022a6h		;0dac	cd a6 22 	. . " 
	call 001f7h		;0daf	cd f7 01 	. . . 
	ei			;0db2	fb 	. 
	call 01519h		;0db3	cd 19 15 	. . . 
	jp 00c9ch		;0db6	c3 9c 0c 	. . . 
	ld a,(MBYTE1)		;0db9	3a 40 e0 	: @ . 
	and 002h		;0dbc	e6 02 	. . 
	jr z,$+103		;0dbe	28 65 	( e 
	ld d,000h		;0dc0	16 00 	. . 
	ld e,01ah		;0dc2	1e 1a 	. . 
	call 031fbh		;0dc4	cd fb 31 	. . 1 
	ld hl,008cdh		;0dc7	21 cd 08 	! . . 
	call 022a6h		;0dca	cd a6 22 	. . " 
	ld hl,008e0h		;0dcd	21 e0 08 	! . . 
	call 00e6eh		;0dd0	cd 6e 0e 	. n . 
	ld hl,SECURE		;0dd3	21 5a e0 	! Z . 
	xor a			;0dd6	af 	. 
	ld (ERROR),a		;0dd7	32 bd e0 	2 . . 
	push hl			;0dda	e5 	. 
	ld a,(hl)			;0ddb	7e 	~ 
	call 01137h		;0ddc	cd 37 11 	. 7 . 
	ld c,a			;0ddf	4f 	O 
	call 02925h		;0de0	cd 25 29 	. % ) 
	bit 7,b		;0de3	cb 78 	. x 
	jr nz,$-5		;0de5	20 f9 	  . 
	call 02947h		;0de7	cd 47 29 	. G ) 
	cp 050h		;0dea	fe 50 	. P 
	jr c,$+4		;0dec	38 02 	8 . 
	sub 020h		;0dee	d6 20 	.   
	cp c			;0df0	b9 	. 
	jr z,$+10		;0df1	28 08 	( . 
	ld a,(ERROR)		;0df3	3a bd e0 	: . . 
	or 001h		;0df6	f6 01 	. . 
	ld (ERROR),a		;0df8	32 bd e0 	2 . . 
	ld a,058h		;0dfb	3e 58 	> X 
	ld de,(CURSOR)		;0dfd	ed 5b b7 e0 	. [ . . 
	ld (de),a			;0e01	12 	. 
	inc de			;0e02	13 	. 
	xor a			;0e03	af 	. 
	ld (de),a			;0e04	12 	. 
	call 00e8eh		;0e05	cd 8e 0e 	. . . 
	pop hl			;0e08	e1 	. 
	inc hl			;0e09	23 	# 
	jr z,$-48		;0e0a	28 ce 	( . 
	ld a,(ERROR)		;0e0c	3a bd e0 	: . . 
	cp 001h		;0e0f	fe 01 	. . 
	jr nz,$+20		;0e11	20 12 	  . 
	call 014bdh		;0e13	cd bd 14 	. . . 
	call 014bdh		;0e16	cd bd 14 	. . . 
	ld hl,00b0eh		;0e19	21 0e 0b 	! . . 
	call 022a6h		;0e1c	cd a6 22 	. . " 
	call 01519h		;0e1f	cd 19 15 	. . . 
	jp 00c9ch		;0e22	c3 9c 0c 	. . . 
	ld a,(CHRSAV)		;0e25	3a b2 e0 	: . . 
	ld (OBYTE4),a		;0e28	32 49 e0 	2 I . 
	ld ix,00000h		;0e2b	dd 21 00 00 	. ! . . 
	jp 03d12h		;0e2f	c3 12 3d 	. . = 
	in a,(026h)		;0e32	db 26 	. & 
	and 040h		;0e34	e6 40 	. @ 
	jp z,00d9ch		;0e36	ca 9c 0d 	. . . 
	ld a,(08006h)		;0e39	3a 06 80 	: . . 
	cp 0c3h		;0e3c	fe c3 	. . 
	jp nz,00d9ch		;0e3e	c2 9c 0d 	. . . 
	call 08006h		;0e41	cd 06 80 	. . . 
	jp 00161h		;0e44	c3 61 01 	. a . 
	call 021f5h		;0e47	cd f5 21 	. . ! 
	ld hl,0087ch		;0e4a	21 7c 08 	! | . 
	call 00e6eh		;0e4d	cd 6e 0e 	. n . 
	call 02209h		;0e50	cd 09 22 	. . " 
	ld hl,0087ch		;0e53	21 7c 08 	! | . 
	call 00e6eh		;0e56	cd 6e 0e 	. n . 
	ret			;0e59	c9 	. 
	ld a,(de)			;0e5a	1a 	. 
	and 007h		;0e5b	e6 07 	. . 
	rlca			;0e5d	07 	. 
	rlca			;0e5e	07 	. 
	rlca			;0e5f	07 	. 
	rlca			;0e60	07 	. 
	ld c,a			;0e61	4f 	O 
	inc de			;0e62	13 	. 
	ld a,(de)			;0e63	1a 	. 
	and 00fh		;0e64	e6 0f 	. . 
	or c			;0e66	b1 	. 
	ld (hl),a			;0e67	77 	w 
	inc de			;0e68	13 	. 
	inc hl			;0e69	23 	# 
	inc hl			;0e6a	23 	# 
	djnz $-17		;0e6b	10 ed 	. . 
	ret			;0e6d	c9 	. 
	ld de,(CURSOR)		;0e6e	ed 5b b7 e0 	. [ . . 
	inc de			;0e72	13 	. 
	ld b,(hl)			;0e73	46 	F 
	inc hl			;0e74	23 	# 
	ld a,(de)			;0e75	1a 	. 
	and 040h		;0e76	e6 40 	. @ 
	or (hl)			;0e78	b6 	. 
	ld (de),a			;0e79	12 	. 
	inc de			;0e7a	13 	. 
	inc de			;0e7b	13 	. 
	inc hl			;0e7c	23 	# 
	djnz $-8		;0e7d	10 f6 	. . 
	ret			;0e7f	c9 	. 
	ld de,(CURSOR)		;0e80	ed 5b b7 e0 	. [ . . 
	ld b,(hl)			;0e84	46 	F 
	inc hl			;0e85	23 	# 
	ld a,(hl)			;0e86	7e 	~ 
	ld (de),a			;0e87	12 	. 
	inc de			;0e88	13 	. 
	inc de			;0e89	13 	. 
	inc hl			;0e8a	23 	# 
	djnz $-5		;0e8b	10 f9 	. . 
	ret			;0e8d	c9 	. 
	xor a			;0e8e	af 	. 
	ld (BSCRPE),a		;0e8f	32 ad e0 	2 . . 
	jr $+7		;0e92	18 05 	. . 
	ld a,001h		;0e94	3e 01 	> . 
	ld (BSCRPE),a		;0e96	32 ad e0 	2 . . 
	push bc			;0e99	c5 	. 
	push de			;0e9a	d5 	. 
	push hl			;0e9b	e5 	. 
	ld hl,(CURSOR)		;0e9c	2a b7 e0 	* . . 
	inc hl			;0e9f	23 	# 
	ld a,(CHRCNT)		;0ea0	3a b1 e0 	: . . 
	ld b,a			;0ea3	47 	G 
	ld a,(BSCRPE)		;0ea4	3a ad e0 	: . . 
	rra			;0ea7	1f 	. 
	jr c,$+17		;0ea8	38 0f 	8 . 
	ld a,b			;0eaa	78 	x 
	cp 04fh		;0eab	fe 4f 	. O 
	jr z,$+35		;0ead	28 21 	( ! 
	inc b			;0eaf	04 	. 
	inc hl			;0eb0	23 	# 
	inc hl			;0eb1	23 	# 
	ld a,(hl)			;0eb2	7e 	~ 
	bit 7,a		;0eb3	cb 7f 	.  
	jr z,$-11		;0eb5	28 f3 	( . 
	jr $+15		;0eb7	18 0d 	. . 
	ld a,b			;0eb9	78 	x 
	cp 000h		;0eba	fe 00 	. . 
	jr z,$+20		;0ebc	28 12 	( . 
	dec b			;0ebe	05 	. 
	dec hl			;0ebf	2b 	+ 
	dec hl			;0ec0	2b 	+ 
	ld a,(hl)			;0ec1	7e 	~ 
	bit 7,a		;0ec2	cb 7f 	.  
	jr z,$-11		;0ec4	28 f3 	( . 
	ld a,b			;0ec6	78 	x 
	ld (CHRCNT),a		;0ec7	32 b1 e0 	2 . . 
	call 03203h		;0eca	cd 03 32 	. . 2 
	xor a			;0ecd	af 	. 
	jr $+4		;0ece	18 02 	. . 
	xor a			;0ed0	af 	. 
	inc a			;0ed1	3c 	< 
	pop hl			;0ed2	e1 	. 
	pop de			;0ed3	d1 	. 
	pop bc			;0ed4	c1 	. 
	ret			;0ed5	c9 	. 
	ld a,001h		;0ed6	3e 01 	> . 
	ld (TIPE),a		;0ed8	32 ee e0 	2 . . 
	ld hl,04000h		;0edb	21 00 40 	! . @ 
	ld (MODEST),hl		;0ede	22 d9 e0 	" . . 
	jr $+6		;0ee1	18 04 	. . 
	xor a			;0ee3	af 	. 
	ld (TIPE),a		;0ee4	32 ee e0 	2 . . 
	call 00e47h		;0ee7	cd 47 0e 	. G . 
	ld hl,0099bh		;0eea	21 9b 09 	! . . 
	call 00e80h		;0eed	cd 80 0e 	. . . 
	ld a,028h		;0ef0	3e 28 	> ( 
	ld (CHRCNT),a		;0ef2	32 b1 e0 	2 . . 
	call 03203h		;0ef5	cd 03 32 	. . 2 
	ld hl,009c4h		;0ef8	21 c4 09 	! . . 
	ld a,(TIPE)		;0efb	3a ee e0 	: . . 
	rra			;0efe	1f 	. 
	jr c,$+5		;0eff	38 03 	8 . 
	ld hl,00a91h		;0f01	21 91 0a 	! . . 
	call 00e80h		;0f04	cd 80 0e 	. . . 
	call 021f5h		;0f07	cd f5 21 	. . ! 
	call 0210fh		;0f0a	cd 0f 21 	. . ! 
	ld hl,009edh		;0f0d	21 ed 09 	! . . 
	call 00e80h		;0f10	cd 80 0e 	. . . 
	ld a,(TIPE)		;0f13	3a ee e0 	: . . 
	rra			;0f16	1f 	. 
	jr nc,$+19		;0f17	30 11 	0 . 
	ld a,04ah		;0f19	3e 4a 	> J 
	ld (CHRCNT),a		;0f1b	32 b1 e0 	2 . . 
	call 03203h		;0f1e	cd 03 32 	. . 2 
	ld hl,00a38h		;0f21	21 38 0a 	! 8 . 
	call 00e80h		;0f24	cd 80 0e 	. . . 
	call 021cah		;0f27	cd ca 21 	. . ! 
	ld hl,00a3fh		;0f2a	21 3f 0a 	! ? . 
	call 00e6eh		;0f2d	cd 6e 0e 	. n . 
	ld a,028h		;0f30	3e 28 	> ( 
	ld (CHRCNT),a		;0f32	32 b1 e0 	2 . . 
	call 03203h		;0f35	cd 03 32 	. . 2 
	ld hl,00a68h		;0f38	21 68 0a 	! h . 
	ld a,(TIPE)		;0f3b	3a ee e0 	: . . 
	rra			;0f3e	1f 	. 
	jr c,$+5		;0f3f	38 03 	8 . 
	ld hl,00abah		;0f41	21 ba 0a 	! . . 
	call 00e6eh		;0f44	cd 6e 0e 	. n . 
	call 021cah		;0f47	cd ca 21 	. . ! 
	call 00e8eh		;0f4a	cd 8e 0e 	. . . 
	ld de,(MODEST)		;0f4d	ed 5b d9 e0 	. [ . . 
	ld b,006h		;0f51	06 06 	. . 
	call 01168h		;0f53	cd 68 11 	. h . 
	ld b,00ch		;0f56	06 0c 	. . 
	ld a,(TIPE)		;0f58	3a ee e0 	: . . 
	rra			;0f5b	1f 	. 
	jr c,$+4		;0f5c	38 02 	8 . 
	ld b,018h		;0f5e	06 18 	. . 
	call 0112bh		;0f60	cd 2b 11 	. + . 
	call 021cah		;0f63	cd ca 21 	. . ! 
	call 00e8eh		;0f66	cd 8e 0e 	. . . 
	jr $+5		;0f69	18 03 	. . 
	call 01519h		;0f6b	cd 19 15 	. . . 
	call 02925h		;0f6e	cd 25 29 	. % ) 
	bit 7,b		;0f71	cb 78 	. x 
	jr nz,$-5		;0f73	20 f9 	  . 
	ld a,b			;0f75	78 	x 
	cp 06fh		;0f76	fe 6f 	. o 
	jp z,0100fh		;0f78	ca 0f 10 	. . . 
	call 02947h		;0f7b	cd 47 29 	. G ) 
	cp 020h		;0f7e	fe 20 	.   
	jr z,$+85		;0f80	28 53 	( S 
	cp 0e1h		;0f82	fe e1 	. . 
	jr nz,$+7		;0f84	20 05 	  . 
	call 00e94h		;0f86	cd 94 0e 	. . . 
	jr $+79		;0f89	18 4d 	. M 
	cp 08bh		;0f8b	fe 8b 	. . 
	jr nc,$-34		;0f8d	30 dc 	0 . 
	cp 081h		;0f8f	fe 81 	. . 
	jr c,$+19		;0f91	38 11 	8 . 
	ld hl,011a8h		;0f93	21 a8 11 	! . . 
	ld b,a			;0f96	47 	G 
	ld a,(TIPE)		;0f97	3a ee e0 	: . . 
	rra			;0f9a	1f 	. 
	jr c,$+5		;0f9b	38 03 	8 . 
	ld hl,011bch		;0f9d	21 bc 11 	! . . 
	ld a,b			;0fa0	78 	x 
	jp 01186h		;0fa1	c3 86 11 	. . . 
	call 00fddh		;0fa4	cd dd 0f 	. . . 
	jr z,$+46		;0fa7	28 2c 	( , 
	jr $-62		;0fa9	18 c0 	. . 
	ld a,008h		;0fab	3e 08 	> . 
	jr $+34		;0fad	18 20 	.   
	ld a,010h		;0faf	3e 10 	> . 
	jr $+30		;0fb1	18 1c 	. . 
	ld a,018h		;0fb3	3e 18 	> . 
	jr $+26		;0fb5	18 18 	. . 
	ld a,020h		;0fb7	3e 20 	>   
	jr $+22		;0fb9	18 14 	. . 
	ld a,028h		;0fbb	3e 28 	> ( 
	jr $+18		;0fbd	18 10 	. . 
	ld a,031h		;0fbf	3e 31 	> 1 
	jr $+14		;0fc1	18 0c 	. . 
	ld a,039h		;0fc3	3e 39 	> 9 
	jr $+10		;0fc5	18 08 	. . 
	ld a,041h		;0fc7	3e 41 	> A 
	jr $+6		;0fc9	18 04 	. . 
	ld a,049h		;0fcb	3e 49 	> I 
	jr $+2		;0fcd	18 00 	. . 
	ld (CHRCNT),a		;0fcf	32 b1 e0 	2 . . 
	call 03203h		;0fd2	cd 03 32 	. . 2 
	call 00e8eh		;0fd5	cd 8e 0e 	. . . 
	jr nz,$-45		;0fd8	20 d1 	  . 
	jp 00f6eh		;0fda	c3 6e 0f 	. n . 
	ld hl,(CURSOR)		;0fdd	2a b7 e0 	* . . 
	inc hl			;0fe0	23 	# 
	ld c,(hl)			;0fe1	4e 	N 
	cp 030h		;0fe2	fe 30 	. 0 
	jr c,$+36		;0fe4	38 22 	8 " 
	cp 032h		;0fe6	fe 32 	. 2 
	jr c,$+35		;0fe8	38 21 	8 ! 
	cp 038h		;0fea	fe 38 	. 8 
	jr c,$+18		;0fec	38 10 	8 . 
	cp 03ah		;0fee	fe 3a 	. : 
	jr c,$+20		;0ff0	38 12 	8 . 
	sub 020h		;0ff2	d6 20 	.   
	cp 041h		;0ff4	fe 41 	. A 
	jr c,$+18		;0ff6	38 10 	8 . 
	cp 047h		;0ff8	fe 47 	. G 
	jr c,$+10		;0ffa	38 08 	8 . 
	jr $+12		;0ffc	18 0a 	. . 
	bit 6,c		;0ffe	cb 71 	. q 
	jr nz,$+11		;1000	20 09 	  . 
	jr $+6		;1002	18 04 	. . 
	bit 5,c		;1004	cb 69 	. i 
	jr nz,$+5		;1006	20 03 	  . 
	xor a			;1008	af 	. 
	inc a			;1009	3c 	< 
	ret			;100a	c9 	. 
	dec hl			;100b	2b 	+ 
	ld (hl),a			;100c	77 	w 
	xor a			;100d	af 	. 
	ret			;100e	c9 	. 
	call 021cah		;100f	cd ca 21 	. . ! 
	ld b,006h		;1012	06 06 	. . 
	ld de,(MODEST)		;1014	ed 5b d9 e0 	. [ . . 
	call 01141h		;1018	cd 41 11 	. A . 
	call 00e8eh		;101b	cd 8e 0e 	. . . 
	ld b,00ch		;101e	06 0c 	. . 
	ld a,(TIPE)		;1020	3a ee e0 	: . . 
	rra			;1023	1f 	. 
	jr c,$+4		;1024	38 02 	8 . 
	ld b,018h		;1026	06 18 	. . 
	ld hl,(CURSOR)		;1028	2a b7 e0 	* . . 
	ld a,(hl)			;102b	7e 	~ 
	sub 030h		;102c	d6 30 	. 0 
	cp 00ah		;102e	fe 0a 	. . 
	jr c,$+4		;1030	38 02 	8 . 
	sub 007h		;1032	d6 07 	. . 
	ld (de),a			;1034	12 	. 
	call 00e8eh		;1035	cd 8e 0e 	. . . 
	inc de			;1038	13 	. 
	djnz $-17		;1039	10 ed 	. . 
	ld a,009h		;103b	3e 09 	> . 
	ld (0401dh),a		;103d	32 1d 40 	2 . @ 
	ld a,006h		;1040	3e 06 	> . 
	ld (0401eh),a		;1042	32 1e 40 	2 . @ 
	call 0104bh		;1045	cd 4b 10 	. K . 
	jp 00f6eh		;1048	c3 6e 0f 	. n . 
	xor a			;104b	af 	. 
	ld (0401fh),a		;104c	32 1f 40 	2 . @ 
	ld c,00fh		;104f	0e 0f 	. . 
	ld hl,04000h		;1051	21 00 40 	! . @ 
	ld de,04100h		;1054	11 00 41 	. . A 
	call 03d09h		;1057	cd 09 3d 	. . = 
	ld a,b			;105a	78 	x 
	rra			;105b	1f 	. 
	jr nc,$+4		;105c	30 02 	0 . 
	set 3,a		;105e	cb df 	. . 
	ld (0401fh),a		;1060	32 1f 40 	2 . @ 
	ret			;1063	c9 	. 
	call 02069h		;1064	cd 69 20 	. i   
	ld d,000h		;1067	16 00 	. . 
	ld e,01ah		;1069	1e 1a 	. . 
	call 031fbh		;106b	cd fb 31 	. . 1 
	ld hl,008e5h		;106e	21 e5 08 	! . . 
	call 022a6h		;1071	cd a6 22 	. . " 
	jr $+5		;1074	18 03 	. . 
	call 01519h		;1076	cd 19 15 	. . . 
	call 02925h		;1079	cd 25 29 	. % ) 
	bit 7,b		;107c	cb 78 	. x 
	jr nz,$-5		;107e	20 f9 	  . 
	call 02947h		;1080	cd 47 29 	. G ) 
	cp 031h		;1083	fe 31 	. 1 
	jr c,$-15		;1085	38 ef 	8 . 
	cp 033h		;1087	fe 33 	. 3 
	jr c,$+11		;1089	38 09 	8 . 
	cp 037h		;108b	fe 37 	. 7 
	jr nc,$-23		;108d	30 e7 	0 . 
	call 0109ah		;108f	cd 9a 10 	. . . 
	jr $+31		;1092	18 1d 	. . 
	call 0109ah		;1094	cd 9a 10 	. . . 
	jp 00ee3h		;1097	c3 e3 0e 	. . . 
	ld hl,(CURSOR)		;109a	2a b7 e0 	* . . 
	ld (hl),a			;109d	77 	w 
	inc hl			;109e	23 	# 
	ld (hl),000h		;109f	36 00 	6 . 
	and 007h		;10a1	e6 07 	. . 
	ld (MDACT),a		;10a3	32 fe e0 	2 . . 
	rrca			;10a6	0f 	. 
	rrca			;10a7	0f 	. 
	rrca			;10a8	0f 	. 
	ld hl,04000h		;10a9	21 00 40 	! . @ 
	ld l,a			;10ac	6f 	o 
	ld (MODEST),hl		;10ad	22 d9 e0 	" . . 
	ret			;10b0	c9 	. 
	call 02201h		;10b1	cd 01 22 	. . " 
	ld hl,00ae3h		;10b4	21 e3 0a 	! . . 
	call 022a6h		;10b7	cd a6 22 	. . " 
	ld hl,00af4h		;10ba	21 f4 0a 	! . . 
	call 00e6eh		;10bd	cd 6e 0e 	. n . 
	ld a,(MDACT)		;10c0	3a fe e0 	: . . 
	ld de,040e0h		;10c3	11 e0 40 	. . @ 
	cp 003h		;10c6	fe 03 	. . 
	jr z,$+19		;10c8	28 11 	( . 
	ld de,040e8h		;10ca	11 e8 40 	. . @ 
	cp 004h		;10cd	fe 04 	. . 
	jr z,$+12		;10cf	28 0a 	( . 
	ld de,040f0h		;10d1	11 f0 40 	. . @ 
	cp 005h		;10d4	fe 05 	. . 
	jr z,$+5		;10d6	28 03 	( . 
	ld de,040f8h		;10d8	11 f8 40 	. . @ 
	ld hl,(CURSOR)		;10db	2a b7 e0 	* . . 
	ld b,004h		;10de	06 04 	. . 
	push de			;10e0	d5 	. 
	call 00e5ah		;10e1	cd 5a 0e 	. Z . 
	pop de			;10e4	d1 	. 
	jr $+5		;10e5	18 03 	. . 
	call 01519h		;10e7	cd 19 15 	. . . 
	call 02925h		;10ea	cd 25 29 	. % ) 
	bit 7,b		;10ed	cb 78 	. x 
	jr nz,$-5		;10ef	20 f9 	  . 
	call 02947h		;10f1	cd 47 29 	. G ) 
	cp 0e3h		;10f4	fe e3 	. . 
	jr z,$+47		;10f6	28 2d 	( - 
	ld b,a			;10f8	47 	G 
	push de			;10f9	d5 	. 
	call 027f5h		;10fa	cd f5 27 	. . ' 
	pop de			;10fd	d1 	. 
	ld a,b			;10fe	78 	x 
	cp 020h		;10ff	fe 20 	.   
	jr c,$-26		;1101	38 e4 	8 . 
	cp 07fh		;1103	fe 7f 	.  
	jr nc,$-30		;1105	30 e0 	0 . 
	cp 050h		;1107	fe 50 	. P 
	jr c,$+4		;1109	38 02 	8 . 
	sub 020h		;110b	d6 20 	.   
	ld hl,(CURSOR)		;110d	2a b7 e0 	* . . 
	ld (hl),a			;1110	77 	w 
	inc hl			;1111	23 	# 
	ld (hl),000h		;1112	36 00 	6 . 
	ld c,a			;1114	4f 	O 
	rrca			;1115	0f 	. 
	rrca			;1116	0f 	. 
	rrca			;1117	0f 	. 
	rrca			;1118	0f 	. 
	and 007h		;1119	e6 07 	. . 
	ld (de),a			;111b	12 	. 
	inc de			;111c	13 	. 
	ld a,c			;111d	79 	y 
	ld (de),a			;111e	12 	. 
	inc de			;111f	13 	. 
	call 00e8eh		;1120	cd 8e 0e 	. . . 
	jr z,$-57		;1123	28 c5 	( . 
	call 0104bh		;1125	cd 4b 10 	. K . 
	jp 00ee3h		;1128	c3 e3 0e 	. . . 
	ld a,(de)			;112b	1a 	. 
	call 01137h		;112c	cd 37 11 	. 7 . 
	ld c,a			;112f	4f 	O 
	call 0117ch		;1130	cd 7c 11 	. | . 
	inc de			;1133	13 	. 
	djnz $-9		;1134	10 f5 	. . 
	ret			;1136	c9 	. 
	and 00fh		;1137	e6 0f 	. . 
	add a,030h		;1139	c6 30 	. 0 
	cp 03ah		;113b	fe 3a 	. : 
	ret c			;113d	d8 	. 
	add a,007h		;113e	c6 07 	. . 
	ret			;1140	c9 	. 
	call 0115eh		;1141	cd 5e 11 	. ^ . 
	ld c,a			;1144	4f 	O 
	call 0115eh		;1145	cd 5e 11 	. ^ . 
	rlca			;1148	07 	. 
	or c			;1149	b1 	. 
	ld c,a			;114a	4f 	O 
	call 0115eh		;114b	cd 5e 11 	. ^ . 
	rlca			;114e	07 	. 
	rlca			;114f	07 	. 
	or c			;1150	b1 	. 
	ld c,a			;1151	4f 	O 
	call 0115eh		;1152	cd 5e 11 	. ^ . 
	rlca			;1155	07 	. 
	rlca			;1156	07 	. 
	rlca			;1157	07 	. 
	or c			;1158	b1 	. 
	ld (de),a			;1159	12 	. 
	inc de			;115a	13 	. 
	djnz $-26		;115b	10 e4 	. . 
	ret			;115d	c9 	. 
	call 00e8eh		;115e	cd 8e 0e 	. . . 
	ld hl,(CURSOR)		;1161	2a b7 e0 	* . . 
	ld a,(hl)			;1164	7e 	~ 
	and 001h		;1165	e6 01 	. . 
	ret			;1167	c9 	. 
	push bc			;1168	c5 	. 
	ld a,(de)			;1169	1a 	. 
	ld b,004h		;116a	06 04 	. . 
	ld c,030h		;116c	0e 30 	. 0 
	rrca			;116e	0f 	. 
	jr nc,$+3		;116f	30 01 	0 . 
	inc c			;1171	0c 	. 
	call 0117ch		;1172	cd 7c 11 	. | . 
	djnz $-9		;1175	10 f5 	. . 
	inc de			;1177	13 	. 
	pop bc			;1178	c1 	. 
	djnz $-17		;1179	10 ed 	. . 
	ret			;117b	c9 	. 
	ld hl,(CURSOR)		;117c	2a b7 e0 	* . . 
	ld (hl),c			;117f	71 	q 
	push af			;1180	f5 	. 
	call 00e8eh		;1181	cd 8e 0e 	. . . 
	pop af			;1184	f1 	. 
	ret			;1185	c9 	. 
	and 00fh		;1186	e6 0f 	. . 
	ld b,a			;1188	47 	G 
	dec a			;1189	3d 	= 
	rlca			;118a	07 	. 
	ld e,a			;118b	5f 	_ 
	ld d,000h		;118c	16 00 	. . 
	add hl,de			;118e	19 	. 
	ld e,(hl)			;118f	5e 	^ 
	inc hl			;1190	23 	# 
	ld d,(hl)			;1191	56 	V 
	ex de,hl			;1192	eb 	. 
	jp (hl)			;1193	e9 	. 
	ld l,a			;1194	6f 	o 
	dec c			;1195	0d 	. 
	ld l,a			;1196	6f 	o 
	dec c			;1197	0d 	. 
	ld l,a			;1198	6f 	o 
	dec c			;1199	0d 	. 
	ld l,a			;119a	6f 	o 
	dec c			;119b	0d 	. 
	ld l,a			;119c	6f 	o 
	dec c			;119d	0d 	. 
	ld l,a			;119e	6f 	o 
	dec c			;119f	0d 	. 
	ld (0060eh),a		;11a0	32 0e 06 	2 . . 
	dec a			;11a3	3d 	= 
	rla			;11a4	17 	. 
	dec c			;11a5	0d 	. 
	rla			;11a6	17 	. 
	dec c			;11a7	0d 	. 
	sub d			;11a8	92 	. 
	inc c			;11a9	0c 	. 
	xor e			;11aa	ab 	. 
	rrca			;11ab	0f 	. 
	xor a			;11ac	af 	. 
	rrca			;11ad	0f 	. 
	or e			;11ae	b3 	. 
	rrca			;11af	0f 	. 
	or a			;11b0	b7 	. 
	rrca			;11b1	0f 	. 
	cp e			;11b2	bb 	. 
	rrca			;11b3	0f 	. 
	cp a			;11b4	bf 	. 
	rrca			;11b5	0f 	. 
	jp 0c70fh		;11b6	c3 0f c7 	. . . 
	rrca			;11b9	0f 	. 
	ld h,h			;11ba	64 	d 
	djnz $-101		;11bb	10 99 	. . 
	inc c			;11bd	0c 	. 
	xor e			;11be	ab 	. 
	rrca			;11bf	0f 	. 
	xor a			;11c0	af 	. 
	rrca			;11c1	0f 	. 
	or e			;11c2	b3 	. 
	rrca			;11c3	0f 	. 
	or a			;11c4	b7 	. 
	rrca			;11c5	0f 	. 
	cp e			;11c6	bb 	. 
	rrca			;11c7	0f 	. 
	cp a			;11c8	bf 	. 
	rrca			;11c9	0f 	. 
	jp 0c70fh		;11ca	c3 0f c7 	. . . 
	rrca			;11cd	0f 	. 
	rrc a		;11ce	cb 0f 	. . 
	sub a			;11d0	97 	. 
	inc d			;11d1	14 	. 
	and 012h		;11d2	e6 12 	. . 
	ld bc,02113h		;11d4	01 13 21 	. . ! 
	inc de			;11d7	13 	. 
	ld l,013h		;11d8	2e 13 	. . 
	ld d,d			;11da	52 	R 
	inc de			;11db	13 	. 
	ld a,l			;11dc	7d 	} 
	inc de			;11dd	13 	. 
	sub d			;11de	92 	. 
	inc de			;11df	13 	. 
	and a			;11e0	a7 	. 
	inc de			;11e1	13 	. 
	ld d,e			;11e2	53 	S 
	ld (de),a			;11e3	12 	. 
	sub a			;11e4	97 	. 
	inc d			;11e5	14 	. 
	cp h			;11e6	bc 	. 
	inc de			;11e7	13 	. 
	jp c,0f513h		;11e8	da 13 f5 	. . . 
	inc de			;11eb	13 	. 
	djnz $+22		;11ec	10 14 	. . 
	jr c,$+22		;11ee	38 14 	8 . 
	ld c,l			;11f0	4d 	M 
	inc d			;11f1	14 	. 
	ld l,e			;11f2	6b 	k 
	inc d			;11f3	14 	. 
	adc a,c			;11f4	89 	. 
	inc d			;11f5	14 	. 
	sub d			;11f6	92 	. 
	inc c			;11f7	0c 	. 
	call 025b3h		;11f8	cd b3 25 	. . % 
	xor a			;11fb	af 	. 
	ld (LNNCHG),a		;11fc	32 d2 e0 	2 . . 
	ld (CHNCHG),a		;11ff	32 b0 e0 	2 . . 
	inc a			;1202	3c 	< 
	ld (STALN),a		;1203	32 ea e0 	2 . . 
	call 00e47h		;1206	cd 47 0e 	. G . 
	ld hl,00b14h		;1209	21 14 0b 	! . . 
	call 00e80h		;120c	cd 80 0e 	. . . 
	call 021f5h		;120f	cd f5 21 	. . ! 
	ld hl,009edh		;1212	21 ed 09 	! . . 
	call 00e80h		;1215	cd 80 0e 	. . . 
	ld a,04ah		;1218	3e 4a 	> J 
	ld (CHRCNT),a		;121a	32 b1 e0 	2 . . 
	call 03203h		;121d	cd 03 32 	. . 2 
	ld hl,00badh		;1220	21 ad 0b 	! . . 
	call 00e80h		;1223	cd 80 0e 	. . . 
	ld de,OBYTE1		;1226	11 46 e0 	. F . 
	ld a,(de)			;1229	1a 	. 
	cpl			;122a	2f 	/ 
	ld (de),a			;122b	12 	. 
	inc de			;122c	13 	. 
	ld a,(de)			;122d	1a 	. 
	cpl			;122e	2f 	/ 
	ld (de),a			;122f	12 	. 
	ld a,001h		;1230	3e 01 	> . 
	ld (SAVEA),a		;1232	32 e2 e0 	2 . . 
	call 012e6h		;1235	cd e6 12 	. . . 
	call 01301h		;1238	cd 01 13 	. . . 
	call 01321h		;123b	cd 21 13 	. ! . 
	call 0132eh		;123e	cd 2e 13 	. . . 
	call 01352h		;1241	cd 52 13 	. R . 
	call 0137dh		;1244	cd 7d 13 	. } . 
	call 01392h		;1247	cd 92 13 	. . . 
	call 013a7h		;124a	cd a7 13 	. . . 
	xor a			;124d	af 	. 
	ld (SAVEA),a		;124e	32 e2 e0 	2 . . 
	jr $+88		;1251	18 56 	. V 
	pop hl			;1253	e1 	. 
	ld a,002h		;1254	3e 02 	> . 
	ld (STALN),a		;1256	32 ea e0 	2 . . 
	ld a,0ffh		;1259	3e ff 	> . 
	ld (LNNCHG),a		;125b	32 d2 e0 	2 . . 
	ld (CHNCHG),a		;125e	32 b0 e0 	2 . . 
	ld d,009h		;1261	16 09 	. . 
	ld a,(LASTLN)		;1263	3a cd e0 	: . . 
	dec a			;1266	3d 	= 
	ld e,a			;1267	5f 	_ 
	call 031fbh		;1268	cd fb 31 	. . 1 
	ld hl,00b65h		;126b	21 65 0b 	! e . 
	call 00e80h		;126e	cd 80 0e 	. . . 
	ld d,000h		;1271	16 00 	. . 
	ld a,(LASTLN)		;1273	3a cd e0 	: . . 
	ld e,a			;1276	5f 	_ 
	call 021f5h		;1277	cd f5 21 	. . ! 
	ld de,OBYTE3		;127a	11 48 e0 	. H . 
	ld a,(de)			;127d	1a 	. 
	cpl			;127e	2f 	/ 
	ld (de),a			;127f	12 	. 
	inc de			;1280	13 	. 
	ld a,(de)			;1281	1a 	. 
	cpl			;1282	2f 	/ 
	ld (de),a			;1283	12 	. 
	ld hl,TBAUD		;1284	21 58 e0 	! X . 
	dec (hl)			;1287	35 	5 
	call 013bch		;1288	cd bc 13 	. . . 
	call 013dah		;128b	cd da 13 	. . . 
	call 013f5h		;128e	cd f5 13 	. . . 
	call 01410h		;1291	cd 10 14 	. . . 
	call 01438h		;1294	cd 38 14 	. 8 . 
	call 0144dh		;1297	cd 4d 14 	. M . 
	call 0146bh		;129a	cd 6b 14 	. k . 
	call 01489h		;129d	cd 89 14 	. . . 
	xor a			;12a0	af 	. 
	ld (SAVECR),a		;12a1	32 f6 e0 	2 . . 
	jr $+5		;12a4	18 03 	. . 
	call 01519h		;12a6	cd 19 15 	. . . 
	ld a,085h		;12a9	3e 85 	> . 
	out (01ch),a		;12ab	d3 1c 	. . 
	call 02925h		;12ad	cd 25 29 	. % ) 
	bit 7,b		;12b0	cb 78 	. x 
	jr nz,$-5		;12b2	20 f9 	  . 
	call 02947h		;12b4	cd 47 29 	. G ) 
	cp 081h		;12b7	fe 81 	. . 
	jr c,$-19		;12b9	38 eb 	8 . 
	cp 08bh		;12bb	fe 8b 	. . 
	jr nc,$-23		;12bd	30 e7 	0 . 
	ld b,a			;12bf	47 	G 
	ld hl,011d0h		;12c0	21 d0 11 	! . . 
	ld a,(STALN)		;12c3	3a ea e0 	: . . 
	cp 001h		;12c6	fe 01 	. . 
	jr z,$+5		;12c8	28 03 	( . 
	ld hl,011e4h		;12ca	21 e4 11 	! . . 
	ld a,b			;12cd	78 	x 
	call 01186h		;12ce	cd 86 11 	. . . 
	jr $-40		;12d1	18 d6 	. . 
	ld a,b			;12d3	78 	x 
	ld (CHRCNT),a		;12d4	32 b1 e0 	2 . . 
	push hl			;12d7	e5 	. 
	call 03203h		;12d8	cd 03 32 	. . 2 
	pop hl			;12db	e1 	. 
	ld b,006h		;12dc	06 06 	. . 
	ld de,(CURSOR)		;12de	ed 5b b7 e0 	. [ . . 
	call 00e86h		;12e2	cd 86 0e 	. . . 
	ret			;12e5	c9 	. 
	ld b,009h		;12e6	06 09 	. . 
	ld de,OBYTE1		;12e8	11 46 e0 	. F . 
	ld a,(de)			;12eb	1a 	. 
	xor 001h		;12ec	ee 01 	. . 
	ld (de),a			;12ee	12 	. 
	bit 0,a		;12ef	cb 47 	. G 
	ld hl,00bbah		;12f1	21 ba 0b 	! . . 
	jr z,$-33		;12f4	28 dd 	( . 
	call 02963h		;12f6	cd 63 29 	. c ) 
	call 0024ch		;12f9	cd 4c 02 	. L . 
	ld hl,00bb4h		;12fc	21 b4 0b 	! . . 
	jr $-44		;12ff	18 d2 	. . 
	ld b,011h		;1301	06 11 	. . 
	ld de,OBYTE1		;1303	11 46 e0 	. F . 
	ld a,(NOPTR)		;1306	3a f8 e0 	: . . 
	and a			;1309	a7 	. 
	jr z,$+7		;130a	28 05 	( . 
	ld a,(de)			;130c	1a 	. 
	res 1,a		;130d	cb 8f 	. . 
	ld (de),a			;130f	12 	. 
	ret			;1310	c9 	. 
	ld a,(de)			;1311	1a 	. 
	xor 002h		;1312	ee 02 	. . 
	ld (de),a			;1314	12 	. 
	bit 1,a		;1315	cb 4f 	. O 
	ld hl,00bb4h		;1317	21 b4 0b 	! . . 
	jr z,$-71		;131a	28 b7 	( . 
	ld hl,00bbah		;131c	21 ba 0b 	! . . 
	jr $-76		;131f	18 b2 	. . 
	ld b,019h		;1321	06 19 	. . 
	ld de,OBYTE1		;1323	11 46 e0 	. F . 
	ld a,(de)			;1326	1a 	. 
	xor 004h		;1327	ee 04 	. . 
	ld (de),a			;1329	12 	. 
	bit 2,a		;132a	cb 57 	. W 
	jr $-21		;132c	18 e9 	. . 
	ld b,021h		;132e	06 21 	. ! 
	ld de,OBYTE1		;1330	11 46 e0 	. F . 
	ld a,(de)			;1333	1a 	. 
	xor 008h		;1334	ee 08 	. . 
	ld (de),a			;1336	12 	. 
	bit 3,a		;1337	cb 5f 	. _ 
	jr nz,$+13		;1339	20 0b 	  . 
	in a,(024h)		;133b	db 24 	. $ 
	and 0fdh		;133d	e6 fd 	. . 
	out (024h),a		;133f	d3 24 	. $ 
	ld hl,00bc0h		;1341	21 c0 0b 	! . . 
	jr $-113		;1344	18 8d 	. . 
	in a,(024h)		;1346	db 24 	. $ 
	or 002h		;1348	f6 02 	. . 
	out (024h),a		;134a	d3 24 	. $ 
	ld hl,00bc6h		;134c	21 c6 0b 	! . . 
	jp 012d3h		;134f	c3 d3 12 	. . . 
	ld a,(SAVEA)		;1352	3a e2 e0 	: . . 
	rra			;1355	1f 	. 
	jr c,$+17		;1356	38 0f 	8 . 
	xor a			;1358	af 	. 
	ld (CPSLK),a		;1359	32 b6 e0 	2 . . 
	ld a,(SHIFT)		;135c	3a e6 e0 	: . . 
	and 0fdh		;135f	e6 fd 	. . 
	ld (SHIFT),a		;1361	32 e6 e0 	2 . . 
	call 028d1h		;1364	cd d1 28 	. . ( 
	ld b,029h		;1367	06 29 	. ) 
	ld de,OBYTE2		;1369	11 47 e0 	. G . 
	ld a,(de)			;136c	1a 	. 
	xor 001h		;136d	ee 01 	. . 
	ld (de),a			;136f	12 	. 
	bit 0,a		;1370	cb 47 	. G 
	ld hl,00bcch		;1372	21 cc 0b 	! . . 
	jr z,$+5		;1375	28 03 	( . 
	ld hl,00bd2h		;1377	21 d2 0b 	! . . 
	jp 012d3h		;137a	c3 d3 12 	. . . 
	ld b,032h		;137d	06 32 	. 2 
	ld de,OBYTE2		;137f	11 47 e0 	. G . 
	ld a,(de)			;1382	1a 	. 
	xor 002h		;1383	ee 02 	. . 
	ld (de),a			;1385	12 	. 
	bit 1,a		;1386	cb 4f 	. O 
	ld hl,00bd8h		;1388	21 d8 0b 	! . . 
	jr z,$-17		;138b	28 ed 	( . 
	ld hl,00bd2h		;138d	21 d2 0b 	! . . 
	jr $-22		;1390	18 e8 	. . 
	ld b,03ah		;1392	06 3a 	. : 
	ld de,OBYTE2		;1394	11 47 e0 	. G . 
	ld a,(de)			;1397	1a 	. 
	xor 004h		;1398	ee 04 	. . 
	ld (de),a			;139a	12 	. 
	bit 2,a		;139b	cb 57 	. W 
	ld hl,00be4h		;139d	21 e4 0b 	! . . 
	jr z,$-38		;13a0	28 d8 	( . 
	ld hl,00bdeh		;13a2	21 de 0b 	! . . 
	jr $-43		;13a5	18 d3 	. . 
	ld b,042h		;13a7	06 42 	. B 
	ld de,OBYTE2		;13a9	11 47 e0 	. G . 
	ld a,(de)			;13ac	1a 	. 
	xor 008h		;13ad	ee 08 	. . 
	ld (de),a			;13af	12 	. 
	bit 3,a		;13b0	cb 5f 	. _ 
	ld hl,00beah		;13b2	21 ea 0b 	! . . 
	jr z,$-59		;13b5	28 c3 	( . 
	ld hl,00bf0h		;13b7	21 f0 0b 	! . . 
	jr $-64		;13ba	18 be 	. . 
	ld b,009h		;13bc	06 09 	. . 
	ld de,OBYTE3		;13be	11 48 e0 	. H . 
	ld a,(de)			;13c1	1a 	. 
	xor 001h		;13c2	ee 01 	. . 
	ld (de),a			;13c4	12 	. 
	bit 0,a		;13c5	cb 47 	. G 
	jr z,$+12		;13c7	28 0a 	( . 
	ld hl,00bfch		;13c9	21 fc 0b 	! . . 
	ld a,009h		;13cc	3e 09 	> . 
	out (033h),a		;13ce	d3 33 	. 3 
	jp 012d3h		;13d0	c3 d3 12 	. . . 
	ld hl,00bf6h		;13d3	21 f6 0b 	! . . 
	ld a,008h		;13d6	3e 08 	> . 
	jr $-10		;13d8	18 f4 	. . 
	ld b,011h		;13da	06 11 	. . 
	ld de,OBYTE3		;13dc	11 48 e0 	. H . 
	ld a,(de)			;13df	1a 	. 
	xor 002h		;13e0	ee 02 	. . 
	ld (de),a			;13e2	12 	. 
	bit 1,a		;13e3	cb 4f 	. O 
	jr z,$+9		;13e5	28 07 	( . 
	ld hl,00c08h		;13e7	21 08 0c 	! . . 
	ld a,00bh		;13ea	3e 0b 	> . 
	jr $-30		;13ec	18 e0 	. . 
	ld hl,00c02h		;13ee	21 02 0c 	! . . 
	ld a,00ah		;13f1	3e 0a 	> . 
	jr $-37		;13f3	18 d9 	. . 
	ld b,019h		;13f5	06 19 	. . 
	ld de,OBYTE3		;13f7	11 48 e0 	. H . 
	ld a,(de)			;13fa	1a 	. 
	xor 004h		;13fb	ee 04 	. . 
	ld (de),a			;13fd	12 	. 
	bit 2,a		;13fe	cb 57 	. W 
	jr z,$+9		;1400	28 07 	( . 
	ld hl,00c14h		;1402	21 14 0c 	! . . 
	ld a,003h		;1405	3e 03 	> . 
	jr $-57		;1407	18 c5 	. . 
	ld hl,00c0eh		;1409	21 0e 0c 	! . . 
	ld a,002h		;140c	3e 02 	> . 
	jr $-64		;140e	18 be 	. . 
	ld b,021h		;1410	06 21 	. ! 
	ld a,001h		;1412	3e 01 	> . 
	ld (SAVECR),a		;1414	32 f6 e0 	2 . . 
	ld a,(TBAUD)		;1417	3a 58 e0 	: X . 
	inc a			;141a	3c 	< 
	and 00fh		;141b	e6 0f 	. . 
	cp 00ch		;141d	fe 0c 	. . 
	jr nz,$+3		;141f	20 01 	  . 
	xor a			;1421	af 	. 
	ld (TBAUD),a		;1422	32 58 e0 	2 X . 
	ld (RBAUD),a		;1425	32 59 e0 	2 Y . 
	ld hl,00c4ah		;1428	21 4a 0c 	! J . 
	ld c,a			;142b	4f 	O 
	add a,c			;142c	81 	. 
	add a,c			;142d	81 	. 
	add a,c			;142e	81 	. 
	add a,c			;142f	81 	. 
	add a,c			;1430	81 	. 
	ld e,a			;1431	5f 	_ 
	ld d,000h		;1432	16 00 	. . 
	add hl,de			;1434	19 	. 
	jp 012d3h		;1435	c3 d3 12 	. . . 
	ld b,029h		;1438	06 29 	. ) 
	ld de,OBYTE4		;143a	11 49 e0 	. I . 
	ld a,(de)			;143d	1a 	. 
	xor 001h		;143e	ee 01 	. . 
	ld (de),a			;1440	12 	. 
	bit 0,a		;1441	cb 47 	. G 
	ld hl,00c1ah		;1443	21 1a 0c 	! . . 
	jr z,$-17		;1446	28 ed 	( . 
	ld hl,00c20h		;1448	21 20 0c 	!   . 
	jr $-22		;144b	18 e8 	. . 
	ld b,032h		;144d	06 32 	. 2 
	ld a,(CHNCHG)		;144f	3a b0 e0 	: . . 
	cpl			;1452	2f 	/ 
	ld (CHNCHG),a		;1453	32 b0 e0 	2 . . 
	ld de,OBYTE4		;1456	11 49 e0 	. I . 
	ld a,(de)			;1459	1a 	. 
	xor 002h		;145a	ee 02 	. . 
	ld (de),a			;145c	12 	. 
	bit 1,a		;145d	cb 4f 	. O 
	jr z,$+7		;145f	28 05 	( . 
	ld hl,00c2ch		;1461	21 2c 0c 	! , . 
	jr $-47		;1464	18 cf 	. . 
	ld hl,00c26h		;1466	21 26 0c 	! & . 
	jr $-52		;1469	18 ca 	. . 
	ld b,03ah		;146b	06 3a 	. : 
	ld a,(LNNCHG)		;146d	3a d2 e0 	: . . 
	cpl			;1470	2f 	/ 
	ld (LNNCHG),a		;1471	32 d2 e0 	2 . . 
	ld de,OBYTE4		;1474	11 49 e0 	. I . 
	ld a,(de)			;1477	1a 	. 
	xor 004h		;1478	ee 04 	. . 
	ld (de),a			;147a	12 	. 
	bit 2,a		;147b	cb 57 	. W 
	jr z,$+7		;147d	28 05 	( . 
	ld hl,00c38h		;147f	21 38 0c 	! 8 . 
	jr $-77		;1482	18 b1 	. . 
	ld hl,00c32h		;1484	21 32 0c 	! 2 . 
	jr $-82		;1487	18 ac 	. . 
	ld b,042h		;1489	06 42 	. B 
	ld de,OBYTE4		;148b	11 49 e0 	. I . 
	ld a,(de)			;148e	1a 	. 
	xor 008h		;148f	ee 08 	. . 
	ld (de),a			;1491	12 	. 
	bit 3,a		;1492	cb 5f 	. _ 
	jp 01317h		;1494	c3 17 13 	. . . 
	pop hl			;1497	e1 	. 
	call 025e6h		;1498	cd e6 25 	. . % 
	call 0045ch		;149b	cd 5c 04 	. \ . 
	xor a			;149e	af 	. 
	ld (CONT),a		;149f	32 b5 e0 	2 . . 
	ld a,(SHIFT)		;14a2	3a e6 e0 	: . . 
	and 0fah		;14a5	e6 fa 	. . 
	ld (SHIFT),a		;14a7	32 e6 e0 	2 . . 
	ld a,(SAVECR)		;14aa	3a f6 e0 	: . . 
	and a			;14ad	a7 	. 
	call nz,00381h		;14ae	c4 81 03 	. . . 
	ld a,(LNNCHG)		;14b1	3a d2 e0 	: . . 
	ld b,a			;14b4	47 	G 
	ld a,(CHNCHG)		;14b5	3a b0 e0 	: . . 
	or b			;14b8	b0 	. 
	ret z			;14b9	c8 	. 
	jp 002b5h		;14ba	c3 b5 02 	. . . 
	ld a,(LNSIZE)		;14bd	3a d4 e0 	: . . 
	ld b,a			;14c0	47 	G 
	ld a,(CHRCNT)		;14c1	3a b1 e0 	: . . 
	cp b			;14c4	b8 	. 
	jr z,$+15		;14c5	28 0d 	( . 
	inc a			;14c7	3c 	< 
	ld (CHRCNT),a		;14c8	32 b1 e0 	2 . . 
	add a,007h		;14cb	c6 07 	. . 
	cp b			;14cd	b8 	. 
	call z,01509h		;14ce	cc 09 15 	. . . 
	jp 03203h		;14d1	c3 03 32 	. . 2 
	ld a,(LASTLN)		;14d4	3a cd e0 	: . . 
	ld b,a			;14d7	47 	G 
	ld a,(LNCNT)		;14d8	3a d1 e0 	: . . 
	inc a			;14db	3c 	< 
	cp b			;14dc	b8 	. 
	call z,01509h		;14dd	cc 09 15 	. . . 
	inc b			;14e0	04 	. 
	cp b			;14e1	b8 	. 
	jr z,$+8		;14e2	28 06 	( . 
	ld e,a			;14e4	5f 	_ 
	ld d,000h		;14e5	16 00 	. . 
	jp 031fbh		;14e7	c3 fb 31 	. . 1 
	ld a,(OBYTE2)		;14ea	3a 47 e0 	: G . 
	and 004h		;14ed	e6 04 	. . 
	jp z,021fah		;14ef	ca fa 21 	. . ! 
	xor a			;14f2	af 	. 
	ld (SRLFST),a		;14f3	32 e8 e0 	2 . . 
	ld a,(LASTLN)		;14f6	3a cd e0 	: . . 
	ld (SRLLST),a		;14f9	32 e9 e0 	2 . . 
	call 02f70h		;14fc	cd 70 2f 	. p / 
	ret			;14ff	c9 	. 
	ld a,(BLKMD)		;1500	3a ab e0 	: . . 
	and 001h		;1503	e6 01 	. . 
	call nz,01519h		;1505	c4 19 15 	. . . 
	ret			;1508	c9 	. 
	push af			;1509	f5 	. 
	ld a,(KBINP)		;150a	3a c9 e0 	: . . 
	rra			;150d	1f 	. 
	jr nc,$+24		;150e	30 16 	0 . 
	ld a,(OBYTE1)		;1510	3a 46 e0 	: F . 
	and 004h		;1513	e6 04 	. . 
	jr z,$+17		;1515	28 0f 	( . 
	jr $+3		;1517	18 01 	. . 
	push af			;1519	f5 	. 
	ld a,000h		;151a	3e 00 	> . 
	out (033h),a		;151c	d3 33 	. 3 
	ld a,01fh		;151e	3e 1f 	> . 
	ld (ALRACT),a		;1520	32 93 e0 	2 . . 
	call 0070bh		;1523	cd 0b 07 	. . . 
	pop af			;1526	f1 	. 
	ret			;1527	c9 	. 
	call 0337ch		;1528	cd 7c 33 	. | 3 
	call nz,01519h		;152b	c4 19 15 	. . . 
	ret			;152e	c9 	. 
	di			;152f	f3 	. 
	ld ix,0154ch		;1530	dd 21 4c 15 	. ! L . 
	call 00269h		;1534	cd 69 02 	. i . 
	call 0027eh		;1537	cd 7e 02 	. ~ . 
	jr $+6		;153a	18 04 	. . 
	ld ix,01549h		;153c	dd 21 49 15 	. ! I . 
	ld sp,0e000h		;1540	31 00 e0 	1 . . 
	call 01552h		;1543	cd 52 15 	. R . 
	ei			;1546	fb 	. 
	jp (ix)		;1547	dd e9 	. . 
	call 0166ch		;1549	cd 6c 16 	. l . 
	jp 02d95h		;154c	c3 95 2d 	. . - 
	call 0027eh		;154f	cd 7e 02 	. ~ . 
	call 0028bh		;1552	cd 8b 02 	. . . 
	call 00518h		;1555	cd 18 05 	. . . 
	call 028d1h		;1558	cd d1 28 	. . ( 
	call 002b5h		;155b	cd b5 02 	. . . 
	ld b,002h		;155e	06 02 	. . 
	ld a,(OBYTE3)		;1560	3a 48 e0 	: H . 
	and 004h		;1563	e6 04 	. . 
	jr z,$+4		;1565	28 02 	( . 
	ld b,003h		;1567	06 03 	. . 
	ld a,b			;1569	78 	x 
	out (033h),a		;156a	d3 33 	. 3 
	ld b,00ah		;156c	06 0a 	. . 
	ld a,(OBYTE3)		;156e	3a 48 e0 	: H . 
	and 002h		;1571	e6 02 	. . 
	jr z,$+4		;1573	28 02 	( . 
	ld b,00bh		;1575	06 0b 	. . 
	ld a,b			;1577	78 	x 
	out (033h),a		;1578	d3 33 	. 3 
	ld b,008h		;157a	06 08 	. . 
	ld a,(OBYTE3)		;157c	3a 48 e0 	: H . 
	and 001h		;157f	e6 01 	. . 
	jr z,$+4		;1581	28 02 	( . 
	ld b,009h		;1583	06 09 	. . 
	ld a,b			;1585	78 	x 
	out (033h),a		;1586	d3 33 	. 3 
	call 001f7h		;1588	cd f7 01 	. . . 
	call 0023dh		;158b	cd 3d 02 	. = . 
	call 00526h		;158e	cd 26 05 	. & . 
	call 00381h		;1591	cd 81 03 	. . . 
	ret			;1594	c9 	. 
	xor a			;1595	af 	. 
	ld (MLTACT),a		;1596	32 d6 e0 	2 . . 
	ret			;1599	c9 	. 
	ld hl,01595h		;159a	21 95 15 	! . . 
	jp 01a60h		;159d	c3 60 1a 	. ` . 
	ld hl,015a6h		;15a0	21 a6 15 	! . . 
	jp 01a5bh		;15a3	c3 5b 1a 	. [ . 
	ld a,(TBYTE1)		;15a6	3a 60 e0 	: ` . 
	and 004h		;15a9	e6 04 	. . 
	jr nz,$+6		;15ab	20 04 	  . 
	ld (MLTACT),a		;15ad	32 d6 e0 	2 . . 
	ret			;15b0	c9 	. 
	call 02954h		;15b1	cd 54 29 	. T ) 
	ld hl,BDATAR		;15b4	21 80 e0 	! . . 
	ld a,b			;15b7	78 	x 
	and 00fh		;15b8	e6 0f 	. . 
	jr nz,$+13		;15ba	20 0b 	  . 
	ld a,(CHAPAR)		;15bc	3a 6e e0 	: n . 
	ld (SAVEA),a		;15bf	32 e2 e0 	2 . . 
	call 00533h		;15c2	cd 33 05 	. 3 . 
	jr $+11		;15c5	18 09 	. . 
	ld a,(CHBPAR)		;15c7	3a 70 e0 	: p . 
	ld (SAVEA),a		;15ca	32 e2 e0 	2 . . 
	call 00544h		;15cd	cd 44 05 	. D . 
	ld b,006h		;15d0	06 06 	. . 
	call 0314ch		;15d2	cd 4c 31 	. L 1 
	call 0059dh		;15d5	cd 9d 05 	. . . 
	call 0059dh		;15d8	cd 9d 05 	. . . 
	call 005a2h		;15db	cd a2 05 	. . . 
	ld b,001h		;15de	06 01 	. . 
	call 005b5h		;15e0	cd b5 05 	. . . 
	ld b,004h		;15e3	06 04 	. . 
	ld c,002h		;15e5	0e 02 	. . 
	ld de,0069ch		;15e7	11 9c 06 	. . . 
	call 00601h		;15ea	cd 01 06 	. . . 
	ld hl,015f3h		;15ed	21 f3 15 	! . . 
	jp 01a60h		;15f0	c3 60 1a 	. ` . 
	ld a,b			;15f3	78 	x 
	cp 01eh		;15f4	fe 1e 	. . 
	jr z,$+8		;15f6	28 06 	( . 
	cp 012h		;15f8	fe 12 	. . 
	jr z,$+15		;15fa	28 0d 	( . 
	jr $+19		;15fc	18 11 	. . 
	ld a,(RSRCV)		;15fe	3a e0 e0 	: . . 
	and a			;1601	a7 	. 
	jr nz,$+13		;1602	20 0b 	  . 
	inc a			;1604	3c 	< 
	ld (RSRCV),a		;1605	32 e0 e0 	2 . . 
	ret			;1608	c9 	. 
	ld a,(RSRCV)		;1609	3a e0 e0 	: . . 
	and a			;160c	a7 	. 
	jr nz,$+17		;160d	20 0f 	  . 
	xor a			;160f	af 	. 
	ld (RSRCV),a		;1610	32 e0 e0 	2 . . 
	call 005a2h		;1613	cd a2 05 	. . . 
	and 020h		;1616	e6 20 	.   
	jr z,$-5		;1618	28 f9 	( . 
	call 005b0h		;161a	cd b0 05 	. . . 
	ret			;161d	c9 	. 
	xor a			;161e	af 	. 
	ld (RSRCV),a		;161f	32 e0 e0 	2 . . 
	ld (MLTACT),a		;1622	32 d6 e0 	2 . . 
	ld b,a			;1625	47 	G 
	call 005b5h		;1626	cd b5 05 	. . . 
	ld b,002h		;1629	06 02 	. . 
	call 005f2h		;162b	cd f2 05 	. . . 
	call 02963h		;162e	cd 63 29 	. c ) 
	ret			;1631	c9 	. 
	ld a,005h		;1632	3e 05 	> . 
	jr $+4		;1634	18 02 	. . 
	ld a,004h		;1636	3e 04 	> . 
	out (033h),a		;1638	d3 33 	. 3 
	ret			;163a	c9 	. 
	ld b,0f7h		;163b	06 f7 	. . 
	jr $+24		;163d	18 16 	. . 
	ld b,0feh		;163f	06 fe 	. . 
	jr $+20		;1641	18 12 	. . 
	ld b,0efh		;1643	06 ef 	. . 
	jr $+16		;1645	18 0e 	. . 
	ld b,0fbh		;1647	06 fb 	. . 
	jr $+12		;1649	18 0a 	. . 
	ld b,07fh		;164b	06 7f 	.  
	jr $+8		;164d	18 06 	. . 
	ld b,0fdh		;164f	06 fd 	. . 
	jr $+4		;1651	18 02 	. . 
	ld b,0bfh		;1653	06 bf 	. . 
	ld a,(ATTRIB)		;1655	3a a9 e0 	: . . 
	and b			;1658	a0 	. 
	ld (ATTRIB),a		;1659	32 a9 e0 	2 . . 
	ret			;165c	c9 	. 
	xor a			;165d	af 	. 
	jr $+4		;165e	18 02 	. . 
	ld a,001h		;1660	3e 01 	> . 
	ld (GRACHR),a		;1662	32 c0 e0 	2 . . 
	ret			;1665	c9 	. 
	ld a,(OBYTE2)		;1666	3a 47 e0 	: G . 
	and 008h		;1669	e6 08 	. . 
	ret nz			;166b	c0 	. 
	call 03372h		;166c	cd 72 33 	. r 3 
	ret nz			;166f	c0 	. 
	ld b,002h		;1670	06 02 	. . 
	call 0314ch		;1672	cd 4c 31 	. L 1 
	ld b,006h		;1675	06 06 	. . 
	call 0314ch		;1677	cd 4c 31 	. L 1 
	ld a,(ERRORF)		;167a	3a ff e0 	: . . 
	rra			;167d	1f 	. 
	jp nc,01d6dh		;167e	d2 6d 1d 	. m . 
	ld b,015h		;1681	06 15 	. . 
	jp 01d7eh		;1683	c3 7e 1d 	. ~ . 
	ld de,04000h		;1686	11 00 40 	. . @ 
	ld a,(MDACT)		;1689	3a fe e0 	: . . 
	rrca			;168c	0f 	. 
	rrca			;168d	0f 	. 
	rrca			;168e	0f 	. 
	ld e,a			;168f	5f 	_ 
	ld hl,MBYTE1		;1690	21 40 e0 	! @ . 
	ld bc,00020h		;1693	01 20 00 	.   . 
	ldir		;1696	ed b0 	. . 
	call 0104bh		;1698	cd 4b 10 	. K . 
	ret			;169b	c9 	. 
	ld a,(MBYTE5)		;169c	3a 44 e0 	: D . 
	and 008h		;169f	e6 08 	. . 
	ret z			;16a1	c8 	. 
	ld a,020h		;16a2	3e 20 	>   
	add a,b			;16a4	80 	. 
	ld b,a			;16a5	47 	G 
	ret			;16a6	c9 	. 
	ld a,(MBYTE5)		;16a7	3a 44 e0 	: D . 
	and 008h		;16aa	e6 08 	. . 
	ret z			;16ac	c8 	. 
	ld a,b			;16ad	78 	x 
	sub 020h		;16ae	d6 20 	.   
	ld b,a			;16b0	47 	G 
	ret			;16b1	c9 	. 
	call 01528h		;16b2	cd 28 15 	. ( . 
	ret nz			;16b5	c0 	. 
	ld a,(CHRCNT)		;16b6	3a b1 e0 	: . . 
	ld b,a			;16b9	47 	G 
	ld a,(LNSIZE)		;16ba	3a d4 e0 	: . . 
	ld c,a			;16bd	4f 	O 
	ld de,(CURSOR)		;16be	ed 5b b7 e0 	. [ . . 
	ld hl,(CURSOR)		;16c2	2a b7 e0 	* . . 
	inc hl			;16c5	23 	# 
	inc hl			;16c6	23 	# 
	ld a,c			;16c7	79 	y 
	cp b			;16c8	b8 	. 
	jr z,$+34		;16c9	28 20 	(   
	ld a,(PROTE)		;16cb	3a de e0 	: . . 
	rra			;16ce	1f 	. 
	jr nc,$+9		;16cf	30 07 	0 . 
	inc hl			;16d1	23 	# 
	ld a,(hl)			;16d2	7e 	~ 
	dec hl			;16d3	2b 	+ 
	and 080h		;16d4	e6 80 	. . 
	jr nz,$+21		;16d6	20 13 	  . 
	ld a,(hl)			;16d8	7e 	~ 
	ld (de),a			;16d9	12 	. 
	inc hl			;16da	23 	# 
	inc de			;16db	13 	. 
	ld a,(BLKMD)		;16dc	3a ab e0 	: . . 
	rra			;16df	1f 	. 
	ld a,(hl)			;16e0	7e 	~ 
	jr nc,$+4		;16e1	30 02 	0 . 
	or 020h		;16e3	f6 20 	.   
	ld (de),a			;16e5	12 	. 
	inc hl			;16e6	23 	# 
	inc de			;16e7	13 	. 
	inc b			;16e8	04 	. 
	jr $-34		;16e9	18 dc 	. . 
	ld a,020h		;16eb	3e 20 	>   
	ld (de),a			;16ed	12 	. 
	inc de			;16ee	13 	. 
	ld a,(BLKMD)		;16ef	3a ab e0 	: . . 
	ld a,(BLKMD)		;16f2	3a ab e0 	: . . 
	and a			;16f5	a7 	. 
	jr z,$+4		;16f6	28 02 	( . 
	ld a,020h		;16f8	3e 20 	>   
	ld (de),a			;16fa	12 	. 
	ret			;16fb	c9 	. 
	call 02fe7h		;16fc	cd e7 2f 	. . / 
	call 01d14h		;16ff	cd 14 1d 	. . . 
	ret			;1702	c9 	. 
	xor a			;1703	af 	. 
	jr $+4		;1704	18 02 	. . 
	ld a,001h		;1706	3e 01 	> . 
	ld (DLMENA),a		;1708	32 b9 e0 	2 . . 
	ret			;170b	c9 	. 
	ld a,(TXCNT)		;170c	3a 8e e0 	: . . 
	and a			;170f	a7 	. 
	jr z,$+7		;1710	28 05 	( . 
	call 0302fh		;1712	cd 2f 30 	. / 0 
	jr $-9		;1715	18 f5 	. . 
	ld a,(TBYTE2)		;1717	3a 61 e0 	: a . 
	and 001h		;171a	e6 01 	. . 
	jp z,01750h		;171c	ca 50 17 	. P . 
	ld hl,(DRVADD)		;171f	2a ba e0 	* . . 
	ld a,h			;1722	7c 	| 
	or l			;1723	b5 	. 
	jr z,$+15		;1724	28 0d 	( . 
	ld a,(KBINP)		;1726	3a c9 e0 	: . . 
	rra			;1729	1f 	. 
	jr nc,$+5		;172a	30 03 	0 . 
	inc hl			;172c	23 	# 
	inc hl			;172d	23 	# 
	inc hl			;172e	23 	# 
	call 022f6h		;172f	cd f6 22 	. . " 
	ret			;1732	c9 	. 
	xor a			;1733	af 	. 
	ld (CONT),a		;1734	32 b5 e0 	2 . . 
	ld ix,01742h		;1737	dd 21 42 17 	. ! B . 
	ld iy,01747h		;173b	fd 21 47 17 	. ! G . 
	jp 03d0fh		;173f	c3 0f 3d 	. . = 
	ld (DRVADD),hl		;1742	22 ba e0 	" . . 
	jr $-31		;1745	18 df 	. . 
	xor a			;1747	af 	. 
	out (BANKSELECT),a		;1748	d3 70 	. p 
	ld hl,00000h		;174a	21 00 00 	! . . 
	ld (DRVADD),hl		;174d	22 ba e0 	" . . 
	ld a,(KBINP)		;1750	3a c9 e0 	: . . 
	and a			;1753	a7 	. 
	ret nz			;1754	c0 	. 
	jp 01d71h		;1755	c3 71 1d 	. q . 
	ld a,001h		;1758	3e 01 	> . 
	ld (DSPDIS),a		;175a	32 bc e0 	2 . . 
	ret			;175d	c9 	. 
	ld a,b			;175e	78 	x 
	cp 012h		;175f	fe 12 	. . 
	jr nz,$+17		;1761	20 0f 	  . 
	ld hl,01769h		;1763	21 69 17 	! i . 
	jp 01a60h		;1766	c3 60 1a 	. ` . 
	ld a,b			;1769	78 	x 
	cp 050h		;176a	fe 50 	. P 
	jr nz,$+6		;176c	20 04 	  . 
	xor a			;176e	af 	. 
	ld (DSPDIS),a		;176f	32 bc e0 	2 . . 
	xor a			;1772	af 	. 
	ld (MLTACT),a		;1773	32 d6 e0 	2 . . 
	ret			;1776	c9 	. 
	ld a,001h		;1777	3e 01 	> . 
	jr $+3		;1779	18 01 	. . 
	xor a			;177b	af 	. 
	ld (BLKMD),a		;177c	32 ab e0 	2 . . 
	call 00422h		;177f	cd 22 04 	. " . 
	ret			;1782	c9 	. 
	ld a,(OBYTE2)		;1783	3a 47 e0 	: G . 
	and 0f7h		;1786	e6 f7 	. . 
	jr $+21		;1788	18 13 	. . 
	ld a,(OBYTE2)		;178a	3a 47 e0 	: G . 
	or 008h		;178d	f6 08 	. . 
	jr $+14		;178f	18 0c 	. . 
	ld a,(OBYTE2)		;1791	3a 47 e0 	: G . 
	or 002h		;1794	f6 02 	. . 
	jr $+7		;1796	18 05 	. . 
	ld a,(OBYTE2)		;1798	3a 47 e0 	: G . 
	and 0fdh		;179b	e6 fd 	. . 
	ld (OBYTE2),a		;179d	32 47 e0 	2 G . 
	ret			;17a0	c9 	. 
	ld a,00dh		;17a1	3e 0d 	> . 
	jr $+4		;17a3	18 02 	. . 
	ld a,00ch		;17a5	3e 0c 	> . 
	out (033h),a		;17a7	d3 33 	. 3 
	ld hl,017afh		;17a9	21 af 17 	! . . 
	jp 01a5bh		;17ac	c3 5b 1a 	. [ . 
	ld a,b			;17af	78 	x 
	cp 040h		;17b0	fe 40 	. @ 
	jr c,$+7		;17b2	38 05 	8 . 
	or 080h		;17b4	f6 80 	. . 
	ld b,a			;17b6	47 	G 
	jr $+4		;17b7	18 02 	. . 
	ld b,07fh		;17b9	06 7f 	.  
	call 0221bh		;17bb	cd 1b 22 	. . " 
	xor a			;17be	af 	. 
	ld (MLTACT),a		;17bf	32 d6 e0 	2 . . 
	ret			;17c2	c9 	. 
	ld a,001h		;17c3	3e 01 	> . 
	ld (HDCSER),a		;17c5	32 c1 e0 	2 . . 
	ld hl,017ceh		;17c8	21 ce 17 	! . . 
	jp 01a5bh		;17cb	c3 5b 1a 	. [ . 
	call 018b3h		;17ce	cd b3 18 	. . . 
	ret z			;17d1	c8 	. 
	ld a,b			;17d2	78 	x 
	cp 030h		;17d3	fe 30 	. 0 
	jr c,$+28		;17d5	38 1a 	8 . 
	call 017e3h		;17d7	cd e3 17 	. . . 
	ld (SAVEHL),hl		;17da	22 e4 e0 	" . . 
	ld hl,017ffh		;17dd	21 ff 17 	! . . 
	jp 01a60h		;17e0	c3 60 1a 	. ` . 
	sub 030h		;17e3	d6 30 	. 0 
	ld b,a			;17e5	47 	G 
	add a,b			;17e6	80 	. 
	add a,b			;17e7	80 	. 
	ld b,a			;17e8	47 	G 
	ld e,a			;17e9	5f 	_ 
	ld d,000h		;17ea	16 00 	. . 
	ld hl,0d810h		;17ec	21 10 d8 	! . . 
	add hl,de			;17ef	19 	. 
	ret			;17f0	c9 	. 
	ld a,001h		;17f1	3e 01 	> . 
	jr $+3		;17f3	18 01 	. . 
	xor a			;17f5	af 	. 
	ld (HDCSER),a		;17f6	32 c1 e0 	2 . . 
	ld hl,018b3h		;17f9	21 b3 18 	! . . 
	jp 01a60h		;17fc	c3 60 1a 	. ` . 
	call 018b3h		;17ff	cd b3 18 	. . . 
	ret z			;1802	c8 	. 
	cp 030h		;1803	fe 30 	. 0 
	jr c,$-20		;1805	38 ea 	8 . 
	jr nz,$+8		;1807	20 06 	  . 
	ld hl,(SAVEHL)		;1809	2a e4 e0 	* . . 
	ld (hl),b			;180c	70 	p 
	jr $-24		;180d	18 e6 	. . 
	cp 034h		;180f	fe 34 	. 4 
	jr nc,$-32		;1811	30 de 	0 . 
	ld hl,(SAVEHL)		;1813	2a e4 e0 	* . . 
	ld (hl),b			;1816	70 	p 
	inc hl			;1817	23 	# 
	ld (SAVEHL),hl		;1818	22 e4 e0 	" . . 
	ld hl,01821h		;181b	21 21 18 	! ! . 
	jp 01a57h		;181e	c3 57 1a 	. W . 
	call 018b3h		;1821	cd b3 18 	. . . 
	ret z			;1824	c8 	. 
	call 0188dh		;1825	cd 8d 18 	. . . 
	ld a,(MLTCNT)		;1828	3a d5 e0 	: . . 
	rra			;182b	1f 	. 
	jr nc,$+7		;182c	30 05 	0 . 
	rra			;182e	1f 	. 
	jr c,$+27		;182f	38 19 	8 . 
	jr $+8		;1831	18 06 	. . 
	ld a,b			;1833	78 	x 
	ld (SAVEA),a		;1834	32 e2 e0 	2 . . 
	jr $+14		;1837	18 0c 	. . 
	ld a,(SAVEA)		;1839	3a e2 e0 	: . . 
	or c			;183c	b1 	. 
	ld hl,(SAVEHL)		;183d	2a e4 e0 	* . . 
	ld (hl),a			;1840	77 	w 
	inc hl			;1841	23 	# 
	ld (SAVEHL),hl		;1842	22 e4 e0 	" . . 
	ld hl,MLTCNT		;1845	21 d5 e0 	! . . 
	inc (hl)			;1848	34 	4 
	ret			;1849	c9 	. 
	ld a,(SAVEA)		;184a	3a e2 e0 	: . . 
	or c			;184d	b1 	. 
	ld hl,(SAVEHL)		;184e	2a e4 e0 	* . . 
	ld (hl),a			;1851	77 	w 
	ld e,a			;1852	5f 	_ 
	dec hl			;1853	2b 	+ 
	ld d,(hl)			;1854	56 	V 
	ld (SAVEHL),de		;1855	ed 53 e4 e0 	. S . . 
	ld hl,0185fh		;1859	21 5f 18 	! _ . 
	jp 01a57h		;185c	c3 57 1a 	. W . 
	call 018b3h		;185f	cd b3 18 	. . . 
	ret z			;1862	c8 	. 
	call 0188dh		;1863	cd 8d 18 	. . . 
	ld a,(MLTCNT)		;1866	3a d5 e0 	: . . 
	rra			;1869	1f 	. 
	jr c,$+15		;186a	38 0d 	8 . 
	ld a,b			;186c	78 	x 
	ld (SAVEA),a		;186d	32 e2 e0 	2 . . 
	ld a,001h		;1870	3e 01 	> . 
	ld (HDCSER),a		;1872	32 c1 e0 	2 . . 
	ld (MLTCNT),a		;1875	32 d5 e0 	2 . . 
	ret			;1878	c9 	. 
	ld a,(SAVEA)		;1879	3a e2 e0 	: . . 
	or c			;187c	b1 	. 
	ld hl,(SAVEHL)		;187d	2a e4 e0 	* . . 
	ld (hl),a			;1880	77 	w 
	inc hl			;1881	23 	# 
	ld (SAVEHL),hl		;1882	22 e4 e0 	" . . 
	xor a			;1885	af 	. 
	ld (HDCSER),a		;1886	32 c1 e0 	2 . . 
	ld (MLTCNT),a		;1889	32 d5 e0 	2 . . 
	ret			;188c	c9 	. 
	bit 4,b		;188d	cb 60 	. ` 
	jr nz,$+32		;188f	20 1e 	  . 
	bit 5,b		;1891	cb 68 	. h 
	jr z,$+28		;1893	28 1a 	( . 
	ld a,(MLTCNT)		;1895	3a d5 e0 	: . . 
	rra			;1898	1f 	. 
	jr c,$+8		;1899	38 06 	8 . 
	bit 6,b		;189b	cb 70 	. p 
	jr nz,$+18		;189d	20 10 	  . 
	jr $+6		;189f	18 04 	. . 
	bit 6,b		;18a1	cb 70 	. p 
	jr z,$+12		;18a3	28 0a 	( . 
	ld a,b			;18a5	78 	x 
	and 00fh		;18a6	e6 0f 	. . 
	ld c,a			;18a8	4f 	O 
	rlca			;18a9	07 	. 
	rlca			;18aa	07 	. 
	rlca			;18ab	07 	. 
	rlca			;18ac	07 	. 
	ld b,a			;18ad	47 	G 
	ret			;18ae	c9 	. 
	pop hl			;18af	e1 	. 
	jp 017f1h		;18b0	c3 f1 17 	. . . 
	res 7,b		;18b3	cb b8 	. . 
	ld a,b			;18b5	78 	x 
	cp 00dh		;18b6	fe 0d 	. . 
	ret nz			;18b8	c0 	. 
	ld a,(HDCSER)		;18b9	3a c1 e0 	: . . 
	rra			;18bc	1f 	. 
	jr nc,$+7		;18bd	30 05 	0 . 
	call 01d71h		;18bf	cd 71 1d 	. q . 
	jr $+5		;18c2	18 03 	. . 
	call 01d67h		;18c4	cd 67 1d 	. g . 
	xor a			;18c7	af 	. 
	ld (MLTACT),a		;18c8	32 d6 e0 	2 . . 
	ret z			;18cb	c8 	. 
	ld a,001h		;18cc	3e 01 	> . 
	ld (HDCSER),a		;18ce	32 c1 e0 	2 . . 
	ld hl,018d7h		;18d1	21 d7 18 	! . . 
	jp 01a57h		;18d4	c3 57 1a 	. W . 
	call 018b3h		;18d7	cd b3 18 	. . . 
	ret z			;18da	c8 	. 
	ld a,b			;18db	78 	x 
	cp 040h		;18dc	fe 40 	. @ 
	jp c,017f1h		;18de	da f1 17 	. . . 
	cp 080h		;18e1	fe 80 	. . 
	jp nc,017f1h		;18e3	d2 f1 17 	. . . 
	and 03fh		;18e6	e6 3f 	. ? 
	ld l,a			;18e8	6f 	o 
	ld (SAVEHL),hl		;18e9	22 e4 e0 	" . . 
	ld hl,018f2h		;18ec	21 f2 18 	! . . 
	jp 01a60h		;18ef	c3 60 1a 	. ` . 
	call 018b3h		;18f2	cd b3 18 	. . . 
	ret z			;18f5	c8 	. 
	call 0188dh		;18f6	cd 8d 18 	. . . 
	ld hl,(SAVEHL)		;18f9	2a e4 e0 	* . . 
	ld a,c			;18fc	79 	y 
	ld (SAVEB),a		;18fd	32 e3 e0 	2 . . 
	rrca			;1900	0f 	. 
	rrca			;1901	0f 	. 
	ld h,a			;1902	67 	g 
	and 0c0h		;1903	e6 c0 	. . 
	or l			;1905	b5 	. 
	ld l,a			;1906	6f 	o 
	ld a,h			;1907	7c 	| 
	and 003h		;1908	e6 03 	. . 
	or 048h		;190a	f6 48 	. H 
	ld h,a			;190c	67 	g 
	ld (SAVEHL),hl		;190d	22 e4 e0 	" . . 
	ld hl,01916h		;1910	21 16 19 	! . . 
	jp 01a60h		;1913	c3 60 1a 	. ` . 
	call 018b3h		;1916	cd b3 18 	. . . 
	ret z			;1919	c8 	. 
	call 0188dh		;191a	cd 8d 18 	. . . 
	ld a,(MLTCNT)		;191d	3a d5 e0 	: . . 
	rra			;1920	1f 	. 
	jr c,$+15		;1921	38 0d 	8 . 
	ld a,b			;1923	78 	x 
	ld (SAVEA),a		;1924	32 e2 e0 	2 . . 
	ld a,001h		;1927	3e 01 	> . 
	ld (HDCSER),a		;1929	32 c1 e0 	2 . . 
	ld (MLTCNT),a		;192c	32 d5 e0 	2 . . 
	ret			;192f	c9 	. 
	ld a,(SAVEA)		;1930	3a e2 e0 	: . . 
	or c			;1933	b1 	. 
	ld hl,(SAVEHL)		;1934	2a e4 e0 	* . . 
	ld (hl),a			;1937	77 	w 
	ld de,00040h		;1938	11 40 00 	. @ . 
	add hl,de			;193b	19 	. 
	ld (SAVEHL),hl		;193c	22 e4 e0 	" . . 
	xor a			;193f	af 	. 
	ld (HDCSER),a		;1940	32 c1 e0 	2 . . 
	ld (MLTCNT),a		;1943	32 d5 e0 	2 . . 
	ld a,(SAVEB)		;1946	3a e3 e0 	: . . 
	inc a			;1949	3c 	< 
	ld (SAVEB),a		;194a	32 e3 e0 	2 . . 
	cp 010h		;194d	fe 10 	. . 
	ret nz			;194f	c0 	. 
	ld hl,018b3h		;1950	21 b3 18 	! . . 
	jp 01a60h		;1953	c3 60 1a 	. ` . 
	xor a			;1956	af 	. 
	ld (HDCSER),a		;1957	32 c1 e0 	2 . . 
	ld hl,MBYTE1		;195a	21 40 e0 	! @ . 
	ld (SAVEHL),hl		;195d	22 e4 e0 	" . . 
	ld a,020h		;1960	3e 20 	>   
	ld (SAVEA),a		;1962	32 e2 e0 	2 . . 
	ld hl,0196bh		;1965	21 6b 19 	! k . 
	jp 01a57h		;1968	c3 57 1a 	. W . 
	call 018b3h		;196b	cd b3 18 	. . . 
	jp z,0152fh		;196e	ca 2f 15 	. / . 
	call 0188dh		;1971	cd 8d 18 	. . . 
	ld hl,(SAVEHL)		;1974	2a e4 e0 	* . . 
	ld (hl),c			;1977	71 	q 
	inc hl			;1978	23 	# 
	ld (SAVEHL),hl		;1979	22 e4 e0 	" . . 
	ld hl,MLTCNT		;197c	21 d5 e0 	! . . 
	inc (hl)			;197f	34 	4 
	ld a,(SAVEA)		;1980	3a e2 e0 	: . . 
	dec a			;1983	3d 	= 
	ld (SAVEA),a		;1984	32 e2 e0 	2 . . 
	ret nz			;1987	c0 	. 
	ld hl,0198eh		;1988	21 8e 19 	! . . 
	jp 01a60h		;198b	c3 60 1a 	. ` . 
	call 018b3h		;198e	cd b3 18 	. . . 
	ret nz			;1991	c0 	. 
	ld a,(HDCSER)		;1992	3a c1 e0 	: . . 
	and a			;1995	a7 	. 
	ret nz			;1996	c0 	. 
	jp 0152fh		;1997	c3 2f 15 	. / . 
	ld a,(KBINP)		;199a	3a c9 e0 	: . . 
	and a			;199d	a7 	. 
	ret nz			;199e	c0 	. 
	ld ix,019aah		;199f	dd 21 aa 19 	. ! . . 
	ld iy,019aeh		;19a3	fd 21 ae 19 	. ! . . 
	jp 03d0ch		;19a7	c3 0c 3d 	. . = 
	call 022f6h		;19aa	cd f6 22 	. . " 
	ret			;19ad	c9 	. 
	jp 01d77h		;19ae	c3 77 1d 	. w . 
	xor a			;19b1	af 	. 
	ld (MLTACT),a		;19b2	32 d6 e0 	2 . . 
	ld a,(LIGHTS)		;19b5	3a ce e0 	: . . 
	ld c,a			;19b8	4f 	O 
	ld a,b			;19b9	78 	x 
	and 007h		;19ba	e6 07 	. . 
	jr nz,$+6		;19bc	20 04 	  . 
	ld b,002h		;19be	06 02 	. . 
	jr $+31		;19c0	18 1d 	. . 
	cp 001h		;19c2	fe 01 	. . 
	jr nz,$+6		;19c4	20 04 	  . 
	ld b,010h		;19c6	06 10 	. . 
	jr $+23		;19c8	18 15 	. . 
	cp 002h		;19ca	fe 02 	. . 
	jr nz,$+6		;19cc	20 04 	  . 
	ld b,020h		;19ce	06 20 	.   
	jr $+15		;19d0	18 0d 	. . 
	cp 003h		;19d2	fe 03 	. . 
	jr nz,$+6		;19d4	20 04 	  . 
	ld b,040h		;19d6	06 40 	. @ 
	jr $+7		;19d8	18 05 	. . 
	cp 004h		;19da	fe 04 	. . 
	ret nz			;19dc	c0 	. 
	ld b,008h		;19dd	06 08 	. . 
	ld a,(INDON)		;19df	3a c7 e0 	: . . 
	rra			;19e2	1f 	. 
	jr nc,$+6		;19e3	30 04 	0 . 
	ld a,b			;19e5	78 	x 
	or c			;19e6	b1 	. 
	jr $+5		;19e7	18 03 	. . 
	ld a,b			;19e9	78 	x 
	cpl			;19ea	2f 	/ 
	and c			;19eb	a1 	. 
	ld (LIGHTS),a		;19ec	32 ce e0 	2 . . 
	cpl			;19ef	2f 	/ 
	out (050h),a		;19f0	d3 50 	. P 
	ret			;19f2	c9 	. 
	xor a			;19f3	af 	. 
	jr $+4		;19f4	18 02 	. . 
	ld a,001h		;19f6	3e 01 	> . 
	ld (INDON),a		;19f8	32 c7 e0 	2 . . 
	ld hl,019b1h		;19fb	21 b1 19 	! . . 
	jp 01a5bh		;19fe	c3 5b 1a 	. [ . 
	call 01528h		;1a01	cd 28 15 	. ( . 
	ret nz			;1a04	c0 	. 
	ld a,(CHRCNT)		;1a05	3a b1 e0 	: . . 
	ld b,a			;1a08	47 	G 
	ld a,(LNSIZE)		;1a09	3a d4 e0 	: . . 
	inc a			;1a0c	3c 	< 
	ld c,a			;1a0d	4f 	O 
	ld hl,(CURSOR)		;1a0e	2a b7 e0 	* . . 
	ld d,020h		;1a11	16 20 	.   
	ld e,000h		;1a13	1e 00 	. . 
	ld a,(hl)			;1a15	7e 	~ 
	ld (hl),d			;1a16	72 	r 
	ld d,a			;1a17	57 	W 
	inc hl			;1a18	23 	# 
	ld a,(BLKMD)		;1a19	3a ab e0 	: . . 
	rra			;1a1c	1f 	. 
	jr nc,$+6		;1a1d	30 04 	0 . 
	ld a,e			;1a1f	7b 	{ 
	or 020h		;1a20	f6 20 	.   
	ld e,a			;1a22	5f 	_ 
	ld a,(hl)			;1a23	7e 	~ 
	ld (hl),e			;1a24	73 	s 
	ld e,a			;1a25	5f 	_ 
	inc hl			;1a26	23 	# 
	inc b			;1a27	04 	. 
	ld a,c			;1a28	79 	y 
	cp b			;1a29	b8 	. 
	ret z			;1a2a	c8 	. 
	ld a,(PROTE)		;1a2b	3a de e0 	: . . 
	rra			;1a2e	1f 	. 
	jr nc,$-26		;1a2f	30 e4 	0 . 
	inc hl			;1a31	23 	# 
	ld a,(hl)			;1a32	7e 	~ 
	dec hl			;1a33	2b 	+ 
	and 080h		;1a34	e6 80 	. . 
	jr z,$-33		;1a36	28 dd 	( . 
	ret			;1a38	c9 	. 
	call 02fe7h		;1a39	cd e7 2f 	. . / 
	call 01d10h		;1a3c	cd 10 1d 	. . . 
	ret			;1a3f	c9 	. 
	ld hl,01a45h		;1a40	21 45 1a 	! E . 
	jr $+20		;1a43	18 12 	. . 
	xor a			;1a45	af 	. 
	ld (MLTACT),a		;1a46	32 d6 e0 	2 . . 
	ld a,b			;1a49	78 	x 
	cp 030h		;1a4a	fe 30 	. 0 
	jp c,01d77h		;1a4c	da 77 1d 	. w . 
	cp 038h		;1a4f	fe 38 	. 8 
	jp nc,01d77h		;1a51	d2 77 1d 	. w . 
	jp 00d68h		;1a54	c3 68 0d 	. h . 
	xor a			;1a57	af 	. 
	ld (MLTCNT),a		;1a58	32 d5 e0 	2 . . 
	ld a,001h		;1a5b	3e 01 	> . 
	ld (MLTACT),a		;1a5d	32 d6 e0 	2 . . 
	ld (MLTADD),hl		;1a60	22 d7 e0 	" . . 
	ret			;1a63	c9 	. 
	call 03372h		;1a64	cd 72 33 	. r 3 
	ret nz			;1a67	c0 	. 
	ld hl,01a6dh		;1a68	21 6d 1a 	! m . 
	jr $-16		;1a6b	18 ee 	. . 
	xor a			;1a6d	af 	. 
	ld (MLTACT),a		;1a6e	32 d6 e0 	2 . . 
	ld a,b			;1a71	78 	x 
	cp 030h		;1a72	fe 30 	. 0 
	jp c,01d77h		;1a74	da 77 1d 	. w . 
	cp 038h		;1a77	fe 38 	. 8 
	jp nc,01d77h		;1a79	d2 77 1d 	. w . 
	and 007h		;1a7c	e6 07 	. . 
	ld (SAVEA),a		;1a7e	32 e2 e0 	2 . . 
	ld a,060h		;1a81	3e 60 	> ` 
	ld (TOGAL),a		;1a83	32 ef e0 	2 . . 
	ld b,01eh		;1a86	06 1e 	. . 
	call 0314ch		;1a88	cd 4c 31 	. L 1 
	ld b,06fh		;1a8b	06 6f 	. o 
	call 0314ch		;1a8d	cd 4c 31 	. L 1 
	ld b,023h		;1a90	06 23 	. # 
	call 0314ch		;1a92	cd 4c 31 	. L 1 
	ld b,021h		;1a95	06 21 	. ! 
	call 0314ch		;1a97	cd 4c 31 	. L 1 
	ld a,(MDACT)		;1a9a	3a fe e0 	: . . 
	and 007h		;1a9d	e6 07 	. . 
	call 031e8h		;1a9f	cd e8 31 	. . 1 
	ld b,000h		;1aa2	06 00 	. . 
	in a,(026h)		;1aa4	db 26 	. & 
	bit 7,a		;1aa6	cb 7f 	.  
	jr z,$+4		;1aa8	28 02 	( . 
	set 2,b		;1aaa	cb d0 	. . 
	bit 6,a		;1aac	cb 77 	. w 
	jr nz,$+4		;1aae	20 02 	  . 
	set 3,b		;1ab0	cb d8 	. . 
	ld a,b			;1ab2	78 	x 
	call 031e8h		;1ab3	cd e8 31 	. . 1 
	ld b,000h		;1ab6	06 00 	. . 
	ld a,(TBYTE1)		;1ab8	3a 60 e0 	: ` . 
	and 004h		;1abb	e6 04 	. . 
	jr z,$+36		;1abd	28 22 	( " 
	in a,(086h)		;1abf	db 86 	. . 
	bit 5,a		;1ac1	cb 6f 	. o 
	jr z,$+4		;1ac3	28 02 	( . 
	set 0,b		;1ac5	cb c0 	. . 
	bit 4,a		;1ac7	cb 67 	. g 
	jr z,$+4		;1ac9	28 02 	( . 
	set 1,b		;1acb	cb c8 	. . 
	in a,(096h)		;1acd	db 96 	. . 
	bit 5,a		;1acf	cb 6f 	. o 
	jr z,$+4		;1ad1	28 02 	( . 
	set 2,b		;1ad3	cb d0 	. . 
	bit 4,a		;1ad5	cb 67 	. g 
	jr z,$+4		;1ad7	28 02 	( . 
	set 3,b		;1ad9	cb d8 	. . 
	ld a,b			;1adb	78 	x 
	call 031e8h		;1adc	cd e8 31 	. . 1 
	jr $+6		;1adf	18 04 	. . 
	xor a			;1ae1	af 	. 
	call 031e8h		;1ae2	cd e8 31 	. . 1 
	xor a			;1ae5	af 	. 
	call 031e8h		;1ae6	cd e8 31 	. . 1 
	ld b,020h		;1ae9	06 20 	.   
	ld hl,MBYTE1		;1aeb	21 40 e0 	! @ . 
	ld a,(SAVEA)		;1aee	3a e2 e0 	: . . 
	cp 007h		;1af1	fe 07 	. . 
	jp z,01afch		;1af3	ca fc 1a 	. . . 
	rrca			;1af6	0f 	. 
	rrca			;1af7	0f 	. 
	rrca			;1af8	0f 	. 
	ld l,a			;1af9	6f 	o 
	ld h,040h		;1afa	26 40 	& @ 
	ld a,(hl)			;1afc	7e 	~ 
	call 031e8h		;1afd	cd e8 31 	. . 1 
	inc hl			;1b00	23 	# 
	djnz $-5		;1b01	10 f9 	. . 
	ld b,033h		;1b03	06 33 	. 3 
	call 0314ch		;1b05	cd 4c 31 	. L 1 
	ld b,030h		;1b08	06 30 	. 0 
	call 0314ch		;1b0a	cd 4c 31 	. L 1 
	call 031e2h		;1b0d	cd e2 31 	. . 1 
	ret			;1b10	c9 	. 
	ld a,(OBYTE2)		;1b11	3a 47 e0 	: G . 
	and 00bh		;1b14	e6 0b 	. . 
	ld (OBYTE2),a		;1b16	32 47 e0 	2 G . 
	ret			;1b19	c9 	. 
	xor a			;1b1a	af 	. 
	jr $+4		;1b1b	18 02 	. . 
	ld a,001h		;1b1d	3e 01 	> . 
	ld (PROTE),a		;1b1f	32 de e0 	2 . . 
	ret			;1b22	c9 	. 
	ld a,(OBYTE1)		;1b23	3a 46 e0 	: F . 
	and 0fdh		;1b26	e6 fd 	. . 
	jr $+13		;1b28	18 0b 	. . 
	ld a,(NOPTR)		;1b2a	3a f8 e0 	: . . 
	and a			;1b2d	a7 	. 
	jr nz,$-11		;1b2e	20 f3 	  . 
	ld a,(OBYTE1)		;1b30	3a 46 e0 	: F . 
	or 002h		;1b33	f6 02 	. . 
	ld (OBYTE1),a		;1b35	32 46 e0 	2 F . 
	jp 01666h		;1b38	c3 66 16 	. f . 
	ld hl,01b41h		;1b3b	21 41 1b 	! A . 
	jp 01a5bh		;1b3e	c3 5b 1a 	. [ . 
	ld a,b			;1b41	78 	x 
	cp 07eh		;1b42	fe 7e 	. ~ 
	jr nz,$+22		;1b44	20 14 	  . 
	ld hl,01b4ch		;1b46	21 4c 1b 	! L . 
	jp 01a60h		;1b49	c3 60 1a 	. ` . 
	ld hl,01b5ah		;1b4c	21 5a 1b 	! Z . 
	ld a,b			;1b4f	78 	x 
	rra			;1b50	1f 	. 
	jp nc,01a60h		;1b51	d2 60 1a 	. ` . 
	ld hl,01b72h		;1b54	21 72 1b 	! r . 
	jp 01a60h		;1b57	c3 60 1a 	. ` . 
	call 016a7h		;1b5a	cd a7 16 	. . . 
	ld a,(LNSIZE)		;1b5d	3a d4 e0 	: . . 
	inc a			;1b60	3c 	< 
	ld c,a			;1b61	4f 	O 
	ld a,b			;1b62	78 	x 
	cp c			;1b63	b9 	. 
	jr c,$+5		;1b64	38 03 	8 . 
	sub c			;1b66	91 	. 
	jr $-4		;1b67	18 fa 	. . 
	ld (XPOS),a		;1b69	32 f1 e0 	2 . . 
	ld hl,01b7bh		;1b6c	21 7b 1b 	! { . 
	jp 01a60h		;1b6f	c3 60 1a 	. ` . 
	call 016a7h		;1b72	cd a7 16 	. . . 
	ld a,b			;1b75	78 	x 
	add a,050h		;1b76	c6 50 	. P 
	ld b,a			;1b78	47 	G 
	jr $-28		;1b79	18 e2 	. . 
	xor a			;1b7b	af 	. 
	ld (MLTACT),a		;1b7c	32 d6 e0 	2 . . 
	call 016a7h		;1b7f	cd a7 16 	. . . 
	ld a,(LASTLN)		;1b82	3a cd e0 	: . . 
	inc a			;1b85	3c 	< 
	ld c,a			;1b86	4f 	O 
	ld a,b			;1b87	78 	x 
	cp c			;1b88	b9 	. 
	jr c,$+5		;1b89	38 03 	8 . 
	sub c			;1b8b	91 	. 
	jr $-4		;1b8c	18 fa 	. . 
	ld e,a			;1b8e	5f 	_ 
	ld a,(XPOS)		;1b8f	3a f1 e0 	: . . 
	ld d,a			;1b92	57 	W 
	call 031fbh		;1b93	cd fb 31 	. . 1 
	xor a			;1b96	af 	. 
	ret			;1b97	c9 	. 
	call 03372h		;1b98	cd 72 33 	. r 3 
	ret nz			;1b9b	c0 	. 
	ld b,07eh		;1b9c	06 7e 	. ~ 
	ld hl,(CURSOR)		;1b9e	2a b7 e0 	* . . 
	ld a,(hl)			;1ba1	7e 	~ 
	bit 7,a		;1ba2	cb 7f 	.  
	jr nz,$+4		;1ba4	20 02 	  . 
	res 6,b		;1ba6	cb b0 	. . 
	inc hl			;1ba8	23 	# 
	ld a,(hl)			;1ba9	7e 	~ 
	bit 1,a		;1baa	cb 4f 	. O 
	jr nz,$+4		;1bac	20 02 	  . 
	res 1,b		;1bae	cb 88 	. . 
	bit 3,a		;1bb0	cb 5f 	. _ 
	jr nz,$+4		;1bb2	20 02 	  . 
	res 2,b		;1bb4	cb 90 	. . 
	bit 4,a		;1bb6	cb 67 	. g 
	jr nz,$+4		;1bb8	20 02 	  . 
	res 3,b		;1bba	cb 98 	. . 
	push af			;1bbc	f5 	. 
	call 0314ch		;1bbd	cd 4c 31 	. L 1 
	pop af			;1bc0	f1 	. 
	ld b,03fh		;1bc1	06 3f 	. ? 
	bit 5,a		;1bc3	cb 6f 	. o 
	jr nz,$+4		;1bc5	20 02 	  . 
	res 0,b		;1bc7	cb 80 	. . 
	bit 7,a		;1bc9	cb 7f 	.  
	jr nz,$+4		;1bcb	20 02 	  . 
	res 1,b		;1bcd	cb 88 	. . 
	bit 0,a		;1bcf	cb 47 	. G 
	jr nz,$+4		;1bd1	20 02 	  . 
	res 2,b		;1bd3	cb 90 	. . 
	bit 2,a		;1bd5	cb 57 	. W 
	jr nz,$+4		;1bd7	20 02 	  . 
	res 3,b		;1bd9	cb 98 	. . 
	jp 03185h		;1bdb	c3 85 31 	. . 1 
	call 03372h		;1bde	cd 72 33 	. r 3 
	ret nz			;1be1	c0 	. 
	ld hl,(CURSOR)		;1be2	2a b7 e0 	* . . 
	ld b,(hl)			;1be5	46 	F 
	jp 03185h		;1be6	c3 85 31 	. . 1 
	call 03372h		;1be9	cd 72 33 	. r 3 
	ret nz			;1bec	c0 	. 
	ld b,002h		;1bed	06 02 	. . 
	call 0314ch		;1bef	cd 4c 31 	. L 1 
	ld b,006h		;1bf2	06 06 	. . 
	call 0314ch		;1bf4	cd 4c 31 	. L 1 
	ld b,025h		;1bf7	06 25 	. % 
	call 0314ch		;1bf9	cd 4c 31 	. L 1 
	ld b,07fh		;1bfc	06 7f 	.  
	ld a,(OBYTE2)		;1bfe	3a 47 e0 	: G . 
	and 004h		;1c01	e6 04 	. . 
	jr nz,$+4		;1c03	20 02 	  . 
	res 0,b		;1c05	cb 80 	. . 
	ld a,(OBYTE4)		;1c07	3a 49 e0 	: I . 
	and 001h		;1c0a	e6 01 	. . 
	jr nz,$+4		;1c0c	20 02 	  . 
	res 1,b		;1c0e	cb 88 	. . 
	call 005c8h		;1c10	cd c8 05 	. . . 
	bit 5,a		;1c13	cb 6f 	. o 
	jr nz,$+4		;1c15	20 02 	  . 
	res 2,b		;1c17	cb 90 	. . 
	call 005a9h		;1c19	cd a9 05 	. . . 
	bit 5,a		;1c1c	cb 6f 	. o 
	jr nz,$+4		;1c1e	20 02 	  . 
	res 3,b		;1c20	cb 98 	. . 
	call 0314ch		;1c22	cd 4c 31 	. L 1 
	ld b,07fh		;1c25	06 7f 	.  
	ld a,(OBYTE1)		;1c27	3a 46 e0 	: F . 
	and 004h		;1c2a	e6 04 	. . 
	jr z,$+4		;1c2c	28 02 	( . 
	res 0,b		;1c2e	cb 80 	. . 
	ld a,(MBYTE5)		;1c30	3a 44 e0 	: D . 
	and 002h		;1c33	e6 02 	. . 
	jr z,$+4		;1c35	28 02 	( . 
	res 1,b		;1c37	cb 88 	. . 
	call 0314ch		;1c39	cd 4c 31 	. L 1 
	ld b,07fh		;1c3c	06 7f 	.  
	ld a,(MBYTE3)		;1c3e	3a 42 e0 	: B . 
	bit 2,a		;1c41	cb 57 	. W 
	jr nz,$+4		;1c43	20 02 	  . 
	res 0,b		;1c45	cb 80 	. . 
	bit 3,a		;1c47	cb 5f 	. _ 
	jr z,$+4		;1c49	28 02 	( . 
	res 1,b		;1c4b	cb 88 	. . 
	bit 1,a		;1c4d	cb 4f 	. O 
	jr nz,$+4		;1c4f	20 02 	  . 
	res 2,b		;1c51	cb 90 	. . 
	ld a,(MBYTE4)		;1c53	3a 43 e0 	: C . 
	and 008h		;1c56	e6 08 	. . 
	jr z,$+4		;1c58	28 02 	( . 
	res 3,b		;1c5a	cb 98 	. . 
	call 0314ch		;1c5c	cd 4c 31 	. L 1 
	ld a,(TBAUD)		;1c5f	3a 58 e0 	: X . 
	ld b,07fh		;1c62	06 7f 	.  
	bit 0,a		;1c64	cb 47 	. G 
	jr nz,$+4		;1c66	20 02 	  . 
	res 3,b		;1c68	cb 98 	. . 
	bit 1,a		;1c6a	cb 4f 	. O 
	jr nz,$+4		;1c6c	20 02 	  . 
	res 2,b		;1c6e	cb 90 	. . 
	bit 2,a		;1c70	cb 57 	. W 
	jr nz,$+4		;1c72	20 02 	  . 
	res 1,b		;1c74	cb 88 	. . 
	bit 3,a		;1c76	cb 5f 	. _ 
	jr nz,$+4		;1c78	20 02 	  . 
	res 0,b		;1c7a	cb 80 	. . 
	call 0314ch		;1c7c	cd 4c 31 	. L 1 
	ld b,07fh		;1c7f	06 7f 	.  
	ld a,(MBYTE4)		;1c81	3a 43 e0 	: C . 
	bit 0,a		;1c84	cb 47 	. G 
	jr z,$+4		;1c86	28 02 	( . 
	res 2,b		;1c88	cb 90 	. . 
	bit 1,a		;1c8a	cb 4f 	. O 
	jr z,$+4		;1c8c	28 02 	( . 
	res 3,b		;1c8e	cb 98 	. . 
	call 0314ch		;1c90	cd 4c 31 	. L 1 
	jp 01666h		;1c93	c3 66 16 	. f . 
	ld a,(MBYTE4)		;1c96	3a 43 e0 	: C . 
	or 004h		;1c99	f6 04 	. . 
	jr $+7		;1c9b	18 05 	. . 
	ld a,(MBYTE4)		;1c9d	3a 43 e0 	: C . 
	and 0fbh		;1ca0	e6 fb 	. . 
	ld (MBYTE4),a		;1ca2	32 43 e0 	2 C . 
	ret			;1ca5	c9 	. 
	ld hl,01cach		;1ca6	21 ac 1c 	! . . 
	jp 01a57h		;1ca9	c3 57 1a 	. W . 
	call 016a7h		;1cac	cd a7 16 	. . . 
	ld a,b			;1caf	78 	x 
	ld hl,LASTLN		;1cb0	21 cd e0 	! . . 
	ld c,(hl)			;1cb3	4e 	N 
	inc c			;1cb4	0c 	. 
	cp c			;1cb5	b9 	. 
	jr c,$+5		;1cb6	38 03 	8 . 
	sub (hl)			;1cb8	96 	. 
	jr $-4		;1cb9	18 fa 	. . 
	ld b,a			;1cbb	47 	G 
	ld a,(MLTCNT)		;1cbc	3a d5 e0 	: . . 
	and a			;1cbf	a7 	. 
	jr nz,$+11		;1cc0	20 09 	  . 
	inc a			;1cc2	3c 	< 
	ld (MLTCNT),a		;1cc3	32 d5 e0 	2 . . 
	ld a,b			;1cc6	78 	x 
	ld (SRLFST),a		;1cc7	32 e8 e0 	2 . . 
	ret			;1cca	c9 	. 
	xor a			;1ccb	af 	. 
	ld (MLTACT),a		;1ccc	32 d6 e0 	2 . . 
	ld a,b			;1ccf	78 	x 
	ld (SRLLST),a		;1cd0	32 e9 e0 	2 . . 
	ld a,(SRLFST)		;1cd3	3a e8 e0 	: . . 
	inc b			;1cd6	04 	. 
	cp b			;1cd7	b8 	. 
	ret c			;1cd8	d8 	. 
	ld a,(LASTLN)		;1cd9	3a cd e0 	: . . 
	ld (SRLLST),a		;1cdc	32 e9 e0 	2 . . 
	ret			;1cdf	c9 	. 
	ld a,(KBINP)		;1ce0	3a c9 e0 	: . . 
	rra			;1ce3	1f 	. 
	ret c			;1ce4	d8 	. 
	ld a,001h		;1ce5	3e 01 	> . 
	jr $+3		;1ce7	18 01 	. . 
	xor a			;1ce9	af 	. 
	ld (RXOFF),a		;1cea	32 e1 e0 	2 . . 
	ret			;1ced	c9 	. 
	ld b,008h		;1cee	06 08 	. . 
	jr $+24		;1cf0	18 16 	. . 
	ld b,001h		;1cf2	06 01 	. . 
	jr $+20		;1cf4	18 12 	. . 
	ld b,010h		;1cf6	06 10 	. . 
	jr $+16		;1cf8	18 0e 	. . 
	ld b,004h		;1cfa	06 04 	. . 
	jr $+12		;1cfc	18 0a 	. . 
	ld b,080h		;1cfe	06 80 	. . 
	jr $+8		;1d00	18 06 	. . 
	ld b,002h		;1d02	06 02 	. . 
	jr $+4		;1d04	18 02 	. . 
	ld b,040h		;1d06	06 40 	. @ 
	ld a,(ATTRIB)		;1d08	3a a9 e0 	: . . 
	or b			;1d0b	b0 	. 
	ld (ATTRIB),a		;1d0c	32 a9 e0 	2 . . 
	ret			;1d0f	c9 	. 
	ld a,003h		;1d10	3e 03 	> . 
	jr $+4		;1d12	18 02 	. . 
	ld a,001h		;1d14	3e 01 	> . 
	ld (FLAG2),a		;1d16	32 bf e0 	2 . . 
	call 02f70h		;1d19	cd 70 2f 	. p / 
	xor a			;1d1c	af 	. 
	ld (FLAG2),a		;1d1d	32 bf e0 	2 . . 
	jp 01666h		;1d20	c3 66 16 	. f . 
	ld a,(OBYTE2)		;1d23	3a 47 e0 	: G . 
	or 004h		;1d26	f6 04 	. . 
	ld (OBYTE2),a		;1d28	32 47 e0 	2 G . 
	ret			;1d2b	c9 	. 
	call 03372h		;1d2c	cd 72 33 	. r 3 
	ret nz			;1d2f	c0 	. 
	ld b,01fh		;1d30	06 1f 	. . 
	call 0314ch		;1d32	cd 4c 31 	. L 1 
	ld a,(OBYTE4)		;1d35	3a 49 e0 	: I . 
	and 002h		;1d38	e6 02 	. . 
	jr z,$+21		;1d3a	28 13 	( . 
	ld b,07eh		;1d3c	06 7e 	. ~ 
	call 0314ch		;1d3e	cd 4c 31 	. L 1 
	ld b,000h		;1d41	06 00 	. . 
	ld a,(CHRCNT)		;1d43	3a b1 e0 	: . . 
	cp 050h		;1d46	fe 50 	. P 
	jr c,$+4		;1d48	38 02 	8 . 
	ld b,001h		;1d4a	06 01 	. . 
	call 01d60h		;1d4c	cd 60 1d 	. ` . 
	ld a,(CHRCNT)		;1d4f	3a b1 e0 	: . . 
	cp 050h		;1d52	fe 50 	. P 
	jr c,$+4		;1d54	38 02 	8 . 
	sub 050h		;1d56	d6 50 	. P 
	ld b,a			;1d58	47 	G 
	call 01d60h		;1d59	cd 60 1d 	. ` . 
	ld a,(LNCNT)		;1d5c	3a d1 e0 	: . . 
	ld b,a			;1d5f	47 	G 
	call 0169ch		;1d60	cd 9c 16 	. . . 
	call 0314ch		;1d63	cd 4c 31 	. L 1 
	ret			;1d66	c9 	. 
	ld a,(OBYTE2)		;1d67	3a 47 e0 	: G . 
	and 008h		;1d6a	e6 08 	. . 
	ret nz			;1d6c	c0 	. 
	ld b,006h		;1d6d	06 06 	. . 
	jr $+15		;1d6f	18 0d 	. . 
	ld a,(OBYTE2)		;1d71	3a 47 e0 	: G . 
	and 008h		;1d74	e6 08 	. . 
	ret nz			;1d76	c0 	. 
	ld b,01eh		;1d77	06 1e 	. . 
	call 0314ch		;1d79	cd 4c 31 	. L 1 
	ld b,015h		;1d7c	06 15 	. . 
	call 0314ch		;1d7e	cd 4c 31 	. L 1 
	call 031d8h		;1d81	cd d8 31 	. . 1 
	ret			;1d84	c9 	. 
	push bc			;1d85	c5 	. 
	ld b,01eh		;1d86	06 1e 	. . 
	call 0314ch		;1d88	cd 4c 31 	. L 1 
	jr $+13		;1d8b	18 0b 	. . 
	push bc			;1d8d	c5 	. 
	ld b,01eh		;1d8e	06 1e 	. . 
	call 0314ch		;1d90	cd 4c 31 	. L 1 
	ld b,012h		;1d93	06 12 	. . 
	call 0314ch		;1d95	cd 4c 31 	. L 1 
	pop bc			;1d98	c1 	. 
	ld b,c			;1d99	41 	A 
	call 0314ch		;1d9a	cd 4c 31 	. L 1 
	ret			;1d9d	c9 	. 
	push bc			;1d9e	c5 	. 
	ld b,01eh		;1d9f	06 1e 	. . 
	call 028ddh		;1da1	cd dd 28 	. . ( 
	jr $+13		;1da4	18 0b 	. . 
	push bc			;1da6	c5 	. 
	ld b,01eh		;1da7	06 1e 	. . 
	call 028ddh		;1da9	cd dd 28 	. . ( 
	ld b,012h		;1dac	06 12 	. . 
	call 028ddh		;1dae	cd dd 28 	. . ( 
	pop bc			;1db1	c1 	. 
	ld b,c			;1db2	41 	A 
	call 028ddh		;1db3	cd dd 28 	. . ( 
	ret			;1db6	c9 	. 
	ld b,0fbh		;1db7	06 fb 	. . 
	jr $+4		;1db9	18 02 	. . 
	ld b,0fdh		;1dbb	06 fd 	. . 
	ld a,(OBYTE4)		;1dbd	3a 49 e0 	: I . 
	and b			;1dc0	a0 	. 
	jr $+12		;1dc1	18 0a 	. . 
	ld b,004h		;1dc3	06 04 	. . 
	jr $+4		;1dc5	18 02 	. . 
	ld b,002h		;1dc7	06 02 	. . 
	ld a,(OBYTE4)		;1dc9	3a 49 e0 	: I . 
	or b			;1dcc	b0 	. 
	ld (OBYTE4),a		;1dcd	32 49 e0 	2 I . 
	call 002b5h		;1dd0	cd b5 02 	. . . 
	ret			;1dd3	c9 	. 
	call 01b1ah		;1dd4	cd 1a 1b 	. . . 
	ld hl,0e111h		;1dd7	21 11 e1 	! . . 
	ld c,01fh		;1dda	0e 1f 	. . 
	ld b,084h		;1ddc	06 84 	. . 
	dec c			;1dde	0d 	. 
	ret z			;1ddf	c8 	. 
	ld a,(hl)			;1de0	7e 	~ 
	or 080h		;1de1	f6 80 	. . 
	ld (hl),a			;1de3	77 	w 
	inc hl			;1de4	23 	# 
	inc hl			;1de5	23 	# 
	djnz $-6		;1de6	10 f8 	. . 
	jr $-12		;1de8	18 f2 	. . 
	ld a,(SXOFF)		;1dea	3a eb e0 	: . . 
	and a			;1ded	a7 	. 
	ret nz			;1dee	c0 	. 
	ld a,001h		;1def	3e 01 	> . 
	ld b,013h		;1df1	06 13 	. . 
	jr $+10		;1df3	18 08 	. . 
	ld a,(SXOFF)		;1df5	3a eb e0 	: . . 
	rra			;1df8	1f 	. 
	ret nc			;1df9	d0 	. 
	xor a			;1dfa	af 	. 
	ld b,011h		;1dfb	06 11 	. . 
	ld (SXOFF),a		;1dfd	32 eb e0 	2 . . 
	jp 03185h		;1e00	c3 85 31 	. . 1 
	ld ix,0153ch		;1e03	dd 21 3c 15 	. ! < . 
	call 03d03h		;1e07	cd 03 3d 	. . = 
	ret			;1e0a	c9 	. 
	ld b,010h		;1e0b	06 10 	. . 
	call 005f2h		;1e0d	cd f2 05 	. . . 
	ret			;1e10	c9 	. 
	ld a,(TBYTE1)		;1e11	3a 60 e0 	: ` . 
	and 002h		;1e14	e6 02 	. . 
	ret z			;1e16	c8 	. 
	in a,(0fch)		;1e17	db fc 	. . 
	ld b,010h		;1e19	06 10 	. . 
	ld c,004h		;1e1b	0e 04 	. . 
	ld de,0080ah		;1e1d	11 0a 08 	. . . 
	call 00601h		;1e20	cd 01 06 	. . . 
	ret			;1e23	c9 	. 
	call 01d9eh		;1e24	cd 9e 1d 	. . . 
	ld a,(OBYTE2)		;1e27	3a 47 e0 	: G . 
	and 008h		;1e2a	e6 08 	. . 
	ret nz			;1e2c	c0 	. 
	ld a,(BLKMD)		;1e2d	3a ab e0 	: . . 
	and a			;1e30	a7 	. 
	call z,031d8h		;1e31	cc d8 31 	. . 1 
	ret			;1e34	c9 	. 
	ld a,c			;1e35	79 	y 
	ld (FNCODE),a		;1e36	32 f5 e0 	2 . . 
	call 01d9eh		;1e39	cd 9e 1d 	. . . 
	jp 025a2h		;1e3c	c3 a2 25 	. . % 
	ld c,05fh		;1e3f	0e 5f 	. _ 
	jr $-12		;1e41	18 f2 	. . 
	ld c,05bh		;1e43	0e 5b 	. [ 
	jr $-16		;1e45	18 ee 	. . 
	ld c,04eh		;1e47	0e 4e 	. N 
	jr $-37		;1e49	18 d9 	. . 
	ld c,05eh		;1e4b	0e 5e 	. ^ 
	jr $-24		;1e4d	18 e6 	. . 
	ld c,05ah		;1e4f	0e 5a 	. Z 
	jr $-28		;1e51	18 e2 	. . 
	ld c,05dh		;1e53	0e 5d 	. ] 
	jr $-49		;1e55	18 cd 	. . 
	ld c,059h		;1e57	0e 59 	. Y 
	jr $-53		;1e59	18 c9 	. . 
	ld c,05ch		;1e5b	0e 5c 	. \ 
	jr $-40		;1e5d	18 d6 	. . 
	ld c,058h		;1e5f	0e 58 	. X 
	jr $-44		;1e61	18 d2 	. . 
	ld c,04fh		;1e63	0e 4f 	. O 
	jr $-65		;1e65	18 bd 	. . 
	ld c,04bh		;1e67	0e 4b 	. K 
	jr $-69		;1e69	18 b9 	. . 
	ld c,04dh		;1e6b	0e 4d 	. M 
	jr $-73		;1e6d	18 b5 	. . 
	ld c,011h		;1e6f	0e 11 	. . 
	jr $-77		;1e71	18 b1 	. . 
	ld c,002h		;1e73	0e 02 	. . 
	jr $-81		;1e75	18 ad 	. . 
	ld c,001h		;1e77	0e 01 	. . 
	jr $-85		;1e79	18 a9 	. . 
	ld c,01ah		;1e7b	0e 1a 	. . 
	jr $-89		;1e7d	18 a5 	. . 
	ld c,019h		;1e7f	0e 19 	. . 
	jr $-93		;1e81	18 a1 	. . 
	ld c,008h		;1e83	0e 08 	. . 
	jr $-97		;1e85	18 9d 	. . 
	ld c,018h		;1e87	0e 18 	. . 
	jr $-101		;1e89	18 99 	. . 
	ld c,049h		;1e8b	0e 49 	. I 
	jr $-88		;1e8d	18 a6 	. . 
	ld c,04ah		;1e8f	0e 4a 	. J 
	jr $-92		;1e91	18 a2 	. . 
	ld c,00bh		;1e93	0e 0b 	. . 
	jp 01d9eh		;1e95	c3 9e 1d 	. . . 
	ld c,051h		;1e98	0e 51 	. Q 
	jr $+4		;1e9a	18 02 	. . 
	ld c,052h		;1e9c	0e 52 	. R 
	ld a,(BLKMD)		;1e9e	3a ab e0 	: . . 
	and a			;1ea1	a7 	. 
	jr z,$-126		;1ea2	28 80 	( . 
	ld a,(OBYTE1)		;1ea4	3a 46 e0 	: F . 
	and 001h		;1ea7	e6 01 	. . 
	jp nz,01e24h		;1ea9	c2 24 1e 	. $ . 
	call 01d85h		;1eac	cd 85 1d 	. . . 
	ld a,(OBYTE2)		;1eaf	3a 47 e0 	: G . 
	and 008h		;1eb2	e6 08 	. . 
	call z,031d8h		;1eb4	cc d8 31 	. . 1 
	ret			;1eb7	c9 	. 
	call 01da6h		;1eb8	cd a6 1d 	. . . 
	jp 01e27h		;1ebb	c3 27 1e 	. ' . 
	ld a,c			;1ebe	79 	y 
	set 7,a		;1ebf	cb ff 	. . 
	ld (FNCODE),a		;1ec1	32 f5 e0 	2 . . 
	call 01da6h		;1ec4	cd a6 1d 	. . . 
	jp 025a2h		;1ec7	c3 a2 25 	. . % 
	ld a,b			;1eca	78 	x 
	and 00fh		;1ecb	e6 0f 	. . 
	or 020h		;1ecd	f6 20 	.   
	ld c,a			;1ecf	4f 	O 
	jr $-18		;1ed0	18 ec 	. . 
	ld c,035h		;1ed2	0e 35 	. 5 
	jr $-22		;1ed4	18 e8 	. . 
	call 01deah		;1ed6	cd ea 1d 	. . . 
	call 0170ch		;1ed9	cd 0c 17 	. . . 
	call 01df5h		;1edc	cd f5 1d 	. . . 
	ret			;1edf	c9 	. 
	ld c,036h		;1ee0	0e 36 	. 6 
	jr $-36		;1ee2	18 da 	. . 
	ld c,031h		;1ee4	0e 31 	. 1 
	jr $-40		;1ee6	18 d6 	. . 
	ld c,032h		;1ee8	0e 32 	. 2 
	jr $-44		;1eea	18 d2 	. . 
	ld c,058h		;1eec	0e 58 	. X 
	jr $-54		;1eee	18 c8 	. . 
	ld c,057h		;1ef0	0e 57 	. W 
	jr $-58		;1ef2	18 c4 	. . 
	ld c,033h		;1ef4	0e 33 	. 3 
	jr $-56		;1ef6	18 c6 	. . 
	ld hl,(BDOTAD)		;1ef8	2a 87 e0 	* . . 
	ld b,(hl)			;1efb	46 	F 
	inc hl			;1efc	23 	# 
	ld a,h			;1efd	7c 	| 
	cp 0dfh		;1efe	fe df 	. . 
	jr nz,$+5		;1f00	20 03 	  . 
	ld hl,0db20h		;1f02	21 20 db 	!   . 
	ld (BDOTAD),hl		;1f05	22 87 e0 	" . . 
	di			;1f08	f3 	. 
	ld hl,(BFCNT)		;1f09	2a 83 e0 	* . . 
	dec hl			;1f0c	2b 	+ 
	ld (BFCNT),hl		;1f0d	22 83 e0 	" . . 
	ret			;1f10	c9 	. 
	xor a			;1f11	af 	. 
	ld (HMSGA),a		;1f12	32 c2 e0 	2 . . 
	call 01ef8h		;1f15	cd f8 1e 	. . . 
	ei			;1f18	fb 	. 
	ld a,h			;1f19	7c 	| 
	and a			;1f1a	a7 	. 
	jr nz,$+7		;1f1b	20 05 	  . 
	push bc			;1f1d	c5 	. 
	call 01df5h		;1f1e	cd f5 1d 	. . . 
	pop bc			;1f21	c1 	. 
	ld a,(OBYTE2)		;1f22	3a 47 e0 	: G . 
	and 008h		;1f25	e6 08 	. . 
	jr z,$+13		;1f27	28 0b 	( . 
	ld a,b			;1f29	78 	x 
	cp 011h		;1f2a	fe 11 	. . 
	jp z,01ce9h		;1f2c	ca e9 1c 	. . . 
	cp 013h		;1f2f	fe 13 	. . 
	jp z,01ce0h		;1f31	ca e0 1c 	. . . 
	ld a,(MLTACT)		;1f34	3a d6 e0 	: . . 
	rra			;1f37	1f 	. 
	jr c,$+29		;1f38	38 1b 	8 . 
	push bc			;1f3a	c5 	. 
	call 02e3fh		;1f3b	cd 3f 2e 	. ? . 
	pop bc			;1f3e	c1 	. 
	ld a,(DSPDIS)		;1f3f	3a bc e0 	: . . 
	rra			;1f42	1f 	. 
	jr nc,$+12		;1f43	30 0a 	0 . 
	ld a,b			;1f45	78 	x 
	cp 01eh		;1f46	fe 1e 	. . 
	ret nz			;1f48	c0 	. 
	ld hl,0175eh		;1f49	21 5e 17 	! ^ . 
	jp 01a5bh		;1f4c	c3 5b 1a 	. [ . 
	ld a,(MLTACT)		;1f4f	3a d6 e0 	: . . 
	rra			;1f52	1f 	. 
	jr nc,$+9		;1f53	30 07 	0 . 
	ld hl,(MLTADD)		;1f55	2a d7 e0 	* . . 
	call 022f6h		;1f58	cd f6 22 	. . " 
	ret			;1f5b	c9 	. 
	ld a,b			;1f5c	78 	x 
	cp 0ffh		;1f5d	fe ff 	. . 
	jr nz,$+9		;1f5f	20 07 	  . 
	ld b,07fh		;1f61	06 7f 	.  
	call 02526h		;1f63	cd 26 25 	. & % 
	jr $+92		;1f66	18 5a 	. Z 
	res 7,b		;1f68	cb b8 	. . 
	ld a,(OBYTE4)		;1f6a	3a 49 e0 	: I . 
	and 008h		;1f6d	e6 08 	. . 
	jr nz,$+83		;1f6f	20 51 	  Q 
	ld a,(TABLE)		;1f71	3a ec e0 	: . . 
	cp 002h		;1f74	fe 02 	. . 
	jr z,$+31		;1f76	28 1d 	( . 
	ld a,b			;1f78	78 	x 
	cp 020h		;1f79	fe 20 	.   
	jr c,$+78		;1f7b	38 4c 	8 L 
	ld a,(TABLE)		;1f7d	3a ec e0 	: . . 
	cp 001h		;1f80	fe 01 	. . 
	jr nz,$+57		;1f82	20 37 	  7 
	ld a,b			;1f84	78 	x 
	cp 060h		;1f85	fe 60 	. ` 
	jr c,$+66		;1f87	38 40 	8 @ 
	call 02526h		;1f89	cd 26 25 	. & % 
	ld a,b			;1f8c	78 	x 
	cp 07fh		;1f8d	fe 7f 	.  
	jr nz,$+44		;1f8f	20 2a 	  * 
	call 01b23h		;1f91	cd 23 1b 	. # . 
	ret			;1f94	c9 	. 
	ld a,b			;1f95	78 	x 
	cp 020h		;1f96	fe 20 	.   
	jr c,$+46		;1f98	38 2c 	8 , 
	cp 040h		;1f9a	fe 40 	. @ 
	jr nc,$+5		;1f9c	30 03 	0 . 
	jp 02526h		;1f9e	c3 26 25 	. & % 
	cp 070h		;1fa1	fe 70 	. p 
	jr nc,$+7		;1fa3	30 05 	0 . 
	sub 040h		;1fa5	d6 40 	. @ 
	ld b,a			;1fa7	47 	G 
	jr $+33		;1fa8	18 1f 	. . 
	call 02526h		;1faa	cd 26 25 	. & % 
	ld a,b			;1fad	78 	x 
	call 017e3h		;1fae	cd e3 17 	. . . 
	ld a,(hl)			;1fb1	7e 	~ 
	inc hl			;1fb2	23 	# 
	and 003h		;1fb3	e6 03 	. . 
	cp 002h		;1fb5	fe 02 	. . 
	call z,02696h		;1fb7	cc 96 26 	. . & 
	ret			;1fba	c9 	. 
	call 02526h		;1fbb	cd 26 25 	. & % 
	ld a,b			;1fbe	78 	x 
	cp 07fh		;1fbf	fe 7f 	.  
	ret z			;1fc1	c8 	. 
	call 0221bh		;1fc2	cd 1b 22 	. . " 
	ret			;1fc5	c9 	. 
	call 02526h		;1fc6	cd 26 25 	. & % 
	call 022b3h		;1fc9	cd b3 22 	. . " 
	ret			;1fcc	c9 	. 
	push af			;1fcd	f5 	. 
	push hl			;1fce	e5 	. 
	ld a,l			;1fcf	7d 	} 
	rlca			;1fd0	07 	. 
	ld l,a			;1fd1	6f 	o 
	ld e,(hl)			;1fd2	5e 	^ 
	inc hl			;1fd3	23 	# 
	ld a,(hl)			;1fd4	7e 	~ 
	and 03fh		;1fd5	e6 3f 	. ? 
	or 0c0h		;1fd7	f6 c0 	. . 
	ld d,a			;1fd9	57 	W 
	pop hl			;1fda	e1 	. 
	pop af			;1fdb	f1 	. 
	ret			;1fdc	c9 	. 
	ld a,(OBYTE1)		;1fdd	3a 46 e0 	: F . 
	and 001h		;1fe0	e6 01 	. . 
	ret nz			;1fe2	c0 	. 
	call 02024h		;1fe3	cd 24 20 	. $   
	ld a,01fh		;1fe6	3e 1f 	> . 
	ld (BRKACT),a		;1fe8	32 94 e0 	2 . . 
	call 0070bh		;1feb	cd 0b 07 	. . . 
	call 00495h		;1fee	cd 95 04 	. . . 
	or 040h		;1ff1	f6 40 	. @ 
	ld b,a			;1ff3	47 	G 
	call 004abh		;1ff4	cd ab 04 	. . . 
	call 0049dh		;1ff7	cd 9d 04 	. . . 
	and 0fbh		;1ffa	e6 fb 	. . 
	or 002h		;1ffc	f6 02 	. . 
	ld b,a			;1ffe	47 	G 
	call 004afh		;1fff	cd af 04 	. . . 
	ret			;2002	c9 	. 
	ld a,(0e0f7h)		;2003	3a f7 e0 	: . . 
	and a			;2006	a7 	. 
	call z,02024h		;2007	cc 24 20 	. $   
	xor a			;200a	af 	. 
	ld (HMSGA),a		;200b	32 c2 e0 	2 . . 
	ld (0e0f7h),a		;200e	32 f7 e0 	2 . . 
	call 01dfah		;2011	cd fa 1d 	. . . 
	ld a,(PRINTA)		;2014	3a dd e0 	: . . 
	rra			;2017	1f 	. 
	ret nc			;2018	d0 	. 
	ld a,(COMPNT)		;2019	3a b4 e0 	: . . 
	rra			;201c	1f 	. 
	call c,01d71h		;201d	dc 71 1d 	. q . 
	call 02f0eh		;2020	cd 0e 2f 	. . / 
	ret			;2023	c9 	. 
	xor a			;2024	af 	. 
	ld (FNCODE),a		;2025	32 f5 e0 	2 . . 
	call 0024ch		;2028	cd 4c 02 	. L . 
	call 02963h		;202b	cd 63 29 	. c ) 
	ret			;202e	c9 	. 
	call 01528h		;202f	cd 28 15 	. ( . 
	ret nz			;2032	c0 	. 
	ld b,000h		;2033	06 00 	. . 
	ld a,(PROTE)		;2035	3a de e0 	: . . 
	rra			;2038	1f 	. 
	jr nc,$+24		;2039	30 16 	0 . 
	ld a,(CHRCNT)		;203b	3a b1 e0 	: . . 
	ld b,a			;203e	47 	G 
	ld hl,(CURSOR)		;203f	2a b7 e0 	* . . 
	inc hl			;2042	23 	# 
	ld a,(hl)			;2043	7e 	~ 
	and 080h		;2044	e6 80 	. . 
	jr nz,$+10		;2046	20 08 	  . 
	or b			;2048	b0 	. 
	jr z,$+8		;2049	28 06 	( . 
	dec b			;204b	05 	. 
	dec hl			;204c	2b 	+ 
	dec hl			;204d	2b 	+ 
	jr $-11		;204e	18 f3 	. . 
	inc b			;2050	04 	. 
	ld a,b			;2051	78 	x 
	ld (CHRCNT),a		;2052	32 b1 e0 	2 . . 
	call 03203h		;2055	cd 03 32 	. . 2 
	call 020f0h		;2058	cd f0 20 	. .   
	ret			;205b	c9 	. 
	call 021d1h		;205c	cd d1 21 	. . ! 
	call 0337ch		;205f	cd 7c 33 	. | 3 
	ret nz			;2062	c0 	. 
	ld hl,(CURSOR)		;2063	2a b7 e0 	* . . 
	ld (hl),020h		;2066	36 20 	6   
	ret			;2068	c9 	. 
	ld hl,0e000h		;2069	21 00 e0 	! . . 
	ld de,02110h		;206c	11 10 21 	. . ! 
	ld b,01eh		;206f	06 1e 	. . 
	ld (hl),e			;2071	73 	s 
	inc hl			;2072	23 	# 
	ld (hl),d			;2073	72 	r 
	inc hl			;2074	23 	# 
	inc d			;2075	14 	. 
	ld a,e			;2076	7b 	{ 
	add a,008h		;2077	c6 08 	. . 
	ld e,a			;2079	5f 	_ 
	djnz $-9		;207a	10 f5 	. . 
	ld hl,0e110h		;207c	21 10 e1 	! . . 
	ld bc,00f78h		;207f	01 78 0f 	. x . 
	ld (hl),020h		;2082	36 20 	6   
	inc hl			;2084	23 	# 
	ld (hl),000h		;2085	36 00 	6 . 
	inc hl			;2087	23 	# 
	dec bc			;2088	0b 	. 
	ld a,c			;2089	79 	y 
	or b			;208a	b0 	. 
	jr nz,$-9		;208b	20 f5 	  . 
	call 01636h		;208d	cd 36 16 	. 6 . 
	xor a			;2090	af 	. 
	ld (ATTRIB),a		;2091	32 a9 e0 	2 . . 
	call 02f3ch		;2094	cd 3c 2f 	. < / 
	ret			;2097	c9 	. 
	xor a			;2098	af 	. 
	jr $+18		;2099	18 10 	. . 
	ld a,008h		;209b	3e 08 	> . 
	jr $+14		;209d	18 0c 	. . 
	ld a,010h		;209f	3e 10 	> . 
	jr $+10		;20a1	18 08 	. . 
	ld a,01fh		;20a3	3e 1f 	> . 
	jr $+6		;20a5	18 04 	. . 
	ld a,002h		;20a7	3e 02 	> . 
	jr $+2		;20a9	18 00 	. . 
	ld (CLRTYP),a		;20ab	32 b3 e0 	2 . . 
	call 020bfh		;20ae	cd bf 20 	. .   
	xor a			;20b1	af 	. 
	ld (CLRTYP),a		;20b2	32 b3 e0 	2 . . 
	jp 01666h		;20b5	c3 66 16 	. f . 
	ld hl,(CURSOR)		;20b8	2a b7 e0 	* . . 
	call 0210fh		;20bb	cd 0f 21 	. . ! 
	ret			;20be	c9 	. 
	call 020b8h		;20bf	cd b8 20 	. .   
	call 02f5dh		;20c2	cd 5d 2f 	. ] / 
	xor a			;20c5	af 	. 
	ld (CHRCNT),a		;20c6	32 b1 e0 	2 . . 
	ld a,(LNCNT)		;20c9	3a d1 e0 	: . . 
	ld hl,LASTLN		;20cc	21 cd e0 	! . . 
	cp (hl)			;20cf	be 	. 
	jr z,$+19		;20d0	28 11 	( . 
	inc a			;20d2	3c 	< 
	ld (LNCNT),a		;20d3	32 d1 e0 	2 . . 
	ld l,a			;20d6	6f 	o 
	ld h,0e0h		;20d7	26 e0 	& . 
	call 01fcdh		;20d9	cd cd 1f 	. . . 
	ld h,d			;20dc	62 	b 
	ld l,e			;20dd	6b 	k 
	call 0210fh		;20de	cd 0f 21 	. . ! 
	jr $-24		;20e1	18 e6 	. . 
	call 02f4bh		;20e3	cd 4b 2f 	. K / 
	ret			;20e6	c9 	. 
	call 021fah		;20e7	cd fa 21 	. . ! 
	call 020bfh		;20ea	cd bf 20 	. .   
	jp 0208dh		;20ed	c3 8d 20 	. .   
	call 02169h		;20f0	cd 69 21 	. i ! 
	ld hl,(CURSOR)		;20f3	2a b7 e0 	* . . 
	inc hl			;20f6	23 	# 
	ld a,(PROTE)		;20f7	3a de e0 	: . . 
	rra			;20fa	1f 	. 
	jr nc,$+6		;20fb	30 04 	0 . 
	ld a,(hl)			;20fd	7e 	~ 
	and 080h		;20fe	e6 80 	. . 
	ret nz			;2100	c0 	. 
	ld (hl),d			;2101	72 	r 
	dec hl			;2102	2b 	+ 
	ld (hl),020h		;2103	36 20 	6   
	inc hl			;2105	23 	# 
	ld a,(LNSIZE)		;2106	3a d4 e0 	: . . 
	cp c			;2109	b9 	. 
	ret z			;210a	c8 	. 
	inc c			;210b	0c 	. 
	inc hl			;210c	23 	# 
	jr $-23		;210d	18 e7 	. . 
	push af			;210f	f5 	. 
	push bc			;2110	c5 	. 
	push de			;2111	d5 	. 
	push hl			;2112	e5 	. 
	call 02169h		;2113	cd 69 21 	. i ! 
	ld a,(PROTE)		;2116	3a de e0 	: . . 
	rra			;2119	1f 	. 
	jr nc,$+4		;211a	30 02 	0 . 
	set 7,b		;211c	cb f8 	. . 
	ld a,b			;211e	78 	x 
	and a			;211f	a7 	. 
	jr z,$+20		;2120	28 12 	( . 
	cp 080h		;2122	fe 80 	. . 
	jr z,$+16		;2124	28 0e 	( . 
	cp 01fh		;2126	fe 1f 	. . 
	jr z,$+10		;2128	28 08 	( . 
	cp 09fh		;212a	fe 9f 	. . 
	jr nz,$+28		;212c	20 1a 	  . 
	ld b,090h		;212e	06 90 	. . 
	jr $+4		;2130	18 02 	. . 
	ld b,010h		;2132	06 10 	. . 
	inc hl			;2134	23 	# 
	ld a,(hl)			;2135	7e 	~ 
	and b			;2136	a0 	. 
	jr nz,$+7		;2137	20 05 	  . 
	ld (hl),d			;2139	72 	r 
	dec hl			;213a	2b 	+ 
	ld (hl),020h		;213b	36 20 	6   
	inc hl			;213d	23 	# 
	ld a,(LNSIZE)		;213e	3a d4 e0 	: . . 
	cp c			;2141	b9 	. 
	jr z,$+34		;2142	28 20 	(   
	inc c			;2144	0c 	. 
	inc hl			;2145	23 	# 
	jr $-18		;2146	18 ec 	. . 
	inc hl			;2148	23 	# 
	ld a,(hl)			;2149	7e 	~ 
	bit 7,a		;214a	cb 7f 	.  
	jr z,$+6		;214c	28 04 	( . 
	bit 7,b		;214e	cb 78 	. x 
	jr nz,$+10		;2150	20 08 	  . 
	and b			;2152	a0 	. 
	jr z,$+7		;2153	28 05 	( . 
	ld (hl),d			;2155	72 	r 
	dec hl			;2156	2b 	+ 
	ld (hl),020h		;2157	36 20 	6   
	inc hl			;2159	23 	# 
	ld a,(LNSIZE)		;215a	3a d4 e0 	: . . 
	cp c			;215d	b9 	. 
	jr z,$+6		;215e	28 04 	( . 
	inc c			;2160	0c 	. 
	inc hl			;2161	23 	# 
	jr $-26		;2162	18 e4 	. . 
	pop hl			;2164	e1 	. 
	pop de			;2165	d1 	. 
	pop bc			;2166	c1 	. 
	pop af			;2167	f1 	. 
	ret			;2168	c9 	. 
	ld a,(CHRCNT)		;2169	3a b1 e0 	: . . 
	ld c,a			;216c	4f 	O 
	ld a,(CLRTYP)		;216d	3a b3 e0 	: . . 
	ld b,a			;2170	47 	G 
	ld d,000h		;2171	16 00 	. . 
	ld a,(BLKMD)		;2173	3a ab e0 	: . . 
	rra			;2176	1f 	. 
	ret nc			;2177	d0 	. 
	ld a,(KBINP)		;2178	3a c9 e0 	: . . 
	and a			;217b	a7 	. 
	ret z			;217c	c8 	. 
	ld d,020h		;217d	16 20 	.   
	ret			;217f	c9 	. 
	ld a,(LASTLN)		;2180	3a cd e0 	: . . 
	ld b,a			;2183	47 	G 
	ld a,(LNCNT)		;2184	3a d1 e0 	: . . 
	cp b			;2187	b8 	. 
	jr nz,$+5		;2188	20 03 	  . 
	xor a			;218a	af 	. 
	jr $+32		;218b	18 1e 	. . 
	ld a,(LASTLN)		;218d	3a cd e0 	: . . 
	dec a			;2190	3d 	= 
	ld b,a			;2191	47 	G 
	ld a,(LNCNT)		;2192	3a d1 e0 	: . . 
	cp b			;2195	b8 	. 
	call z,01509h		;2196	cc 09 15 	. . . 
	inc b			;2199	04 	. 
	cp b			;219a	b8 	. 
	jr z,$+9		;219b	28 07 	( . 
	inc a			;219d	3c 	< 
	ld (LNCNT),a		;219e	32 d1 e0 	2 . . 
	jp 03203h		;21a1	c3 03 32 	. . 2 
	ld a,(OBYTE2)		;21a4	3a 47 e0 	: G . 
	and 004h		;21a7	e6 04 	. . 
	jr nz,$+8		;21a9	20 06 	  . 
	ld (LNCNT),a		;21ab	32 d1 e0 	2 . . 
	jp 03203h		;21ae	c3 03 32 	. . 2 
	xor a			;21b1	af 	. 
	ld (SRLFST),a		;21b2	32 e8 e0 	2 . . 
	ld a,(LASTLN)		;21b5	3a cd e0 	: . . 
	ld (SRLLST),a		;21b8	32 e9 e0 	2 . . 
	call 02f70h		;21bb	cd 70 2f 	. p / 
	ret			;21be	c9 	. 
	ld a,(MBYTE5)		;21bf	3a 44 e0 	: D . 
	and 002h		;21c2	e6 02 	. . 
	jr z,$+6		;21c4	28 04 	( . 
	call 02201h		;21c6	cd 01 22 	. . " 
	ret			;21c9	c9 	. 
	xor a			;21ca	af 	. 
	ld (CHRCNT),a		;21cb	32 b1 e0 	2 . . 
	jp 03203h		;21ce	c3 03 32 	. . 2 
	ld a,(CHRCNT)		;21d1	3a b1 e0 	: . . 
	and a			;21d4	a7 	. 
	jr z,$+8		;21d5	28 06 	( . 
	dec a			;21d7	3d 	= 
	ld (CHRCNT),a		;21d8	32 b1 e0 	2 . . 
	jr $+23		;21db	18 15 	. . 
	ld a,(LNSIZE)		;21dd	3a d4 e0 	: . . 
	ld (CHRCNT),a		;21e0	32 b1 e0 	2 . . 
	ld a,(LNCNT)		;21e3	3a d1 e0 	: . . 
	and a			;21e6	a7 	. 
	jr z,$+5		;21e7	28 03 	( . 
	dec a			;21e9	3d 	= 
	jr $+5		;21ea	18 03 	. . 
	ld a,(LASTLN)		;21ec	3a cd e0 	: . . 
	ld (LNCNT),a		;21ef	32 d1 e0 	2 . . 
	jp 03203h		;21f2	c3 03 32 	. . 2 
	ld a,(LASTLN)		;21f5	3a cd e0 	: . . 
	jr $+3		;21f8	18 01 	. . 
	xor a			;21fa	af 	. 
	ld e,a			;21fb	5f 	_ 
	ld d,000h		;21fc	16 00 	. . 
	jp 031fbh		;21fe	c3 fb 31 	. . 1 
	xor a			;2201	af 	. 
	ld (CHRCNT),a		;2202	32 b1 e0 	2 . . 
	call 0218dh		;2205	cd 8d 21 	. . ! 
	ret			;2208	c9 	. 
	ld a,(LNCNT)		;2209	3a d1 e0 	: . . 
	and a			;220c	a7 	. 
	jr z,$+5		;220d	28 03 	( . 
	dec a			;220f	3d 	= 
	jr $+5		;2210	18 03 	. . 
	ld a,(LASTLN)		;2212	3a cd e0 	: . . 
	ld (LNCNT),a		;2215	32 d1 e0 	2 . . 
	jp 03203h		;2218	c3 03 32 	. . 2 
	ld a,(KBINP)		;221b	3a c9 e0 	: . . 
	rra			;221e	1f 	. 
	jr nc,$+13		;221f	30 0b 	0 . 
	call 01528h		;2221	cd 28 15 	. ( . 
	jr z,$+29		;2224	28 1b 	( . 
	ld a,001h		;2226	3e 01 	> . 
	ld (POSPRO),a		;2228	32 dc e0 	2 . . 
	ret			;222b	c9 	. 
	call 0337ch		;222c	cd 7c 33 	. | 3 
	jr z,$+18		;222f	28 10 	( . 
	push bc			;2231	c5 	. 
	ld a,001h		;2232	3e 01 	> . 
	ld (TIPE),a		;2234	32 ee e0 	2 . . 
	call 032ach		;2237	cd ac 32 	. . 2 
	xor a			;223a	af 	. 
	ld (TIPE),a		;223b	32 ee e0 	2 . . 
	pop bc			;223e	c1 	. 
	jr $-19		;223f	18 eb 	. . 
	ld hl,(CURSOR)		;2241	2a b7 e0 	* . . 
	ld a,(GRACHR)		;2244	3a c0 e0 	: . . 
	rra			;2247	1f 	. 
	jr nc,$+14		;2248	30 0c 	0 . 
	ld a,b			;224a	78 	x 
	cp 020h		;224b	fe 20 	.   
	jr c,$+9		;224d	38 07 	8 . 
	cp 040h		;224f	fe 40 	. @ 
	jr nc,$+5		;2251	30 03 	0 . 
	or 080h		;2253	f6 80 	. . 
	ld b,a			;2255	47 	G 
	inc hl			;2256	23 	# 
	ld a,(ATTRIB)		;2257	3a a9 e0 	: . . 
	ld c,a			;225a	4f 	O 
	ld a,(KBINP)		;225b	3a c9 e0 	: . . 
	and a			;225e	a7 	. 
	jr z,$+6		;225f	28 04 	( . 
	ld a,020h		;2261	3e 20 	>   
	or c			;2263	b1 	. 
	ld c,a			;2264	4f 	O 
	ld a,(PROTE)		;2265	3a de e0 	: . . 
	and a			;2268	a7 	. 
	jr z,$+7		;2269	28 05 	( . 
	ld a,(hl)			;226b	7e 	~ 
	or 020h		;226c	f6 20 	.   
	jr $+15		;226e	18 0d 	. . 
	ld a,(KBINP)		;2270	3a c9 e0 	: . . 
	and a			;2273	a7 	. 
	jr nz,$+5		;2274	20 03 	  . 
	ld (hl),c			;2276	71 	q 
	jr $+7		;2277	18 05 	. . 
	ld a,(hl)			;2279	7e 	~ 
	and 040h		;227a	e6 40 	. @ 
	or c			;227c	b1 	. 
	ld (hl),a			;227d	77 	w 
	dec hl			;227e	2b 	+ 
	call 03372h		;227f	cd 72 33 	. r 3 
	jr z,$+9		;2282	28 07 	( . 
	ld a,(hl)			;2284	7e 	~ 
	and 080h		;2285	e6 80 	. . 
	or b			;2287	b0 	. 
	ld (hl),a			;2288	77 	w 
	jr $+3		;2289	18 01 	. . 
	ld (hl),b			;228b	70 	p 
	call 014bdh		;228c	cd bd 14 	. . . 
	ret			;228f	c9 	. 
	ld a,b			;2290	78 	x 
	ld (UD1ACT),a		;2291	32 9a e0 	2 . . 
	ld (UD1ADD),de		;2294	ed 53 9b e0 	. S . . 
	jr $+10		;2298	18 08 	. . 
	ld a,b			;229a	78 	x 
	ld (UD2ACT),a		;229b	32 9d e0 	2 . . 
	ld (UD2ADD),de		;229e	ed 53 9e e0 	. S . . 
	call 0070bh		;22a2	cd 0b 07 	. . . 
	ret			;22a5	c9 	. 
	ld b,(hl)			;22a6	46 	F 
	ld a,b			;22a7	78 	x 
	cp 0ffh		;22a8	fe ff 	. . 
	ret z			;22aa	c8 	. 
	push hl			;22ab	e5 	. 
	call 01f4fh		;22ac	cd 4f 1f 	. O . 
	pop hl			;22af	e1 	. 
	inc hl			;22b0	23 	# 
	jr $-11		;22b1	18 f3 	. . 
	ld a,b			;22b3	78 	x 
	bit 7,a		;22b4	cb 7f 	.  
	jr nz,$+34		;22b6	20 20 	    
	rlca			;22b8	07 	. 
	ld e,a			;22b9	5f 	_ 
	ld d,000h		;22ba	16 00 	. . 
	ld a,(TABLE)		;22bc	3a ec e0 	: . . 
	ld (SAVEA),a		;22bf	32 e2 e0 	2 . . 
	cp 000h		;22c2	fe 00 	. . 
	jr z,$+32		;22c4	28 1e 	( . 
	call 02526h		;22c6	cd 26 25 	. & % 
	ld hl,02377h		;22c9	21 77 23 	! w # 
	ld a,(SAVEA)		;22cc	3a e2 e0 	: . . 
	cp 001h		;22cf	fe 01 	. . 
	jr z,$+32		;22d1	28 1e 	( . 
	ld hl,02437h		;22d3	21 37 24 	! 7 $ 
	jr $+27		;22d6	18 19 	. . 
	and 07fh		;22d8	e6 7f 	.  
	ld b,a			;22da	47 	G 
	rlca			;22db	07 	. 
	ld e,a			;22dc	5f 	_ 
	ld d,000h		;22dd	16 00 	. . 
	ld hl,02497h		;22df	21 97 24 	! . $ 
	jr $+15		;22e2	18 0d 	. . 
	ld hl,022f7h		;22e4	21 f7 22 	! . " 
	ld a,(OBYTE2)		;22e7	3a 47 e0 	: G . 
	and 008h		;22ea	e6 08 	. . 
	jr z,$+5		;22ec	28 03 	( . 
	ld hl,02337h		;22ee	21 37 23 	! 7 # 
	add hl,de			;22f1	19 	. 
	ld e,(hl)			;22f2	5e 	^ 
	inc hl			;22f3	23 	# 
	ld d,(hl)			;22f4	56 	V 
	ex de,hl			;22f5	eb 	. 
	jp (hl)			;22f6	e9 	. 
	ld a,025h		;22f7	3e 25 	> % 
	ex af,af'			;22f9	08 	. 
	ld l,03eh		;22fa	2e 3e 	. > 
	dec h			;22fc	25 	% 
	ld (hl),016h		;22fd	36 16 	6 . 
	ld (02c16h),a		;22ff	32 16 2c 	2 . , 
	dec e			;2302	1d 	. 
	ld a,025h		;2303	3e 25 	> % 
	add hl,de			;2305	19 	. 
	dec d			;2306	15 	. 
	inc a			;2307	3c 	< 
	cpl			;2308	2f 	/ 
	ccf			;2309	3f 	? 
	dec h			;230a	25 	% 
	ld bc,0b822h		;230b	01 22 b8 	. " . 
	jr nz,$-23		;230e	20 e7 	  . 
	jr nz,$-63		;2310	20 bf 	  . 
	ld hl,01ceeh		;2312	21 ee 1c 	! . . 
	dec sp			;2315	3b 	; 
	ld d,03bh		;2316	16 3b 	. ; 
	dec de			;2318	1b 	. 
	inc b			;2319	04 	. 
	ld l,023h		;231a	2e 23 	. # 
	dec e			;231c	1d 	. 
	ld de,0021bh		;231d	11 1b 02 	. . . 
	dec e			;2320	1d 	. 
	ld c,a			;2321	4f 	O 
	ld d,03eh		;2322	16 3e 	. > 
	dec h			;2324	25 	% 
	add hl,bc			;2325	09 	. 
	ld (014bdh),hl		;2326	22 bd 14 	" . . 
	pop de			;2329	d1 	. 
	ld hl,02180h		;232a	21 80 21 	! . ! 
	ld a,025h		;232d	3e 25 	> % 
	or 01ch		;232f	f6 1c 	. . 
	ld b,e			;2331	43 	C 
	ld d,02bh		;2332	16 2b 	. + 
	dec h			;2334	25 	% 
	ld a,025h		;2335	3e 25 	> % 
	ld a,025h		;2337	3e 25 	> % 
	ex af,af'			;2339	08 	. 
	ld l,03bh		;233a	2e 3b 	. ; 
	dec de			;233c	1b 	. 
	ld (hl),016h		;233d	36 16 	6 . 
	ld (02c16h),a		;233f	32 16 2c 	2 . , 
	dec e			;2342	1d 	. 
	ld (bc),a			;2343	02 	. 
	dec e			;2344	1d 	. 
	add hl,de			;2345	19 	. 
	dec d			;2346	15 	. 
	pop de			;2347	d1 	. 
	ld hl,032ach		;2348	21 ac 32 	! . 2 
	adc a,l			;234b	8d 	. 
	ld hl,020b8h		;234c	21 b8 20 	! .   
	rst 20h			;234f	e7 	. 
	jr nz,$-63		;2350	20 bf 	  . 
	ld hl,01ceeh		;2352	21 ee 1c 	! . . 
	dec sp			;2355	3b 	; 
	ld d,03eh		;2356	16 3e 	. > 
	dec h			;2358	25 	% 
	jp (hl)			;2359	e9 	. 
	inc e			;235a	1c 	. 
	inc hl			;235b	23 	# 
	dec e			;235c	1d 	. 
	ret po			;235d	e0 	. 
	inc e			;235e	1c 	. 
	ld a,025h		;235f	3e 25 	> % 
	ld c,a			;2361	4f 	O 
	ld d,011h		;2362	16 11 	. . 
	dec de			;2364	1b 	. 
	add hl,bc			;2365	09 	. 
	ld (014bdh),hl		;2366	22 bd 14 	" . . 
	inc a			;2369	3c 	< 
	cpl			;236a	2f 	/ 
	add a,b			;236b	80 	. 
	ld hl,0253eh		;236c	21 3e 25 	! > % 
	or 01ch		;236f	f6 1c 	. . 
	ld b,e			;2371	43 	C 
	ld d,02bh		;2372	16 2b 	. + 
	dec h			;2374	25 	% 
	ld e,h			;2375	5c 	\ 
	jr nz,$+33		;2376	20 1f 	  . 
	dec h			;2378	25 	% 
	ex af,af'			;2379	08 	. 
	ld l,004h		;237a	2e 04 	. . 
	ld l,01fh		;237c	2e 1f 	. . 
	dec h			;237e	25 	% 
	ld d,h			;237f	54 	T 
	dec h			;2380	25 	% 
	ld b,017h		;2381	06 17 	. . 
	rra			;2383	1f 	. 
	dec h			;2384	25 	% 
	rra			;2385	1f 	. 
	dec h			;2386	25 	% 
	inc a			;2387	3c 	< 
	cpl			;2388	2f 	/ 
	jp 01f17h		;2389	c3 17 1f 	. . . 
	dec h			;238c	25 	% 
	ld a,032h		;238d	3e 32 	> 2 
	rra			;238f	1f 	. 
	dec h			;2390	25 	% 
	rra			;2391	1f 	. 
	dec h			;2392	25 	% 
	sbc a,b			;2393	98 	. 
	dec de			;2394	1b 	. 
	jp (hl)			;2395	e9 	. 
	dec de			;2396	1b 	. 
	sbc a,01bh		;2397	de 1b 	. . 
	inc b			;2399	04 	. 
	ld l,02fh		;239a	2e 2f 	. / 
	dec h			;239c	25 	% 
	jp (hl)			;239d	e9 	. 
	dec de			;239e	1b 	. 
	ld l,h			;239f	6c 	l 
	ld d,03eh		;23a0	16 3e 	. > 
	dec h			;23a2	25 	% 
	inc bc			;23a3	03 	. 
	ld e,01fh		;23a4	1e 1f 	. . 
	dec h			;23a6	25 	% 
	cp l			;23a7	bd 	. 
	inc d			;23a8	14 	. 
	pop de			;23a9	d1 	. 
	ld hl,02180h		;23aa	21 80 21 	! . ! 
	rra			;23ad	1f 	. 
	dec h			;23ae	25 	% 
	ld h,b			;23af	60 	` 
	ld d,05dh		;23b0	16 5d 	. ] 
	ld d,01fh		;23b2	16 1f 	. . 
	dec h			;23b4	25 	% 
	rra			;23b5	1f 	. 
	dec h			;23b6	25 	% 
	ld a,025h		;23b7	3e 25 	> % 
	ld a,025h		;23b9	3e 25 	> % 
	ld a,025h		;23bb	3e 25 	> % 
	ld a,025h		;23bd	3e 25 	> % 
	ld a,025h		;23bf	3e 25 	> % 
	ld a,025h		;23c1	3e 25 	> % 
	ld a,025h		;23c3	3e 25 	> % 
	ld a,025h		;23c5	3e 25 	> % 
	ld a,025h		;23c7	3e 25 	> % 
	ld a,025h		;23c9	3e 25 	> % 
	ld a,025h		;23cb	3e 25 	> % 
	ld a,025h		;23cd	3e 25 	> % 
	ld a,025h		;23cf	3e 25 	> % 
	ld a,025h		;23d1	3e 25 	> % 
	ld a,025h		;23d3	3e 25 	> % 
	rra			;23d5	1f 	. 
	dec h			;23d6	25 	% 
	ld a,025h		;23d7	3e 25 	> % 
	ld a,025h		;23d9	3e 25 	> % 
	ld a,025h		;23db	3e 25 	> % 
	ld a,025h		;23dd	3e 25 	> % 
	ld a,025h		;23df	3e 25 	> % 
	ld a,025h		;23e1	3e 25 	> % 
	ld a,025h		;23e3	3e 25 	> % 
	ld a,025h		;23e5	3e 25 	> % 
	ld a,025h		;23e7	3e 25 	> % 
	ld a,025h		;23e9	3e 25 	> % 
	ld a,025h		;23eb	3e 25 	> % 
	ld a,025h		;23ed	3e 25 	> % 
	ld a,025h		;23ef	3e 25 	> % 
	ld a,025h		;23f1	3e 25 	> % 
	ld a,025h		;23f3	3e 25 	> % 
	sbc a,a			;23f5	9f 	. 
	jr nz,$-91		;23f6	20 a3 	  . 
	jr nz,$-100		;23f8	20 9a 	  . 
	add hl,de			;23fa	19 	. 
	ld a,025h		;23fb	3e 25 	> % 
	ld h,h			;23fd	64 	d 
	ld a,(de)			;23fe	1a 	. 
	jp m,0471ch		;23ff	fa 1c 47 	. . G 
	ld d,02ah		;2402	16 2a 	. * 
	dec de			;2404	1b 	. 
	call nc,01f1dh		;2405	d4 1d 1f 	. . . 
	dec h			;2408	25 	% 
	ld a,025h		;2409	3e 25 	> % 
	ld a,025h		;240b	3e 25 	> % 
	ld a,025h		;240d	3e 25 	> % 
	rra			;240f	1f 	. 
	dec h			;2410	25 	% 
	ld a,025h		;2411	3e 25 	> % 
	or d			;2413	b2 	. 
	ld d,001h		;2414	16 01 	. . 
	ld a,(de)			;2416	1a 	. 
	sbc a,b			;2417	98 	. 
	jr nz,$-2		;2418	20 fc 	  . 
	ld d,039h		;241a	16 39 	. 9 
	ld a,(de)			;241c	1a 	. 
	call z,0a118h		;241d	cc 18 a1 	. . . 
	rla			;2420	17 	. 
	inc d			;2421	14 	. 
	dec e			;2422	1d 	. 
	djnz $+31		;2423	10 1d 	. . 
	and (hl)			;2425	a6 	. 
	inc e			;2426	1c 	. 
	ld a,025h		;2427	3e 25 	> % 
	cpl			;2429	2f 	/ 
	jr nz,$+64		;242a	20 3e 	  > 
	dec h			;242c	25 	% 
	ld a,025h		;242d	3e 25 	> % 
	ld a,025h		;242f	3e 25 	> % 
	cpl			;2431	2f 	/ 
	jr nz,$+64		;2432	20 3e 	  > 
	dec h			;2434	25 	% 
	ld a,025h		;2435	3e 25 	> % 
	ld a,025h		;2437	3e 25 	> % 
	add a,e			;2439	83 	. 
	rla			;243a	17 	. 
	adc a,d			;243b	8a 	. 
	rla			;243c	17 	. 
	ld a,025h		;243d	3e 25 	> % 
	cp b			;243f	b8 	. 
	ld sp,0253eh		;2440	31 3e 25 	1 > % 
	ld a,025h		;2443	3e 25 	> % 
	rst 0			;2445	c7 	. 
	dec e			;2446	1d 	. 
	cp e			;2447	bb 	. 
	dec e			;2448	1d 	. 
	cp 01ch		;2449	fe 1c 	. . 
	ld c,e			;244b	4b 	K 
	ld d,01dh		;244c	16 1d 	. . 
	dec de			;244e	1b 	. 
	ld a,(de)			;244f	1a 	. 
	dec de			;2450	1b 	. 
	ld d,h			;2451	54 	T 
	add hl,hl			;2452	29 	) 
	ld h,e			;2453	63 	c 
	add hl,hl			;2454	29 	) 
	ld e,b			;2455	58 	X 
	rla			;2456	17 	. 
	ld a,025h		;2457	3e 25 	> % 
	dec bc			;2459	0b 	. 
	ld e,011h		;245a	1e 11 	. . 
	ld e,040h		;245c	1e 40 	. @ 
	ld a,(de)			;245e	1a 	. 
	and l			;245f	a5 	. 
	rla			;2460	17 	. 
	and b			;2461	a0 	. 
	dec d			;2462	15 	. 
	ld d,(hl)			;2463	56 	V 
	add hl,de			;2464	19 	. 
	ld c,e			;2465	4b 	K 
	inc sp			;2466	33 	3 
	ld d,d			;2467	52 	R 
	inc sp			;2468	33 	3 
	dec sp			;2469	3b 	; 
	inc sp			;246a	33 	3 
	inc bc			;246b	03 	. 
	rla			;246c	17 	. 
	jp p,03f1ch		;246d	f2 1c 3f 	. . ? 
	ld d,0b7h		;2470	16 b7 	. . 
	dec e			;2472	1d 	. 
	jp 03e1dh		;2473	c3 1d 3e 	. . > 
	dec h			;2476	25 	% 
	ld a,025h		;2477	3e 25 	> % 
	ld (hl),a			;2479	77 	w 
	rla			;247a	17 	. 
	ld a,e			;247b	7b 	{ 
	rla			;247c	17 	. 
	ld a,025h		;247d	3e 25 	> % 
	ld a,025h		;247f	3e 25 	> % 
	or 019h		;2481	f6 19 	. . 
	di			;2483	f3 	. 
	add hl,de			;2484	19 	. 
	ld a,025h		;2485	3e 25 	> % 
	inc c			;2487	0c 	. 
	rla			;2488	17 	. 
	sbc a,l			;2489	9d 	. 
	inc e			;248a	1c 	. 
	sub (hl)			;248b	96 	. 
	inc e			;248c	1c 	. 
	sub c			;248d	91 	. 
	rla			;248e	17 	. 
	sbc a,b			;248f	98 	. 
	rla			;2490	17 	. 
	ld b,01dh		;2491	06 1d 	. . 
	ld d,e			;2493	53 	S 
	ld d,086h		;2494	16 86 	. . 
	ld d,03eh		;2496	16 3e 	. > 
	dec h			;2498	25 	% 
	ld h,b			;2499	60 	` 
	dec h			;249a	25 	% 
	ld h,b			;249b	60 	` 
	dec h			;249c	25 	% 
	ld h,b			;249d	60 	` 
	dec h			;249e	25 	% 
	ld h,b			;249f	60 	` 
	dec h			;24a0	25 	% 
	ld h,b			;24a1	60 	` 
	dec h			;24a2	25 	% 
	ld h,b			;24a3	60 	` 
	dec h			;24a4	25 	% 
	ld h,b			;24a5	60 	` 
	dec h			;24a6	25 	% 
	ld h,b			;24a7	60 	` 
	dec h			;24a8	25 	% 
	ld h,b			;24a9	60 	` 
	dec h			;24aa	25 	% 
	ld h,b			;24ab	60 	` 
	dec h			;24ac	25 	% 
	ld h,b			;24ad	60 	` 
	dec h			;24ae	25 	% 
	ld h,b			;24af	60 	` 
	dec h			;24b0	25 	% 
	ld h,b			;24b1	60 	` 
	dec h			;24b2	25 	% 
	ld h,b			;24b3	60 	` 
	dec h			;24b4	25 	% 
	ld h,b			;24b5	60 	` 
	dec h			;24b6	25 	% 
	ld a,025h		;24b7	3e 25 	> % 
	ret p			;24b9	f0 	. 
	ld e,0e4h		;24ba	1e e4 	. . 
	ld e,05fh		;24bc	1e 5f 	. _ 
	ld e,057h		;24be	1e 57 	. W 
	ld e,04fh		;24c0	1e 4f 	. O 
	ld e,043h		;24c2	1e 43 	. C 
	ld e,05bh		;24c4	1e 5b 	. [ 
	ld e,053h		;24c6	1e 53 	. S 
	ld e,04bh		;24c8	1e 4b 	. K 
	ld e,03fh		;24ca	1e 3f 	. ? 
	ld e,0d2h		;24cc	1e d2 	. . 
	ld e,0e0h		;24ce	1e e0 	. . 
	ld e,0d6h		;24d0	1e d6 	. . 
	ld e,08bh		;24d2	1e 8b 	. . 
	ld e,08fh		;24d4	1e 8f 	. . 
	ld e,06fh		;24d6	1e 6f 	. o 
	ld e,077h		;24d8	1e 77 	. w 
	ld e,07bh		;24da	1e 7b 	. { 
	ld e,0e8h		;24dc	1e e8 	. . 
	ld e,07fh		;24de	1e 7f 	.  
	ld e,083h		;24e0	1e 83 	. . 
	ld e,087h		;24e2	1e 87 	. . 
	ld e,0f8h		;24e4	1e f8 	. . 
	ld de,01e93h		;24e6	11 93 1e 	. . . 
	call pe,0631eh		;24e9	ec 1e 63 	. . c 
	ld e,09ch		;24ec	1e 9c 	. . 
	ld e,047h		;24ee	1e 47 	. G 
	ld e,098h		;24f0	1e 98 	. . 
	ld e,0ddh		;24f2	1e dd 	. . 
	rra			;24f4	1f 	. 
	inc bc			;24f5	03 	. 
	jr nz,$-52		;24f6	20 ca 	  . 
	ld e,0cah		;24f8	1e ca 	. . 
	ld e,0cah		;24fa	1e ca 	. . 
	ld e,0cah		;24fc	1e ca 	. . 
	ld e,0cah		;24fe	1e ca 	. . 
	ld e,0cah		;2500	1e ca 	. . 
	ld e,0cah		;2502	1e ca 	. . 
	ld e,0cah		;2504	1e ca 	. . 
	ld e,0cah		;2506	1e ca 	. . 
	ld e,0cah		;2508	1e ca 	. . 
	ld e,0cah		;250a	1e ca 	. . 
	ld e,0cah		;250c	1e ca 	. . 
	ld e,0cah		;250e	1e ca 	. . 
	ld e,0cah		;2510	1e ca 	. . 
	ld e,0cah		;2512	1e ca 	. . 
	ld e,0cah		;2514	1e ca 	. . 
	ld e,0f4h		;2516	1e f4 	. . 
	ld e,073h		;2518	1e 73 	. s 
	ld e,067h		;251a	1e 67 	. g 
	ld e,06bh		;251c	1e 6b 	. k 
	ld e,0cdh		;251e	1e cd 	. . 
	ld h,025h		;2520	26 25 	& % 
	call 01f68h		;2522	cd 68 1f 	. h . 
	ret			;2525	c9 	. 
	xor a			;2526	af 	. 
	ld (TABLE),a		;2527	32 ec e0 	2 . . 
	ret			;252a	c9 	. 
	ld a,001h		;252b	3e 01 	> . 
	jr $+4		;252d	18 02 	. . 
	ld a,002h		;252f	3e 02 	> . 
	ld (TABLE),a		;2531	32 ec e0 	2 . . 
	ld a,(KBINP)		;2534	3a c9 e0 	: . . 
	and a			;2537	a7 	. 
	ret nz			;2538	c0 	. 
	inc a			;2539	3c 	< 
	ld (HMSGA),a		;253a	32 c2 e0 	2 . . 
	ret			;253d	c9 	. 
	ret			;253e	c9 	. 
	ld a,(KBINP)		;253f	3a c9 e0 	: . . 
	and a			;2542	a7 	. 
	ret z			;2543	c8 	. 
	ld a,(OBYTE1)		;2544	3a 46 e0 	: F . 
	and 001h		;2547	e6 01 	. . 
	jp nz,032ach		;2549	c2 ac 32 	. . 2 
	ld a,(BLKMD)		;254c	3a ab e0 	: . . 
	and a			;254f	a7 	. 
	jp nz,032ach		;2550	c2 ac 32 	. . 2 
	ret			;2553	c9 	. 
	call 02526h		;2554	cd 26 25 	. & % 
	ld a,(OBYTE2)		;2557	3a 47 e0 	: G . 
	and 008h		;255a	e6 08 	. . 
	jp z,032ach		;255c	ca ac 32 	. . 2 
	ret			;255f	c9 	. 
	ld a,00fh		;2560	3e 0f 	> . 
	and b			;2562	a0 	. 
	ld c,a			;2563	4f 	O 
	ld a,(BLKMD)		;2564	3a ab e0 	: . . 
	and a			;2567	a7 	. 
	jr nz,$+7		;2568	20 05 	  . 
	ld b,01eh		;256a	06 1e 	. . 
	call 0314ch		;256c	cd 4c 31 	. L 1 
	ld a,c			;256f	79 	y 
	cp 00fh		;2570	fe 0f 	. . 
	jr nz,$+4		;2572	20 02 	  . 
	xor a			;2574	af 	. 
	ld c,a			;2575	4f 	O 
	ld a,(CONT)		;2576	3a b5 e0 	: . . 
	rra			;2579	1f 	. 
	jr c,$+16		;257a	38 0e 	8 . 
	ld a,(SHIFT)		;257c	3a e6 e0 	: . . 
	and a			;257f	a7 	. 
	jr nz,$+6		;2580	20 04 	  . 
	ld a,070h		;2582	3e 70 	> p 
	jr $+18		;2584	18 10 	. . 
	ld a,060h		;2586	3e 60 	> ` 
	jr $+14		;2588	18 0c 	. . 
	ld a,(SHIFT)		;258a	3a e6 e0 	: . . 
	and a			;258d	a7 	. 
	jr nz,$+6		;258e	20 04 	  . 
	ld a,030h		;2590	3e 30 	> 0 
	jr $+4		;2592	18 02 	. . 
	ld a,020h		;2594	3e 20 	>   
	or c			;2596	b1 	. 
	ld b,a			;2597	47 	G 
	ld (FNCODE),a		;2598	32 f5 e0 	2 . . 
	ld a,(BLKMD)		;259b	3a ab e0 	: . . 
	and a			;259e	a7 	. 
	call z,0314ch		;259f	cc 4c 31 	. L 1 
	ld a,(BLKMD)		;25a2	3a ab e0 	: . . 
	rra			;25a5	1f 	. 
	jp nc,031d8h		;25a6	d2 d8 31 	. . 1 
	push af			;25a9	f5 	. 
	call 031b8h		;25aa	cd b8 31 	. . 1 
	pop af			;25ad	f1 	. 
	ret			;25ae	c9 	. 
	nop			;25af	00 	. 
	add hl,de			;25b0	19 	. 
	ex af,af'			;25b1	08 	. 
	ld a,(de)			;25b2	1a 	. 
	call 02f5dh		;25b3	cd 5d 2f 	. ] / 
	ld a,(LASTLN)		;25b6	3a cd e0 	: . . 
	dec a			;25b9	3d 	= 
	rlca			;25ba	07 	. 
	ld l,a			;25bb	6f 	o 
	ld h,0e0h		;25bc	26 e0 	& . 
	push hl			;25be	e5 	. 
	ld de,HMSGSV		;25bf	11 c3 e0 	. . . 
	ld bc,00004h		;25c2	01 04 00 	. . . 
	ldir		;25c5	ed b0 	. . 
	pop de			;25c7	d1 	. 
	ld hl,025afh		;25c8	21 af 25 	! . % 
	ld bc,00004h		;25cb	01 04 00 	. . . 
	ldir		;25ce	ed b0 	. . 
	call 021f5h		;25d0	cd f5 21 	. . ! 
	call 025d9h		;25d3	cd d9 25 	. . % 
	call 02209h		;25d6	cd 09 22 	. . " 
	ld b,084h		;25d9	06 84 	. . 
	ld (hl),020h		;25db	36 20 	6   
	inc hl			;25dd	23 	# 
	ld a,(hl)			;25de	7e 	~ 
	and 040h		;25df	e6 40 	. @ 
	ld (hl),a			;25e1	77 	w 
	inc hl			;25e2	23 	# 
	djnz $-8		;25e3	10 f6 	. . 
	ret			;25e5	c9 	. 
	ld a,(LASTLN)		;25e6	3a cd e0 	: . . 
	dec a			;25e9	3d 	= 
	rlca			;25ea	07 	. 
	ld e,a			;25eb	5f 	_ 
	ld d,0e0h		;25ec	16 e0 	. . 
	ld hl,HMSGSV		;25ee	21 c3 e0 	! . . 
	ld bc,00004h		;25f1	01 04 00 	. . . 
	ldir		;25f4	ed b0 	. . 
	call 02f4bh		;25f6	cd 4b 2f 	. K / 
	ret			;25f9	c9 	. 
	call 02925h		;25fa	cd 25 29 	. % ) 
	ld a,b			;25fd	78 	x 
	bit 7,b		;25fe	cb 78 	. x 
	jr z,$+8		;2600	28 06 	( . 
	call 02871h		;2602	cd 71 28 	. q ( 
	ld b,080h		;2605	06 80 	. . 
	ret			;2607	c9 	. 
	call 0271bh		;2608	cd 1b 27 	. . ' 
	ld a,b			;260b	78 	x 
	cp 080h		;260c	fe 80 	. . 
	ret z			;260e	c8 	. 
	call 02791h		;260f	cd 91 27 	. . ' 
	ret			;2612	c9 	. 
	rlca			;2613	07 	. 
	call 02925h		;2614	cd 25 29 	. % ) 
	ld a,b			;2617	78 	x 
	bit 7,a		;2618	cb 7f 	.  
	jp nz,02871h		;261a	c2 71 28 	. q ( 
	cp 007h		;261d	fe 07 	. . 
	jr nz,$+24		;261f	20 16 	  . 
	xor a			;2621	af 	. 
	ld (RPTACT),a		;2622	32 df e0 	2 . . 
	ld (KBDACT),a		;2625	32 95 e0 	2 . . 
	ld (KBRACT),a		;2628	32 96 e0 	2 . . 
	ld (CONT),a		;262b	32 b5 e0 	2 . . 
	ld a,(SHIFT)		;262e	3a e6 e0 	: . . 
	and 0fah		;2631	e6 fa 	. . 
	ld (SHIFT),a		;2633	32 e6 e0 	2 . . 
	ret			;2636	c9 	. 
	call 0271bh		;2637	cd 1b 27 	. . ' 
	ld a,b			;263a	78 	x 
	cp 080h		;263b	fe 80 	. . 
	ret z			;263d	c8 	. 
	ld a,(KBLKD)		;263e	3a ca e0 	: . . 
	and a			;2641	a7 	. 
	jr z,$+11		;2642	28 09 	( . 
	ld a,b			;2644	78 	x 
	cp 01dh		;2645	fe 1d 	. . 
	jr z,$+6		;2647	28 04 	( . 
	call 01519h		;2649	cd 19 15 	. . . 
	ret			;264c	c9 	. 
	ld a,(SAVEA)		;264d	3a e2 e0 	: . . 
	and 03fh		;2650	e6 3f 	. ? 
	jr z,$+77		;2652	28 4b 	( K 
	cp 030h		;2654	fe 30 	. 0 
	jr nc,$+73		;2656	30 47 	0 G 
	ld c,a			;2658	4f 	O 
	add a,c			;2659	81 	. 
	add a,c			;265a	81 	. 
	ld hl,0d810h		;265b	21 10 d8 	! . . 
	ld e,a			;265e	5f 	_ 
	ld d,000h		;265f	16 00 	. . 
	add hl,de			;2661	19 	. 
	ld a,(hl)			;2662	7e 	~ 
	inc hl			;2663	23 	# 
	and 003h		;2664	e6 03 	. . 
	jr z,$+57		;2666	28 37 	( 7 
	cp 001h		;2668	fe 01 	. . 
	jr nz,$+44		;266a	20 2a 	  * 
	ld a,(OBYTE1)		;266c	3a 46 e0 	: F . 
	and 001h		;266f	e6 01 	. . 
	jr nz,$+46		;2671	20 2c 	  , 
	ld d,(hl)			;2673	56 	V 
	inc hl			;2674	23 	# 
	ld e,(hl)			;2675	5e 	^ 
	ex de,hl			;2676	eb 	. 
	xor a			;2677	af 	. 
	ld (FNCODE),a		;2678	32 f5 e0 	2 . . 
	ld (SAVEHL),hl		;267b	22 e4 e0 	" . . 
	ld a,(BLKMD)		;267e	3a ab e0 	: . . 
	and a			;2681	a7 	. 
	jp nz,025a2h		;2682	c2 a2 25 	. . % 
	call 0268bh		;2685	cd 8b 26 	. . & 
	jp 031d8h		;2688	c3 d8 31 	. . 1 
	ld b,(hl)			;268b	46 	F 
	ld a,b			;268c	78 	x 
	cp 0ffh		;268d	fe ff 	. . 
	ret z			;268f	c8 	. 
	call 0314ch		;2690	cd 4c 31 	. L 1 
	inc hl			;2693	23 	# 
	jr $-9		;2694	18 f5 	. . 
	ld d,(hl)			;2696	56 	V 
	inc hl			;2697	23 	# 
	ld e,(hl)			;2698	5e 	^ 
	ex de,hl			;2699	eb 	. 
	call 0269eh		;269a	cd 9e 26 	. . & 
	ret			;269d	c9 	. 
	jp (hl)			;269e	e9 	. 
	call 02791h		;269f	cd 91 27 	. . ' 
	ld a,b			;26a2	78 	x 
	cp 080h		;26a3	fe 80 	. . 
	ret z			;26a5	c8 	. 
	ld a,(OBYTE1)		;26a6	3a 46 e0 	: F . 
	and 001h		;26a9	e6 01 	. . 
	jr nz,$+26		;26ab	20 18 	  . 
	ld hl,(CURSOR)		;26ad	2a b7 e0 	* . . 
	inc hl			;26b0	23 	# 
	ld a,(hl)			;26b1	7e 	~ 
	and 040h		;26b2	e6 40 	. @ 
	jr z,$+17		;26b4	28 0f 	( . 
	ld hl,0d810h		;26b6	21 10 d8 	! . . 
	ld a,(hl)			;26b9	7e 	~ 
	cp 033h		;26ba	fe 33 	. 3 
	jr nz,$+9		;26bc	20 07 	  . 
	inc hl			;26be	23 	# 
	push bc			;26bf	c5 	. 
	call 02696h		;26c0	cd 96 26 	. . & 
	pop bc			;26c3	c1 	. 
	ret z			;26c4	c8 	. 
	ld a,b			;26c5	78 	x 
	ld (FLAG3),a		;26c6	32 cb e0 	2 . . 
	ld a,(SAVEB)		;26c9	3a e3 e0 	: . . 
	ld (LASTKY),a		;26cc	32 cc e0 	2 . . 
	xor a			;26cf	af 	. 
	ld (KBDACT),a		;26d0	32 95 e0 	2 . . 
	ld (KBRACT),a		;26d3	32 96 e0 	2 . . 
	ld (RPTACT),a		;26d6	32 df e0 	2 . . 
	ld a,(MBYTE4)		;26d9	3a 43 e0 	: C . 
	and 004h		;26dc	e6 04 	. . 
	jr nz,$+35		;26de	20 21 	  ! 
	ld a,(SAVEA)		;26e0	3a e2 e0 	: . . 
	and 080h		;26e3	e6 80 	. . 
	jr z,$+28		;26e5	28 1a 	( . 
	ld a,001h		;26e7	3e 01 	> . 
	ld (RPTACT),a		;26e9	32 df e0 	2 . . 
	ld a,07dh		;26ec	3e 7d 	> } 
	ld (KBDACT),a		;26ee	32 95 e0 	2 . . 
	call 0070bh		;26f1	cd 0b 07 	. . . 
	jr $+13		;26f4	18 0b 	. . 
	ld a,(RPTACT)		;26f6	3a df e0 	: . . 
	rra			;26f9	1f 	. 
	jr c,$+7		;26fa	38 05 	8 . 
	xor a			;26fc	af 	. 
	ld (KBRACT),a		;26fd	32 96 e0 	2 . . 
	ret			;2700	c9 	. 
	ld a,(FLAG3)		;2701	3a cb e0 	: . . 
	ld b,a			;2704	47 	G 
	ld a,001h		;2705	3e 01 	> . 
	ld (KBINP),a		;2707	32 c9 e0 	2 . . 
	bit 7,b		;270a	cb 78 	. x 
	jr z,$+7		;270c	28 05 	( . 
	call 022b3h		;270e	cd b3 22 	. . " 
	jr $+5		;2711	18 03 	. . 
	call 028ddh		;2713	cd dd 28 	. . ( 
	xor a			;2716	af 	. 
	ld (KBINP),a		;2717	32 c9 e0 	2 . . 
	ret			;271a	c9 	. 
	ld a,b			;271b	78 	x 
	ld (SAVEB),a		;271c	32 e3 e0 	2 . . 
	ld hl,02973h		;271f	21 73 29 	! s ) 
	ld e,b			;2722	58 	X 
	ld d,000h		;2723	16 00 	. . 
	add hl,de			;2725	19 	. 
	ld a,(hl)			;2726	7e 	~ 
	ld (SAVEA),a		;2727	32 e2 e0 	2 . . 
	and 040h		;272a	e6 40 	. @ 
	ret z			;272c	c8 	. 
	ld a,b			;272d	78 	x 
	cp 01ch		;272e	fe 1c 	. . 
	jr z,$+67		;2730	28 41 	( A 
	cp 07ch		;2732	fe 7c 	. | 
	jr z,$+56		;2734	28 36 	( 6 
	cp 025h		;2736	fe 25 	. % 
	jr z,$+69		;2738	28 43 	( C 
	cp 01ah		;273a	fe 1a 	. . 
	ret nz			;273c	c0 	. 
	ld a,(LOCK)		;273d	3a cf e0 	: . . 
	cp 000h		;2740	fe 00 	. . 
	jr z,$+9		;2742	28 07 	( . 
	ld a,002h		;2744	3e 02 	> . 
	ld (LOCK),a		;2746	32 cf e0 	2 . . 
	jr $+57		;2749	18 37 	. 7 
	ld a,001h		;274b	3e 01 	> . 
	ld (LOCK),a		;274d	32 cf e0 	2 . . 
	ld a,002h		;2750	3e 02 	> . 
	out (020h),a		;2752	d3 20 	.   
	ld (LOCKLT),a		;2754	32 d0 e0 	2 . . 
	ld a,(OBYTE2)		;2757	3a 47 e0 	: G . 
	and 001h		;275a	e6 01 	. . 
	jr nz,$+9		;275c	20 07 	  . 
	ld a,001h		;275e	3e 01 	> . 
	ld (CPSLK),a		;2760	32 b6 e0 	2 . . 
	jr $+31		;2763	18 1d 	. . 
	ld a,(SHIFT)		;2765	3a e6 e0 	: . . 
	or 002h		;2768	f6 02 	. . 
	jr $+14		;276a	18 0c 	. . 
	ld a,(SHIFT)		;276c	3a e6 e0 	: . . 
	or 004h		;276f	f6 04 	. . 
	jr $+7		;2771	18 05 	. . 
	ld a,(SHIFT)		;2773	3a e6 e0 	: . . 
	or 001h		;2776	f6 01 	. . 
	ld (SHIFT),a		;2778	32 e6 e0 	2 . . 
	jr $+7		;277b	18 05 	. . 
	ld a,001h		;277d	3e 01 	> . 
	ld (CONT),a		;277f	32 b5 e0 	2 . . 
	ld b,080h		;2782	06 80 	. . 
	ret			;2784	c9 	. 
	ld d,017h		;2785	16 17 	. . 
	ld e,01fh		;2787	1e 1f 	. . 
	ld h,027h		;2789	26 27 	& ' 
	ld a,03fh		;278b	3e 3f 	> ? 
	ld b,(hl)			;278d	46 	F 
	ld b,a			;278e	47 	G 
	ld c,(hl)			;278f	4e 	N 
	ld c,a			;2790	4f 	O 
	ld a,(OBYTE2)		;2791	3a 47 e0 	: G . 
	and 002h		;2794	e6 02 	. . 
	jr z,$+38		;2796	28 24 	( $ 
	ld hl,02785h		;2798	21 85 27 	! . ' 
	ld c,00ch		;279b	0e 0c 	. . 
	ld a,(hl)			;279d	7e 	~ 
	cp b			;279e	b8 	. 
	jr z,$+8		;279f	28 06 	( . 
	inc hl			;27a1	23 	# 
	dec c			;27a2	0d 	. 
	jr nz,$-6		;27a3	20 f8 	  . 
	jr $+23		;27a5	18 15 	. . 
	ld a,(SHIFT)		;27a7	3a e6 e0 	: . . 
	ld (TIPE),a		;27aa	32 ee e0 	2 . . 
	ld a,001h		;27ad	3e 01 	> . 
	ld (SHIFT),a		;27af	32 e6 e0 	2 . . 
	call 027bch		;27b2	cd bc 27 	. . ' 
	ld a,(TIPE)		;27b5	3a ee e0 	: . . 
	ld (SHIFT),a		;27b8	32 e6 e0 	2 . . 
	ret			;27bb	c9 	. 
	ld hl,(KNSNC)		;27bc	2a a1 e0 	* . . 
	ld a,(CONT)		;27bf	3a b5 e0 	: . . 
	rra			;27c2	1f 	. 
	jr nc,$+18		;27c3	30 10 	0 . 
	ld a,(SHIFT)		;27c5	3a e6 e0 	: . . 
	and a			;27c8	a7 	. 
	jr nz,$+7		;27c9	20 05 	  . 
	ld hl,(KNSC)		;27cb	2a a5 e0 	* . . 
	jr $+16		;27ce	18 0e 	. . 
	ld hl,(KSC)		;27d0	2a a7 e0 	* . . 
	jr $+11		;27d3	18 09 	. . 
	ld a,(SHIFT)		;27d5	3a e6 e0 	: . . 
	and a			;27d8	a7 	. 
	jr z,$+5		;27d9	28 03 	( . 
	ld hl,(KSNC)		;27db	2a a3 e0 	* . . 
	ld e,b			;27de	58 	X 
	ld d,000h		;27df	16 00 	. . 
	add hl,de			;27e1	19 	. 
	ld b,(hl)			;27e2	46 	F 
	ld a,(CPSLK)		;27e3	3a b6 e0 	: . . 
	rra			;27e6	1f 	. 
	jr nc,$+14		;27e7	30 0c 	0 . 
	ld a,b			;27e9	78 	x 
	cp 07bh		;27ea	fe 7b 	. { 
	jr nc,$+9		;27ec	30 07 	0 . 
	cp 061h		;27ee	fe 61 	. a 
	ret c			;27f0	d8 	. 
	sub 020h		;27f1	d6 20 	.   
	ld b,a			;27f3	47 	G 
	ret			;27f4	c9 	. 
	ld a,b			;27f5	78 	x 
	and 0f0h		;27f6	e6 f0 	. . 
	cp 0e0h		;27f8	fe e0 	. . 
	ret c			;27fa	d8 	. 
	ld a,b			;27fb	78 	x 
	cp 0e8h		;27fc	fe e8 	. . 
	jr nc,$+81		;27fe	30 4f 	0 O 
	ld a,(OBYTE2)		;2800	3a 47 e0 	: G . 
	and 008h		;2803	e6 08 	. . 
	jr nz,$+36		;2805	20 22 	  " 
	ld a,(SHIFT)		;2807	3a e6 e0 	: . . 
	and a			;280a	a7 	. 
	jr nz,$+16		;280b	20 0e 	  . 
	ld hl,02a73h		;280d	21 73 2a 	! s * 
	ld a,(CONT)		;2810	3a b5 e0 	: . . 
	rra			;2813	1f 	. 
	jr nc,$+53		;2814	30 33 	0 3 
	ld hl,02b93h		;2816	21 93 2b 	! . + 
	jr $+48		;2819	18 2e 	. . 
	ld hl,02b03h		;281b	21 03 2b 	! . + 
	ld a,(CONT)		;281e	3a b5 e0 	: . . 
	rra			;2821	1f 	. 
	jr nc,$+39		;2822	30 25 	0 % 
	ld hl,02c23h		;2824	21 23 2c 	! # , 
	jr $+34		;2827	18 20 	.   
	ld a,(SHIFT)		;2829	3a e6 e0 	: . . 
	and a			;282c	a7 	. 
	jr nz,$+16		;282d	20 0e 	  . 
	ld hl,02a7bh		;282f	21 7b 2a 	! { * 
	ld a,(CONT)		;2832	3a b5 e0 	: . . 
	rra			;2835	1f 	. 
	jr nc,$+19		;2836	30 11 	0 . 
	ld hl,02b9bh		;2838	21 9b 2b 	! . + 
	jr $+14		;283b	18 0c 	. . 
	ld hl,02b0bh		;283d	21 0b 2b 	! . + 
	ld a,(CONT)		;2840	3a b5 e0 	: . . 
	rra			;2843	1f 	. 
	jr nc,$+5		;2844	30 03 	0 . 
	ld hl,02c2bh		;2846	21 2b 2c 	! + , 
	ld a,b			;2849	78 	x 
	and 00fh		;284a	e6 0f 	. . 
	ld b,a			;284c	47 	G 
	jr $-111		;284d	18 8f 	. . 
	and 01fh		;284f	e6 1f 	. . 
	sub 008h		;2851	d6 08 	. . 
	ld b,a			;2853	47 	G 
	ld hl,02c33h		;2854	21 33 2c 	! 3 , 
	ld a,(SHIFT)		;2857	3a e6 e0 	: . . 
	and a			;285a	a7 	. 
	jr z,$+5		;285b	28 03 	( . 
	ld hl,02ce4h		;285d	21 e4 2c 	! . , 
	ld a,(LANG)		;2860	3a 69 e0 	: i . 
	and 007h		;2863	e6 07 	. . 
	rlca			;2865	07 	. 
	ld e,a			;2866	5f 	_ 
	ld d,000h		;2867	16 00 	. . 
	add hl,de			;2869	19 	. 
	ld e,(hl)			;286a	5e 	^ 
	inc hl			;286b	23 	# 
	ld d,(hl)			;286c	56 	V 
	ex de,hl			;286d	eb 	. 
	jp 027deh		;286e	c3 de 27 	. . ' 
	and 07fh		;2871	e6 7f 	.  
	ld b,a			;2873	47 	G 
	ld hl,02973h		;2874	21 73 29 	! s ) 
	ld e,b			;2877	58 	X 
	ld d,000h		;2878	16 00 	. . 
	add hl,de			;287a	19 	. 
	ld a,(hl)			;287b	7e 	~ 
	and 040h		;287c	e6 40 	. @ 
	jr z,$+67		;287e	28 41 	( A 
	ld a,b			;2880	78 	x 
	cp 07ch		;2881	fe 7c 	. | 
	jr z,$+41		;2883	28 27 	( ' 
	cp 01ch		;2885	fe 1c 	. . 
	jr z,$+44		;2887	28 2a 	( * 
	cp 025h		;2889	fe 25 	. % 
	jr z,$+49		;288b	28 2f 	( / 
	cp 01ah		;288d	fe 1a 	. . 
	ret nz			;288f	c0 	. 
	ld a,(LOCK)		;2890	3a cf e0 	: . . 
	cp 002h		;2893	fe 02 	. . 
	ret nz			;2895	c0 	. 
	call 028d1h		;2896	cd d1 28 	. . ( 
	ld a,(OBYTE2)		;2899	3a 47 e0 	: G . 
	and 001h		;289c	e6 01 	. . 
	jr nz,$+7		;289e	20 05 	  . 
	xor a			;28a0	af 	. 
	ld (CPSLK),a		;28a1	32 b6 e0 	2 . . 
	ret			;28a4	c9 	. 
	ld a,(SHIFT)		;28a5	3a e6 e0 	: . . 
	and 0fdh		;28a8	e6 fd 	. . 
	jr $+14		;28aa	18 0c 	. . 
	ld a,(SHIFT)		;28ac	3a e6 e0 	: . . 
	and 0fbh		;28af	e6 fb 	. . 
	jr $+7		;28b1	18 05 	. . 
	ld a,(SHIFT)		;28b3	3a e6 e0 	: . . 
	and 0feh		;28b6	e6 fe 	. . 
	ld (SHIFT),a		;28b8	32 e6 e0 	2 . . 
	ret			;28bb	c9 	. 
	xor a			;28bc	af 	. 
	ld (CONT),a		;28bd	32 b5 e0 	2 . . 
	ret			;28c0	c9 	. 
	ld a,(LASTKY)		;28c1	3a cc e0 	: . . 
	cp b			;28c4	b8 	. 
	ret nz			;28c5	c0 	. 
	xor a			;28c6	af 	. 
	ld (RPTACT),a		;28c7	32 df e0 	2 . . 
	ld (KBDACT),a		;28ca	32 95 e0 	2 . . 
	ld (KBRACT),a		;28cd	32 96 e0 	2 . . 
	ret			;28d0	c9 	. 
	xor a			;28d1	af 	. 
	ld (LOCK),a		;28d2	32 cf e0 	2 . . 
	ld a,000h		;28d5	3e 00 	> . 
	out (020h),a		;28d7	d3 20 	.   
	ld (LOCKLT),a		;28d9	32 d0 e0 	2 . . 
	ret			;28dc	c9 	. 
	ld a,(BLKMD)		;28dd	3a ab e0 	: . . 
	rra			;28e0	1f 	. 
	jr nc,$+6		;28e1	30 04 	0 . 
	call 01f4fh		;28e3	cd 4f 1f 	. O . 
	ret			;28e6	c9 	. 
	ld a,(OBYTE1)		;28e7	3a 46 e0 	: F . 
	and 001h		;28ea	e6 01 	. . 
	jr nz,$+36		;28ec	20 22 	  " 
	ld a,(OBYTE4)		;28ee	3a 49 e0 	: I . 
	and 001h		;28f1	e6 01 	. . 
	jr nz,$+46		;28f3	20 2c 	  , 
	ld a,(DSPDIS)		;28f5	3a bc e0 	: . . 
	rra			;28f8	1f 	. 
	jr c,$+37		;28f9	38 23 	8 # 
	ld a,b			;28fb	78 	x 
	cp 020h		;28fc	fe 20 	.   
	jr c,$+8		;28fe	38 06 	8 . 
	ld a,(TABLE)		;2900	3a ec e0 	: . . 
	and a			;2903	a7 	. 
	jr z,$+12		;2904	28 0a 	( . 
	call 0314ch		;2906	cd 4c 31 	. L 1 
	call 02e3fh		;2909	cd 3f 2e 	. ? . 
	call 01f4fh		;290c	cd 4f 1f 	. O . 
	ret			;290f	c9 	. 
	xor a			;2910	af 	. 
	ld (POSPRO),a		;2911	32 dc e0 	2 . . 
	push bc			;2914	c5 	. 
	call 01f4fh		;2915	cd 4f 1f 	. O . 
	pop bc			;2918	c1 	. 
	ld a,(POSPRO)		;2919	3a dc e0 	: . . 
	rra			;291c	1f 	. 
	ret c			;291d	d8 	. 
	call 02e3fh		;291e	cd 3f 2e 	. ? . 
	call 0314ch		;2921	cd 4c 31 	. L 1 
	ret			;2924	c9 	. 
	ld a,(TXCNT)		;2925	3a 8e e0 	: . . 
	and a			;2928	a7 	. 
	call nz,0302fh		;2929	c4 2f 30 	. / 0 
	ld a,(KBCNT)		;292c	3a 89 e0 	: . . 
	and a			;292f	a7 	. 
	jr z,$-11		;2930	28 f3 	( . 
	ld hl,(KBOTAD)		;2932	2a 8c e0 	* . . 
	ld b,(hl)			;2935	46 	F 
	inc hl			;2936	23 	# 
	ld a,l			;2937	7d 	} 
	cp 020h		;2938	fe 20 	.   
	jr nz,$+5		;293a	20 03 	  . 
	ld hl,0db10h		;293c	21 10 db 	! . . 
	ld (KBOTAD),hl		;293f	22 8c e0 	" . . 
	ld hl,KBCNT		;2942	21 89 e0 	! . . 
	dec (hl)			;2945	35 	5 
	ret			;2946	c9 	. 
	push de			;2947	d5 	. 
	push hl			;2948	e5 	. 
	ld hl,029f3h		;2949	21 f3 29 	! . ) 
	ld d,000h		;294c	16 00 	. . 
	ld e,b			;294e	58 	X 
	add hl,de			;294f	19 	. 
	ld a,(hl)			;2950	7e 	~ 
	pop hl			;2951	e1 	. 
	pop de			;2952	d1 	. 
	ret			;2953	c9 	. 
	xor a			;2954	af 	. 
	ld (RPTACT),a		;2955	32 df e0 	2 . . 
	inc a			;2958	3c 	< 
	ld (KBLKD),a		;2959	32 ca e0 	2 . . 
	ld a,(LIGHTS)		;295c	3a ce e0 	: . . 
	or 004h		;295f	f6 04 	. . 
	jr $+11		;2961	18 09 	. . 
	xor a			;2963	af 	. 
	ld (KBLKD),a		;2964	32 ca e0 	2 . . 
	ld a,(LIGHTS)		;2967	3a ce e0 	: . . 
	and 0fbh		;296a	e6 fb 	. . 
	ld (LIGHTS),a		;296c	32 ce e0 	2 . . 
	cpl			;296f	2f 	/ 
	out (050h),a		;2970	d3 50 	. P 
	ret			;2972	c9 	. 
	nop			;2973	00 	. 
	nop			;2974	00 	. 
	nop			;2975	00 	. 
	nop			;2976	00 	. 
	nop			;2977	00 	. 
	nop			;2978	00 	. 
	nop			;2979	00 	. 
	nop			;297a	00 	. 
	nop			;297b	00 	. 
	nop			;297c	00 	. 
	nop			;297d	00 	. 
	nop			;297e	00 	. 
	nop			;297f	00 	. 
	nop			;2980	00 	. 
	nop			;2981	00 	. 
	nop			;2982	00 	. 
	ld hl,01513h		;2983	21 13 15 	! . . 
	inc d			;2986	14 	. 
	ld d,000h		;2987	16 00 	. . 
	xor b			;2989	a8 	. 
	and l			;298a	a5 	. 
	nop			;298b	00 	. 
	add a,b			;298c	80 	. 
	ld b,b			;298d	40 	@ 
	sub b			;298e	90 	. 
	ld b,b			;298f	40 	@ 
	nop			;2990	00 	. 
	xor c			;2991	a9 	. 
	and (hl)			;2992	a6 	. 
	ld bc,08080h		;2993	01 80 80 	. . . 
	add a,b			;2996	80 	. 
	add a,b			;2997	80 	. 
	ld b,b			;2998	40 	@ 
	xor d			;2999	aa 	. 
	and a			;299a	a7 	. 
	ld (bc),a			;299b	02 	. 
	add a,b			;299c	80 	. 
	add a,b			;299d	80 	. 
	add a,b			;299e	80 	. 
	add a,b			;299f	80 	. 
	add a,b			;29a0	80 	. 
	nop			;29a1	00 	. 
	nop			;29a2	00 	. 
	inc bc			;29a3	03 	. 
	add a,b			;29a4	80 	. 
	add a,b			;29a5	80 	. 
	add a,b			;29a6	80 	. 
	add a,b			;29a7	80 	. 
	nop			;29a8	00 	. 
	dec c			;29a9	0d 	. 
	nop			;29aa	00 	. 
	inc b			;29ab	04 	. 
	add a,b			;29ac	80 	. 
	add a,b			;29ad	80 	. 
	add a,b			;29ae	80 	. 
	add a,b			;29af	80 	. 
	ld (de),a			;29b0	12 	. 
	xor l			;29b1	ad 	. 
	and h			;29b2	a4 	. 
	dec b			;29b3	05 	. 
	add a,b			;29b4	80 	. 
	add a,b			;29b5	80 	. 
	add a,b			;29b6	80 	. 
	add a,b			;29b7	80 	. 
	inc e			;29b8	1c 	. 
	xor e			;29b9	ab 	. 
	and e			;29ba	a3 	. 
	ld b,080h		;29bb	06 80 	. . 
	add a,b			;29bd	80 	. 
	add a,b			;29be	80 	. 
	add a,b			;29bf	80 	. 
	dec e			;29c0	1d 	. 
	xor h			;29c1	ac 	. 
	and d			;29c2	a2 	. 
	rlca			;29c3	07 	. 
	add a,b			;29c4	80 	. 
	add a,b			;29c5	80 	. 
	add a,b			;29c6	80 	. 
	add a,b			;29c7	80 	. 
	rrca			;29c8	0f 	. 
	dec de			;29c9	1b 	. 
	nop			;29ca	00 	. 
	ex af,af'			;29cb	08 	. 
	add a,b			;29cc	80 	. 
	add a,b			;29cd	80 	. 
	add a,b			;29ce	80 	. 
	add a,b			;29cf	80 	. 
	ld a,(de)			;29d0	1a 	. 
	nop			;29d1	00 	. 
	add hl,de			;29d2	19 	. 
	add hl,bc			;29d3	09 	. 
	add a,b			;29d4	80 	. 
	add a,b			;29d5	80 	. 
	add a,b			;29d6	80 	. 
	add a,b			;29d7	80 	. 
	nop			;29d8	00 	. 
	ld (de),a			;29d9	12 	. 
	nop			;29da	00 	. 
	ld a,(bc)			;29db	0a 	. 
	add a,b			;29dc	80 	. 
	add a,b			;29dd	80 	. 
	add a,b			;29de	80 	. 
	add a,b			;29df	80 	. 
	jr nz,$+25		;29e0	20 17 	  . 
	ld c,00bh		;29e2	0e 0b 	. . 
	add a,b			;29e4	80 	. 
	add a,b			;29e5	80 	. 
	add a,b			;29e6	80 	. 
	add a,b			;29e7	80 	. 
	sbc a,a			;29e8	9f 	. 
	add a,b			;29e9	80 	. 
	jr $+14		;29ea	18 0c 	. . 
	add a,b			;29ec	80 	. 
	add a,b			;29ed	80 	. 
	add a,b			;29ee	80 	. 
	ld b,b			;29ef	40 	@ 
	sbc a,(hl)			;29f0	9e 	. 
	add a,b			;29f1	80 	. 
	sub c			;29f2	91 	. 
	add a,b			;29f3	80 	. 
	add a,b			;29f4	80 	. 
	add a,b			;29f5	80 	. 
	add a,b			;29f6	80 	. 
	add a,b			;29f7	80 	. 
	add a,b			;29f8	80 	. 
	add a,b			;29f9	80 	. 
	add a,b			;29fa	80 	. 
	add a,b			;29fb	80 	. 
	add a,b			;29fc	80 	. 
	add a,b			;29fd	80 	. 
	add a,b			;29fe	80 	. 
	add a,b			;29ff	80 	. 
	add a,b			;2a00	80 	. 
	add a,b			;2a01	80 	. 
	add a,b			;2a02	80 	. 
	ret po			;2a03	e0 	. 
	or b			;2a04	b0 	. 
	cp b			;2a05	b8 	. 
	or h			;2a06	b4 	. 
	cp h			;2a07	bc 	. 
	add a,b			;2a08	80 	. 
	scf			;2a09	37 	7 
	inc (hl)			;2a0a	34 	4 
	and a			;2a0b	a7 	. 
	ret pe			;2a0c	e8 	. 
	add a,b			;2a0d	80 	. 
	add hl,bc			;2a0e	09 	. 
	add a,b			;2a0f	80 	. 
	xor (hl)			;2a10	ae 	. 
	jr c,$+55		;2a11	38 35 	8 5 
	add a,c			;2a13	81 	. 
	ld sp,07161h		;2a14	31 61 71 	1 a q 
	jp m,03980h		;2a17	fa 80 39 	. . 9 
	ld (hl),082h		;2a1a	36 82 	6 . 
	ld (07773h),a		;2a1c	32 73 77 	2 s w 
	ei			;2a1f	fb 	. 
	jr nz,$-126		;2a20	20 80 	  . 
	add a,b			;2a22	80 	. 
	add a,e			;2a23	83 	. 
	inc sp			;2a24	33 	3 
	ld h,h			;2a25	64 	d 
	ld h,l			;2a26	65 	e 
	ld a,b			;2a27	78 	x 
	ld a,a			;2a28	7f 	 
	adc a,l			;2a29	8d 	. 
	dec de			;2a2a	1b 	. 
	add a,h			;2a2b	84 	. 
	inc (hl)			;2a2c	34 	4 
	ld h,(hl)			;2a2d	66 	f 
	ld (hl),d			;2a2e	72 	r 
	ld h,e			;2a2f	63 	c 
	ex (sp),hl			;2a30	e3 	. 
	ld l,033h		;2a31	2e 33 	. 3 
	add a,l			;2a33	85 	. 
	dec (hl)			;2a34	35 	5 
	ld h,a			;2a35	67 	g 
	ld (hl),h			;2a36	74 	t 
	halt			;2a37	76 	v 
	sbc a,e			;2a38	9b 	. 
	jr nc,$+52		;2a39	30 32 	0 2 
	add a,(hl)			;2a3b	86 	. 
	ld (hl),068h		;2a3c	36 68 	6 h 
	call p,09e62h		;2a3e	f4 62 9e 	. b . 
	inc l			;2a41	2c 	, 
	ld sp,03787h		;2a42	31 87 37 	1 . 7 
	ld l,d			;2a45	6a 	j 
	ld (hl),l			;2a46	75 	u 
	ld l,(hl)			;2a47	6e 	n 
	adc a,a			;2a48	8f 	. 
	sub d			;2a49	92 	. 
	add a,b			;2a4a	80 	. 
	adc a,b			;2a4b	88 	. 
	jr c,$+109		;2a4c	38 6b 	8 k 
	ld l,c			;2a4e	69 	i 
	ld l,l			;2a4f	6d 	m 
	sbc a,d			;2a50	9a 	. 
	add a,b			;2a51	80 	. 
	sbc a,c			;2a52	99 	. 
	adc a,c			;2a53	89 	. 
	add hl,sp			;2a54	39 	9 
	ld l,h			;2a55	6c 	l 
	ld l,a			;2a56	6f 	o 
	call m,0e380h		;2a57	fc 80 e3 	. . . 
	add a,b			;2a5a	80 	. 
	adc a,d			;2a5b	8a 	. 
	jr nc,$-7		;2a5c	30 f7 	0 . 
	ld (hl),b			;2a5e	70 	p 
	defb 0fdh,00bh,097h	;illegal sequence		;2a5f	fd 0b 97 	. . . 
	adc a,(hl)			;2a62	8e 	. 
	adc a,e			;2a63	8b 	. 
	pop af			;2a64	f1 	. 
	ret m			;2a65	f8 	. 
	push af			;2a66	f5 	. 
	cp 0ach		;2a67	fe ac 	. . 
	pop hl			;2a69	e1 	. 
	jp po,0f28ch		;2a6a	e2 8c f2 	. . . 
	ld sp,hl			;2a6d	f9 	. 
	or 080h		;2a6e	f6 80 	. . 
	xor d			;2a70	aa 	. 
	di			;2a71	f3 	. 
	xor b			;2a72	a8 	. 
	and b			;2a73	a0 	. 
	add hl,de			;2a74	19 	. 
	sbc a,b			;2a75	98 	. 
	ld a,(bc)			;2a76	0a 	. 
	inc (hl)			;2a77	34 	4 
	dec (hl)			;2a78	35 	5 
	ld (hl),032h		;2a79	36 32 	6 2 
	pop bc			;2a7b	c1 	. 
	ex af,af'			;2a7c	08 	. 
	rra			;2a7d	1f 	. 
	dec c			;2a7e	0d 	. 
	inc (hl)			;2a7f	34 	4 
	dec (hl)			;2a80	35 	5 
	ld (hl),032h		;2a81	36 32 	6 2 
	add a,b			;2a83	80 	. 
	add a,b			;2a84	80 	. 
	add a,b			;2a85	80 	. 
	add a,b			;2a86	80 	. 
	add a,b			;2a87	80 	. 
	add a,b			;2a88	80 	. 
	add a,b			;2a89	80 	. 
	add a,b			;2a8a	80 	. 
	add a,b			;2a8b	80 	. 
	add a,b			;2a8c	80 	. 
	add a,b			;2a8d	80 	. 
	add a,b			;2a8e	80 	. 
	add a,b			;2a8f	80 	. 
	add a,b			;2a90	80 	. 
	add a,b			;2a91	80 	. 
	add a,b			;2a92	80 	. 
	ret po			;2a93	e0 	. 
	or c			;2a94	b1 	. 
	cp c			;2a95	b9 	. 
	or l			;2a96	b5 	. 
	cp l			;2a97	bd 	. 
	add a,b			;2a98	80 	. 
	add a,b			;2a99	80 	. 
	call po,0e8a7h		;2a9a	e4 a7 e8 	. . . 
	add a,b			;2a9d	80 	. 
	add hl,bc			;2a9e	09 	. 
	add a,b			;2a9f	80 	. 
	xor a			;2aa0	af 	. 
	rla			;2aa1	17 	. 
	push hl			;2aa2	e5 	. 
	add a,c			;2aa3	81 	. 
	ld hl,05141h		;2aa4	21 41 51 	! A Q 
	jp m,08080h		;2aa7	fa 80 80 	. . . 
	and 082h		;2aaa	e6 82 	. . 
	jp (hl)			;2aac	e9 	. 
	ld d,e			;2aad	53 	S 
	ld d,a			;2aae	57 	W 
	ei			;2aaf	fb 	. 
	jr nz,$-126		;2ab0	20 80 	  . 
	add a,b			;2ab2	80 	. 
	add a,e			;2ab3	83 	. 
	jp pe,04544h		;2ab4	ea 44 45 	. D E 
	ld e,b			;2ab7	58 	X 
	dec c			;2ab8	0d 	. 
	adc a,l			;2ab9	8d 	. 
	ld a,(bc)			;2aba	0a 	. 
	add a,h			;2abb	84 	. 
	ex de,hl			;2abc	eb 	. 
	ld b,(hl)			;2abd	46 	F 
	ld d,d			;2abe	52 	R 
	ld b,e			;2abf	43 	C 
	ex (sp),hl			;2ac0	e3 	. 
	add a,b			;2ac1	80 	. 
	add a,b			;2ac2	80 	. 
	add a,l			;2ac3	85 	. 
	dec h			;2ac4	25 	% 
	ld b,a			;2ac5	47 	G 
	ld d,h			;2ac6	54 	T 
	ld d,(hl)			;2ac7	56 	V 
	sbc a,h			;2ac8	9c 	. 
	add a,b			;2ac9	80 	. 
	ld a,(de)			;2aca	1a 	. 
	add a,(hl)			;2acb	86 	. 
	call pe,0f448h		;2acc	ec 48 f4 	. H . 
	ld b,d			;2acf	42 	B 
	sbc a,a			;2ad0	9f 	. 
	add a,b			;2ad1	80 	. 
	add a,b			;2ad2	80 	. 
	add a,a			;2ad3	87 	. 
	adc hl,bc		;2ad4	ed 4a 	. J 
	ld d,l			;2ad6	55 	U 
	ld c,(hl)			;2ad7	4e 	N 
	adc a,a			;2ad8	8f 	. 
	and e			;2ad9	a3 	. 
	add a,b			;2ada	80 	. 
	adc a,b			;2adb	88 	. 
	xor 04bh		;2adc	ee 4b 	. K 
	ld c,c			;2ade	49 	I 
	ld c,l			;2adf	4d 	M 
	sub (hl)			;2ae0	96 	. 
	add a,b			;2ae1	80 	. 
	sub l			;2ae2	95 	. 
	adc a,c			;2ae3	89 	. 
	rst 28h			;2ae4	ef 	. 
	ld c,h			;2ae5	4c 	L 
	ld c,a			;2ae6	4f 	O 
	call m,0e380h		;2ae7	fc 80 e3 	. . . 
	add a,b			;2aea	80 	. 
	adc a,d			;2aeb	8a 	. 
	ret p			;2aec	f0 	. 
	rst 30h			;2aed	f7 	. 
	ld d,b			;2aee	50 	P 
	defb 0fdh,00ch,093h	;illegal sequence		;2aef	fd 0c 93 	. . . 
	adc a,(hl)			;2af2	8e 	. 
	adc a,e			;2af3	8b 	. 
	pop af			;2af4	f1 	. 
	ret m			;2af5	f8 	. 
	push af			;2af6	f5 	. 
	cp 0adh		;2af7	fe ad 	. . 
	pop hl			;2af9	e1 	. 
	jp po,0f28ch		;2afa	e2 8c f2 	. . . 
	ld sp,hl			;2afd	f9 	. 
	or 080h		;2afe	f6 80 	. . 
	xor e			;2b00	ab 	. 
	di			;2b01	f3 	. 
	xor b			;2b02	a8 	. 
	and c			;2b03	a1 	. 
	add hl,de			;2b04	19 	. 
	sub h			;2b05	94 	. 
	ld a,(bc)			;2b06	0a 	. 
	add hl,de			;2b07	19 	. 
	ex af,af'			;2b08	08 	. 
	jr $+28		;2b09	18 1a 	. . 
	and c			;2b0b	a1 	. 
	ex af,af'			;2b0c	08 	. 
	sbc a,b			;2b0d	98 	. 
	dec c			;2b0e	0d 	. 
	ex af,af'			;2b0f	08 	. 
	add hl,de			;2b10	19 	. 
	jr $+28		;2b11	18 1a 	. . 
	add a,b			;2b13	80 	. 
	add a,b			;2b14	80 	. 
	add a,b			;2b15	80 	. 
	add a,b			;2b16	80 	. 
	add a,b			;2b17	80 	. 
	add a,b			;2b18	80 	. 
	add a,b			;2b19	80 	. 
	add a,b			;2b1a	80 	. 
	add a,b			;2b1b	80 	. 
	add a,b			;2b1c	80 	. 
	add a,b			;2b1d	80 	. 
	add a,b			;2b1e	80 	. 
	add a,b			;2b1f	80 	. 
	add a,b			;2b20	80 	. 
	add a,b			;2b21	80 	. 
	add a,b			;2b22	80 	. 
	ret po			;2b23	e0 	. 
	or d			;2b24	b2 	. 
	cp d			;2b25	ba 	. 
	or (hl)			;2b26	b6 	. 
	cp (hl)			;2b27	be 	. 
	add a,b			;2b28	80 	. 
	scf			;2b29	37 	7 
	call po,0e8a7h		;2b2a	e4 a7 e8 	. . . 
	add a,b			;2b2d	80 	. 
	sub c			;2b2e	91 	. 
	add a,b			;2b2f	80 	. 
	xor (hl)			;2b30	ae 	. 
	jr c,$-25		;2b31	38 e5 	8 . 
	add a,c			;2b33	81 	. 
	ld sp,01101h		;2b34	31 01 11 	1 . . 
	jp m,03980h		;2b37	fa 80 39 	. . 9 
	and 082h		;2b3a	e6 82 	. . 
	nop			;2b3c	00 	. 
	inc de			;2b3d	13 	. 
	rla			;2b3e	17 	. 
	ld a,(de)			;2b3f	1a 	. 
	jr nz,$-126		;2b40	20 80 	  . 
	add a,b			;2b42	80 	. 
	add a,e			;2b43	83 	. 
	inc sp			;2b44	33 	3 
	inc b			;2b45	04 	. 
	dec b			;2b46	05 	. 
	jr $+129		;2b47	18 7f 	.  
	adc a,l			;2b49	8d 	. 
	dec de			;2b4a	1b 	. 
	add a,h			;2b4b	84 	. 
	inc (hl)			;2b4c	34 	4 
	ld b,012h		;2b4d	06 12 	. . 
	inc bc			;2b4f	03 	. 
	ex (sp),hl			;2b50	e3 	. 
	ld l,033h		;2b51	2e 33 	. 3 
	add a,l			;2b53	85 	. 
	dec (hl)			;2b54	35 	5 
	rlca			;2b55	07 	. 
	inc d			;2b56	14 	. 
	ld d,09dh		;2b57	16 9d 	. . 
	jr nc,$-23		;2b59	30 e7 	0 . 
	add a,(hl)			;2b5b	86 	. 
	ld (hl),008h		;2b5c	36 08 	6 . 
	add hl,de			;2b5e	19 	. 
	ld (bc),a			;2b5f	02 	. 
	sbc a,(hl)			;2b60	9e 	. 
	inc l			;2b61	2c 	, 
	ld sp,03787h		;2b62	31 87 37 	1 . 7 
	ld a,(bc)			;2b65	0a 	. 
	dec d			;2b66	15 	. 
	ld c,08fh		;2b67	0e 8f 	. . 
	ret nz			;2b69	c0 	. 
	add a,b			;2b6a	80 	. 
	adc a,b			;2b6b	88 	. 
	jr c,$+13		;2b6c	38 0b 	8 . 
	add hl,bc			;2b6e	09 	. 
	dec c			;2b6f	0d 	. 
	sbc a,d			;2b70	9a 	. 
	add a,b			;2b71	80 	. 
	sbc a,c			;2b72	99 	. 
	adc a,c			;2b73	89 	. 
	add hl,sp			;2b74	39 	9 
	inc c			;2b75	0c 	. 
	rrca			;2b76	0f 	. 
	call m,0e380h		;2b77	fc 80 e3 	. . . 
	add a,b			;2b7a	80 	. 
	adc a,d			;2b7b	8a 	. 
	jr nc,$-7		;2b7c	30 f7 	0 . 
	djnz $-1		;2b7e	10 fd 	. . 
	dec bc			;2b80	0b 	. 
	sub a			;2b81	97 	. 
	adc a,(hl)			;2b82	8e 	. 
	adc a,e			;2b83	8b 	. 
	rra			;2b84	1f 	. 
	ret m			;2b85	f8 	. 
	dec e			;2b86	1d 	. 
	cp 0ach		;2b87	fe ac 	. . 
	pop hl			;2b89	e1 	. 
	sbc a,b			;2b8a	98 	. 
	adc a,h			;2b8b	8c 	. 
	ld e,0f9h		;2b8c	1e f9 	. . 
	inc e			;2b8e	1c 	. 
	add a,b			;2b8f	80 	. 
	xor d			;2b90	aa 	. 
	di			;2b91	f3 	. 
	xor c			;2b92	a9 	. 
	and b			;2b93	a0 	. 
	add hl,de			;2b94	19 	. 
	add a,b			;2b95	80 	. 
	ld a,(bc)			;2b96	0a 	. 
	add hl,de			;2b97	19 	. 
	ex af,af'			;2b98	08 	. 
	jr $+28		;2b99	18 1a 	. . 
	pop bc			;2b9b	c1 	. 
	ex af,af'			;2b9c	08 	. 
	add a,b			;2b9d	80 	. 
	dec c			;2b9e	0d 	. 
	inc (hl)			;2b9f	34 	4 
	dec (hl)			;2ba0	35 	5 
	ld (hl),032h		;2ba1	36 32 	6 2 
	add a,b			;2ba3	80 	. 
	add a,b			;2ba4	80 	. 
	add a,b			;2ba5	80 	. 
	add a,b			;2ba6	80 	. 
	add a,b			;2ba7	80 	. 
	add a,b			;2ba8	80 	. 
	add a,b			;2ba9	80 	. 
	add a,b			;2baa	80 	. 
	add a,b			;2bab	80 	. 
	add a,b			;2bac	80 	. 
	add a,b			;2bad	80 	. 
	add a,b			;2bae	80 	. 
	add a,b			;2baf	80 	. 
	add a,b			;2bb0	80 	. 
	add a,b			;2bb1	80 	. 
	add a,b			;2bb2	80 	. 
	ret po			;2bb3	e0 	. 
	or e			;2bb4	b3 	. 
	cp e			;2bb5	bb 	. 
	or a			;2bb6	b7 	. 
	cp a			;2bb7	bf 	. 
	add a,b			;2bb8	80 	. 
	add a,b			;2bb9	80 	. 
	call po,0e8a7h		;2bba	e4 a7 e8 	. . . 
	add a,b			;2bbd	80 	. 
	sub c			;2bbe	91 	. 
	add a,b			;2bbf	80 	. 
	xor a			;2bc0	af 	. 
	rla			;2bc1	17 	. 
	push hl			;2bc2	e5 	. 
	add a,c			;2bc3	81 	. 
	ld hl,01101h		;2bc4	21 01 11 	! . . 
	jp m,08080h		;2bc7	fa 80 80 	. . . 
	and 082h		;2bca	e6 82 	. . 
	nop			;2bcc	00 	. 
	inc de			;2bcd	13 	. 
	rla			;2bce	17 	. 
	ld a,(de)			;2bcf	1a 	. 
	jr nz,$-126		;2bd0	20 80 	  . 
	add a,b			;2bd2	80 	. 
	add a,e			;2bd3	83 	. 
	jp pe,00504h		;2bd4	ea 04 05 	. . . 
	jr $+15		;2bd7	18 0d 	. . 
	adc a,l			;2bd9	8d 	. 
	ld a,(bc)			;2bda	0a 	. 
	add a,h			;2bdb	84 	. 
	ex de,hl			;2bdc	eb 	. 
	ld b,012h		;2bdd	06 12 	. . 
	inc bc			;2bdf	03 	. 
	ex (sp),hl			;2be0	e3 	. 
	add a,b			;2be1	80 	. 
	add a,b			;2be2	80 	. 
	add a,l			;2be3	85 	. 
	dec h			;2be4	25 	% 
	rlca			;2be5	07 	. 
	inc d			;2be6	14 	. 
	ld d,09dh		;2be7	16 9d 	. . 
	add a,b			;2be9	80 	. 
	rst 20h			;2bea	e7 	. 
	add a,(hl)			;2beb	86 	. 
	call pe,01908h		;2bec	ec 08 19 	. . . 
	ld (bc),a			;2bef	02 	. 
	sbc a,a			;2bf0	9f 	. 
	add a,b			;2bf1	80 	. 
	add a,b			;2bf2	80 	. 
	add a,a			;2bf3	87 	. 
	defb 0edh;next byte illegal after ed		;2bf4	ed 	. 
	ld a,(bc)			;2bf5	0a 	. 
	dec d			;2bf6	15 	. 
	ld c,08fh		;2bf7	0e 8f 	. . 
	ret nz			;2bf9	c0 	. 
	add a,b			;2bfa	80 	. 
	adc a,b			;2bfb	88 	. 
	xor 00bh		;2bfc	ee 0b 	. . 
	add hl,bc			;2bfe	09 	. 
	dec c			;2bff	0d 	. 
	sub (hl)			;2c00	96 	. 
	add a,b			;2c01	80 	. 
	sub l			;2c02	95 	. 
	adc a,c			;2c03	89 	. 
	rst 28h			;2c04	ef 	. 
	inc c			;2c05	0c 	. 
	rrca			;2c06	0f 	. 
	call m,0e380h		;2c07	fc 80 e3 	. . . 
	add a,b			;2c0a	80 	. 
	adc a,d			;2c0b	8a 	. 
	ret p			;2c0c	f0 	. 
	rst 30h			;2c0d	f7 	. 
	djnz $-1		;2c0e	10 fd 	. . 
	inc c			;2c10	0c 	. 
	sub e			;2c11	93 	. 
	adc a,(hl)			;2c12	8e 	. 
	adc a,e			;2c13	8b 	. 
	rra			;2c14	1f 	. 
	ret m			;2c15	f8 	. 
	dec e			;2c16	1d 	. 
	cp 0adh		;2c17	fe ad 	. . 
	pop hl			;2c19	e1 	. 
	sub h			;2c1a	94 	. 
	adc a,h			;2c1b	8c 	. 
	ld e,0f9h		;2c1c	1e f9 	. . 
	inc e			;2c1e	1c 	. 
	add a,b			;2c1f	80 	. 
	xor e			;2c20	ab 	. 
	di			;2c21	f3 	. 
	xor c			;2c22	a9 	. 
	and c			;2c23	a1 	. 
	add hl,de			;2c24	19 	. 
	add a,b			;2c25	80 	. 
	ld a,(bc)			;2c26	0a 	. 
	and h			;2c27	a4 	. 
	and l			;2c28	a5 	. 
	and (hl)			;2c29	a6 	. 
	and d			;2c2a	a2 	. 
	and c			;2c2b	a1 	. 
	ex af,af'			;2c2c	08 	. 
	add a,b			;2c2d	80 	. 
	dec c			;2c2e	0d 	. 
	ex af,af'			;2c2f	08 	. 
	add hl,de			;2c30	19 	. 
	jr $+28		;2c31	18 1a 	. . 
	ld b,e			;2c33	43 	C 
	inc l			;2c34	2c 	, 
	ld b,e			;2c35	43 	C 
	inc l			;2c36	2c 	, 
	ld e,d			;2c37	5a 	Z 
	inc l			;2c38	2c 	, 
	ld (hl),c			;2c39	71 	q 
	inc l			;2c3a	2c 	, 
	adc a,b			;2c3b	88 	. 
	inc l			;2c3c	2c 	, 
	sbc a,a			;2c3d	9f 	. 
	inc l			;2c3e	2c 	, 
	or (hl)			;2c3f	b6 	. 
	inc l			;2c40	2c 	, 
	call 0802ch		;2c41	cd 2c 80 	. , . 
	ld (03433h),a		;2c44	32 33 34 	2 3 4 
	ld (hl),037h		;2c47	36 37 	6 7 
	jr c,$+59		;2c49	38 39 	8 9 
	jr nc,$+47		;2c4b	30 2d 	0 - 
	dec a			;2c4d	3d 	= 
	ld h,b			;2c4e	60 	` 
	ld a,c			;2c4f	79 	y 
	ld e,e			;2c50	5b 	[ 
	ld e,h			;2c51	5c 	\ 
	dec sp			;2c52	3b 	; 
	daa			;2c53	27 	' 
	ld a,e			;2c54	7b 	{ 
	add a,b			;2c55	80 	. 
	ld a,d			;2c56	7a 	z 
	inc l			;2c57	2c 	, 
	ld l,02fh		;2c58	2e 2f 	. / 
	jp nz,03332h		;2c5a	c2 32 33 	. 2 3 
	inc (hl)			;2c5d	34 	4 
	ld (hl),037h		;2c5e	36 37 	6 7 
	jr c,$+59		;2c60	38 39 	8 9 
	jr nc,$+41		;2c62	30 27 	0 ' 
	ld e,(hl)			;2c64	5e 	^ 
	add a,b			;2c65	80 	. 
	ld a,c			;2c66	79 	y 
	ld b,b			;2c67	40 	@ 
	ld h,07bh		;2c68	26 7b 	& { 
	ld a,h			;2c6a	7c 	| 
	ld h,b			;2c6b	60 	` 
	inc a			;2c6c	3c 	< 
	ld a,d			;2c6d	7a 	z 
	inc l			;2c6e	2c 	, 
	ld l,02dh		;2c6f	2e 2d 	. - 
	jp nz,03332h		;2c71	c2 32 33 	. 2 3 
	inc (hl)			;2c74	34 	4 
	ld (hl),037h		;2c75	36 37 	6 7 
	jr c,$+59		;2c77	38 39 	8 9 
	jr nc,$+128		;2c79	30 7e 	0 ~ 
	daa			;2c7b	27 	' 
	add a,b			;2c7c	80 	. 
	ld a,d			;2c7d	7a 	z 
	ld a,l			;2c7e	7d 	} 
	dec hl			;2c7f	2b 	+ 
	ld a,h			;2c80	7c 	| 
	ld a,e			;2c81	7b 	{ 
	inc hl			;2c82	23 	# 
	inc a			;2c83	3c 	< 
	ld a,c			;2c84	79 	y 
	inc l			;2c85	2c 	, 
	ld l,02dh		;2c86	2e 2d 	. - 
	jp nz,03332h		;2c88	c2 32 33 	. 2 3 
	inc (hl)			;2c8b	34 	4 
	ld (hl),037h		;2c8c	36 37 	6 7 
	jr c,$+59		;2c8e	38 39 	8 9 
	jr nc,$+45		;2c90	30 2b 	0 + 
	ld h,b			;2c92	60 	` 
	add a,b			;2c93	80 	. 
	ld a,c			;2c94	79 	y 
	ld a,l			;2c95	7d 	} 
	ld a,(hl)			;2c96	7e 	~ 
	ld a,h			;2c97	7c 	| 
	ld a,e			;2c98	7b 	{ 
	daa			;2c99	27 	' 
	inc a			;2c9a	3c 	< 
	ld a,d			;2c9b	7a 	z 
	inc l			;2c9c	2c 	, 
	ld l,02dh		;2c9d	2e 2d 	. - 
	ld h,b			;2c9f	60 	` 
	ld (03433h),a		;2ca0	32 33 34 	2 3 4 
	ld (hl),037h		;2ca3	36 37 	6 7 
	jr c,$+59		;2ca5	38 39 	8 9 
	jr nc,$+47		;2ca7	30 2d 	0 - 
	dec a			;2ca9	3d 	= 
	add a,b			;2caa	80 	. 
	ld a,c			;2cab	79 	y 
	ld e,e			;2cac	5b 	[ 
	ld e,h			;2cad	5c 	\ 
	dec sp			;2cae	3b 	; 
	daa			;2caf	27 	' 
	ld a,e			;2cb0	7b 	{ 
	inc a			;2cb1	3c 	< 
	ld a,d			;2cb2	7a 	z 
	inc l			;2cb3	2c 	, 
	ld l,02fh		;2cb4	2e 2f 	. / 
	ld h,b			;2cb6	60 	` 
	ld (03433h),a		;2cb7	32 33 34 	2 3 4 
	ld (hl),037h		;2cba	36 37 	6 7 
	jr c,$+59		;2cbc	38 39 	8 9 
	jr nc,$+47		;2cbe	30 2d 	0 - 
	dec a			;2cc0	3d 	= 
	add a,b			;2cc1	80 	. 
	ld a,c			;2cc2	79 	y 
	jp nz,07c7dh		;2cc3	c2 7d 7c 	. } | 
	ld a,e			;2cc6	7b 	{ 
	daa			;2cc7	27 	' 
	inc a			;2cc8	3c 	< 
	ld a,d			;2cc9	7a 	z 
	inc l			;2cca	2c 	, 
	ld l,02fh		;2ccb	2e 2f 	. / 
	jp nz,03332h		;2ccd	c2 32 33 	. 2 3 
	inc (hl)			;2cd0	34 	4 
	ld (hl),037h		;2cd1	36 37 	6 7 
	jr c,$+59		;2cd3	38 39 	8 9 
	jr nc,$+45		;2cd5	30 2b 	0 + 
	ld h,b			;2cd7	60 	` 
	add a,b			;2cd8	80 	. 
	ld a,c			;2cd9	79 	y 
	ld a,l			;2cda	7d 	} 
	ld a,(hl)			;2cdb	7e 	~ 
	ld a,h			;2cdc	7c 	| 
	ld a,e			;2cdd	7b 	{ 
	daa			;2cde	27 	' 
	inc a			;2cdf	3c 	< 
	ld a,d			;2ce0	7a 	z 
	inc l			;2ce1	2c 	, 
	ld l,02dh		;2ce2	2e 2d 	. - 
	call p,0f42ch		;2ce4	f4 2c f4 	. , . 
	inc l			;2ce7	2c 	, 
	dec bc			;2ce8	0b 	. 
	dec l			;2ce9	2d 	- 
	ld (0392dh),hl		;2cea	22 2d 39 	" - 9 
	dec l			;2ced	2d 	- 
	ld d,b			;2cee	50 	P 
	dec l			;2cef	2d 	- 
	ld h,a			;2cf0	67 	g 
	dec l			;2cf1	2d 	- 
	ld a,(hl)			;2cf2	7e 	~ 
	dec l			;2cf3	2d 	- 
	add a,b			;2cf4	80 	. 
	ld b,b			;2cf5	40 	@ 
	inc hl			;2cf6	23 	# 
	inc h			;2cf7	24 	$ 
	ld e,(hl)			;2cf8	5e 	^ 
	ld h,02ah		;2cf9	26 2a 	& * 
	jr z,$+43		;2cfb	28 29 	( ) 
	ld e,a			;2cfd	5f 	_ 
	dec hl			;2cfe	2b 	+ 
	ld a,(hl)			;2cff	7e 	~ 
	ld e,c			;2d00	59 	Y 
	ld e,l			;2d01	5d 	] 
	ld a,h			;2d02	7c 	| 
	ld a,(07d22h)		;2d03	3a 22 7d 	: " } 
	add a,b			;2d06	80 	. 
	ld e,d			;2d07	5a 	Z 
	inc a			;2d08	3c 	< 
	ld a,03fh		;2d09	3e 3f 	> ? 
	jp 05d22h		;2d0b	c3 22 5d 	. " ] 
	inc h			;2d0e	24 	$ 
	dec hl			;2d0f	2b 	+ 
	cpl			;2d10	2f 	/ 
	jr z,$+43		;2d11	28 29 	( ) 
	dec a			;2d13	3d 	= 
	ccf			;2d14	3f 	? 
	ld a,(hl)			;2d15	7e 	~ 
	add a,b			;2d16	80 	. 
	ld e,c			;2d17	59 	Y 
	ld e,h			;2d18	5c 	\ 
	ld hl,(05b7dh)		;2d19	2a 7d 5b 	* } [ 
	inc hl			;2d1c	23 	# 
	ld a,05ah		;2d1d	3e 5a 	> Z 
	dec sp			;2d1f	3b 	; 
	ld a,(0c35fh)		;2d20	3a 5f c3 	: _ . 
	ld (02440h),hl		;2d23	22 40 24 	" @ $ 
	ld h,02fh		;2d26	26 2f 	& / 
	jr z,$+43		;2d28	28 29 	( ) 
	dec a			;2d2a	3d 	= 
	ccf			;2d2b	3f 	? 
	ld h,b			;2d2c	60 	` 
	add a,b			;2d2d	80 	. 
	ld e,d			;2d2e	5a 	Z 
	ld e,l			;2d2f	5d 	] 
	ld hl,(05b5ch)		;2d30	2a 5c 5b 	* \ [ 
	ld e,(hl)			;2d33	5e 	^ 
	ld a,059h		;2d34	3e 59 	> Y 
	dec sp			;2d36	3b 	; 
	ld a,(0c35fh)		;2d37	3a 5f c3 	: _ . 
	ld (02423h),hl		;2d3a	22 23 24 	" # $ 
	ld h,02fh		;2d3d	26 2f 	& / 
	jr z,$+43		;2d3f	28 29 	( ) 
	dec a			;2d41	3d 	= 
	ccf			;2d42	3f 	? 
	ld b,b			;2d43	40 	@ 
	add a,b			;2d44	80 	. 
	ld e,c			;2d45	59 	Y 
	ld e,l			;2d46	5d 	] 
	ld e,(hl)			;2d47	5e 	^ 
	ld e,h			;2d48	5c 	\ 
	ld e,e			;2d49	5b 	[ 
	ld hl,(05a3eh)		;2d4a	2a 3e 5a 	* > Z 
	dec sp			;2d4d	3b 	; 
	ld a,(07e5fh)		;2d4e	3a 5f 7e 	: _ ~ 
	ld b,b			;2d51	40 	@ 
	inc hl			;2d52	23 	# 
	inc h			;2d53	24 	$ 
	ld e,(hl)			;2d54	5e 	^ 
	ld h,02ah		;2d55	26 2a 	& * 
	jr z,$+43		;2d57	28 29 	( ) 
	ld e,a			;2d59	5f 	_ 
	dec hl			;2d5a	2b 	+ 
	add a,b			;2d5b	80 	. 
	ld e,c			;2d5c	59 	Y 
	ld e,l			;2d5d	5d 	] 
	ld a,h			;2d5e	7c 	| 
	ld a,(07d22h)		;2d5f	3a 22 7d 	: " } 
	ld a,05ah		;2d62	3e 5a 	> Z 
	inc l			;2d64	2c 	, 
	ld l,03fh		;2d65	2e 3f 	. ? 
	ld a,(hl)			;2d67	7e 	~ 
	ld b,b			;2d68	40 	@ 
	inc hl			;2d69	23 	# 
	inc h			;2d6a	24 	$ 
	ld e,(hl)			;2d6b	5e 	^ 
	ld h,02ah		;2d6c	26 2a 	& * 
	jr z,$+43		;2d6e	28 29 	( ) 
	ld e,a			;2d70	5f 	_ 
	dec hl			;2d71	2b 	+ 
	add a,b			;2d72	80 	. 
	ld e,c			;2d73	59 	Y 
	jp 05c5dh		;2d74	c3 5d 5c 	. ] \ 
	ld e,e			;2d77	5b 	[ 
	ld (05a3eh),hl		;2d78	22 3e 5a 	" > Z 
	dec sp			;2d7b	3b 	; 
	ld a,(0c33fh)		;2d7c	3a 3f c3 	: ? . 
	ld (02423h),hl		;2d7f	22 23 24 	" # $ 
	ld h,02fh		;2d82	26 2f 	& / 
	jr z,$+43		;2d84	28 29 	( ) 
	dec a			;2d86	3d 	= 
	ccf			;2d87	3f 	? 
	ld b,b			;2d88	40 	@ 
	add a,b			;2d89	80 	. 
	ld e,c			;2d8a	59 	Y 
	ld e,l			;2d8b	5d 	] 
	ld e,(hl)			;2d8c	5e 	^ 
	ld e,h			;2d8d	5c 	\ 
	ld e,e			;2d8e	5b 	[ 
	ld hl,(05a3eh)		;2d8f	2a 3e 5a 	* > Z 
	dec sp			;2d92	3b 	; 
	ld a,(0cd5fh)		;2d93	3a 5f cd 	: _ . 
	sbc a,d			;2d96	9a 	. 
	dec l			;2d97	2d 	- 
	jr $-3		;2d98	18 fb 	. . 
	ld a,(NOPTR)		;2d9a	3a f8 e0 	: . . 
	and a			;2d9d	a7 	. 
	jr nz,$+10		;2d9e	20 08 	  . 
	call 005c1h		;2da0	cd c1 05 	. . . 
	and 001h		;2da3	e6 01 	. . 
	call nz,006f1h		;2da5	c4 f1 06 	. . . 
	ld a,(PRINTA)		;2da8	3a dd e0 	: . . 
	and a			;2dab	a7 	. 
	jr z,$+7		;2dac	28 05 	( . 
	call 02e55h		;2dae	cd 55 2e 	. U . 
	jr $+19		;2db1	18 11 	. . 
	ld a,(0e0f7h)		;2db3	3a f7 e0 	: . . 
	and a			;2db6	a7 	. 
	jr nz,$+13		;2db7	20 0b 	  . 
	ld hl,(BFCNT)		;2db9	2a 83 e0 	* . . 
	ld a,l			;2dbc	7d 	} 
	or h			;2dbd	b4 	. 
	jr z,$+6		;2dbe	28 04 	( . 
	call 01f11h		;2dc0	cd 11 1f 	. . . 
	ret			;2dc3	c9 	. 
	ld a,(HMSGA)		;2dc4	3a c2 e0 	: . . 
	and a			;2dc7	a7 	. 
	jr nz,$+9		;2dc8	20 07 	  . 
	ld a,(KBCNT)		;2dca	3a 89 e0 	: . . 
	and a			;2dcd	a7 	. 
	call nz,02614h		;2dce	c4 14 26 	. . & 
	ld a,(TXCNT)		;2dd1	3a 8e e0 	: . . 
	and a			;2dd4	a7 	. 
	jr z,$+6		;2dd5	28 04 	( . 
	call 0302fh		;2dd7	cd 2f 30 	. / 0 
	ret			;2dda	c9 	. 
	ld a,(BLKSND)		;2ddb	3a ac e0 	: . . 
	rra			;2dde	1f 	. 
	call c,0302fh		;2ddf	dc 2f 30 	. / 0 
	call 004a1h		;2de2	cd a1 04 	. . . 
	and 020h		;2de5	e6 20 	.   
	ld hl,CCDSR		;2de7	21 ae e0 	! . . 
	cp (hl)			;2dea	be 	. 
	call nz,00422h		;2deb	c4 22 04 	. " . 
	ret			;2dee	c9 	. 
	ld a,(TBYTE4)		;2def	3a 63 e0 	: c . 
	and 002h		;2df2	e6 02 	. . 
	ret z			;2df4	c8 	. 
	call 005c8h		;2df5	cd c8 05 	. . . 
	and 080h		;2df8	e6 80 	. . 
	ret nz			;2dfa	c0 	. 
	ld a,019h		;2dfb	3e 19 	> . 
	ld (PNTACT),a		;2dfd	32 98 e0 	2 . . 
	call 0070bh		;2e00	cd 0b 07 	. . . 
	ret			;2e03	c9 	. 
	ld b,001h		;2e04	06 01 	. . 
	jr $+4		;2e06	18 02 	. . 
	ld b,003h		;2e08	06 03 	. . 
	ld a,(NOPTR)		;2e0a	3a f8 e0 	: . . 
	and a			;2e0d	a7 	. 
	jr nz,$+15		;2e0e	20 0d 	  . 
	ld a,(KBINP)		;2e10	3a c9 e0 	: . . 
	rra			;2e13	1f 	. 
	jr c,$+13		;2e14	38 0b 	8 . 
	call 005c8h		;2e16	cd c8 05 	. . . 
	and 020h		;2e19	e6 20 	.   
	jr nz,$+12		;2e1b	20 0a 	  . 
	call 01d77h		;2e1d	cd 77 1d 	. w . 
	ret			;2e20	c9 	. 
	ld a,(BLKMD)		;2e21	3a ab e0 	: . . 
	rra			;2e24	1f 	. 
	jr c,$+7		;2e25	38 05 	8 . 
	ld a,001h		;2e27	3e 01 	> . 
	ld (COMPNT),a		;2e29	32 b4 e0 	2 . . 
	ld a,b			;2e2c	78 	x 
	ld (PRINTA),a		;2e2d	32 dd e0 	2 . . 
	call 02954h		;2e30	cd 54 29 	. T ) 
	call 02f5dh		;2e33	cd 5d 2f 	. ] / 
	ld b,00ch		;2e36	06 0c 	. . 
	call 02e7fh		;2e38	cd 7f 2e 	.  . 
	call 021cah		;2e3b	cd ca 21 	. . ! 
	ret			;2e3e	c9 	. 
	ld a,(NOPTR)		;2e3f	3a f8 e0 	: . . 
	and a			;2e42	a7 	. 
	ret nz			;2e43	c0 	. 
	ld a,(OBYTE1)		;2e44	3a 46 e0 	: F . 
	and 002h		;2e47	e6 02 	. . 
	ret z			;2e49	c8 	. 
	call 005c1h		;2e4a	cd c1 05 	. . . 
	and 020h		;2e4d	e6 20 	.   
	jr z,$-5		;2e4f	28 f9 	( . 
	call 005d1h		;2e51	cd d1 05 	. . . 
	ret			;2e54	c9 	. 
	call 005c8h		;2e55	cd c8 05 	. . . 
	and 020h		;2e58	e6 20 	.   
	ret z			;2e5a	c8 	. 
	ld a,(PNTACT)		;2e5b	3a 98 e0 	: . . 
	and a			;2e5e	a7 	. 
	ret nz			;2e5f	c0 	. 
	call 005c1h		;2e60	cd c1 05 	. . . 
	and 020h		;2e63	e6 20 	.   
	ret z			;2e65	c8 	. 
	ld a,(PCRLF)		;2e66	3a da e0 	: . . 
	and a			;2e69	a7 	. 
	jr z,$+28		;2e6a	28 1a 	( . 
	cp 001h		;2e6c	fe 01 	. . 
	jr nz,$+11		;2e6e	20 09 	  . 
	ld a,002h		;2e70	3e 02 	> . 
	ld (PCRLF),a		;2e72	32 da e0 	2 . . 
	ld b,00dh		;2e75	06 0d 	. . 
	jr $+8		;2e77	18 06 	. . 
	xor a			;2e79	af 	. 
	ld (PCRLF),a		;2e7a	32 da e0 	2 . . 
	ld b,00ah		;2e7d	06 0a 	. . 
	call 005d1h		;2e7f	cd d1 05 	. . . 
	call 02defh		;2e82	cd ef 2d 	. . - 
	ret			;2e85	c9 	. 
	ld a,(PNTNXT)		;2e86	3a db e0 	: . . 
	and a			;2e89	a7 	. 
	jr z,$+9		;2e8a	28 07 	( . 
	ld b,a			;2e8c	47 	G 
	xor a			;2e8d	af 	. 
	ld (PNTNXT),a		;2e8e	32 db e0 	2 . . 
	jr $+41		;2e91	18 27 	. ' 
	ld hl,(CURSOR)		;2e93	2a b7 e0 	* . . 
	ld b,(hl)			;2e96	46 	F 
	ld a,(PRINTA)		;2e97	3a dd e0 	: . . 
	cp 001h		;2e9a	fe 01 	. . 
	jr z,$+10		;2e9c	28 08 	( . 
	inc hl			;2e9e	23 	# 
	ld a,(hl)			;2e9f	7e 	~ 
	and 01fh		;2ea0	e6 1f 	. . 
	jr z,$+4		;2ea2	28 02 	( . 
	ld b,020h		;2ea4	06 20 	.   
	ld a,b			;2ea6	78 	x 
	cp 020h		;2ea7	fe 20 	.   
	jr z,$+8		;2ea9	28 06 	( . 
	xor a			;2eab	af 	. 
	ld (SPFLAG),a		;2eac	32 e7 e0 	2 . . 
	jr $+11		;2eaf	18 09 	. . 
	ld a,(SPFLAG)		;2eb1	3a e7 e0 	: . . 
	rra			;2eb4	1f 	. 
	jr c,$+5		;2eb5	38 03 	8 . 
	call 02f1ch		;2eb7	cd 1c 2f 	. . / 
	ld a,b			;2eba	78 	x 
	cp 07fh		;2ebb	fe 7f 	.  
	jr c,$+4		;2ebd	38 02 	8 . 
	ld b,020h		;2ebf	06 20 	.   
	call 005d1h		;2ec1	cd d1 05 	. . . 
	ld a,b			;2ec4	78 	x 
	cp 00dh		;2ec5	fe 0d 	. . 
	jr nz,$+11		;2ec7	20 09 	  . 
	ld a,00ah		;2ec9	3e 0a 	> . 
	ld (PNTNXT),a		;2ecb	32 db e0 	2 . . 
	call 02defh		;2ece	cd ef 2d 	. . - 
	ret			;2ed1	c9 	. 
	cp 00ah		;2ed2	fe 0a 	. . 
	jr nz,$+29		;2ed4	20 1b 	  . 
	call 02defh		;2ed6	cd ef 2d 	. . - 
	xor a			;2ed9	af 	. 
	ld (SPFLAG),a		;2eda	32 e7 e0 	2 . . 
	ld a,(LNCNT)		;2edd	3a d1 e0 	: . . 
	ld b,a			;2ee0	47 	G 
	ld a,(LASTLN)		;2ee1	3a cd e0 	: . . 
	cp b			;2ee4	b8 	. 
	jr z,$+32		;2ee5	28 1e 	( . 
	ld a,(LNSIZE)		;2ee7	3a d4 e0 	: . . 
	ld (CHRCNT),a		;2eea	32 b1 e0 	2 . . 
	call 014bdh		;2eed	cd bd 14 	. . . 
	ret			;2ef0	c9 	. 
	ld a,(CHRCNT)		;2ef1	3a b1 e0 	: . . 
	ld b,a			;2ef4	47 	G 
	ld a,(LNSIZE)		;2ef5	3a d4 e0 	: . . 
	cp b			;2ef8	b8 	. 
	jr z,$+6		;2ef9	28 04 	( . 
	call 014bdh		;2efb	cd bd 14 	. . . 
	ret			;2efe	c9 	. 
	ld a,00dh		;2eff	3e 0d 	> . 
	ld (PNTNXT),a		;2f01	32 db e0 	2 . . 
	ret			;2f04	c9 	. 
	ld a,(COMPNT)		;2f05	3a b4 e0 	: . . 
	rra			;2f08	1f 	. 
	jr nc,$+5		;2f09	30 03 	0 . 
	call 01d67h		;2f0b	cd 67 1d 	. g . 
	xor a			;2f0e	af 	. 
	ld (PRINTA),a		;2f0f	32 dd e0 	2 . . 
	ld (COMPNT),a		;2f12	32 b4 e0 	2 . . 
	call 02f4bh		;2f15	cd 4b 2f 	. K / 
	call 02963h		;2f18	cd 63 29 	. c ) 
	ret			;2f1b	c9 	. 
	ld hl,(CURSOR)		;2f1c	2a b7 e0 	* . . 
	ld a,(CHRCNT)		;2f1f	3a b1 e0 	: . . 
	ld b,a			;2f22	47 	G 
	ld a,(LNSIZE)		;2f23	3a d4 e0 	: . . 
	cp b			;2f26	b8 	. 
	jr nz,$+5		;2f27	20 03 	  . 
	ld b,00dh		;2f29	06 0d 	. . 
	ret			;2f2b	c9 	. 
	inc b			;2f2c	04 	. 
	inc hl			;2f2d	23 	# 
	inc hl			;2f2e	23 	# 
	ld a,(hl)			;2f2f	7e 	~ 
	cp 020h		;2f30	fe 20 	.   
	jr z,$-15		;2f32	28 ef 	( . 
	ld a,001h		;2f34	3e 01 	> . 
	ld (SPFLAG),a		;2f36	32 e7 e0 	2 . . 
	ld b,020h		;2f39	06 20 	.   
	ret			;2f3b	c9 	. 
	ld a,(MBYTE5)		;2f3c	3a 44 e0 	: D . 
	and 001h		;2f3f	e6 01 	. . 
	jr z,$+6		;2f41	28 04 	( . 
	call 021f5h		;2f43	cd f5 21 	. . ! 
	ret			;2f46	c9 	. 
	call 021fah		;2f47	cd fa 21 	. . ! 
	ret			;2f4a	c9 	. 
	ld a,(CHRSAV)		;2f4b	3a b2 e0 	: . . 
	ld d,a			;2f4e	57 	W 
	ld a,(LNSAV)		;2f4f	3a d3 e0 	: . . 
	ld e,a			;2f52	5f 	_ 
	call 031fbh		;2f53	cd fb 31 	. . 1 
	ld a,(ATTSAV)		;2f56	3a aa e0 	: . . 
	ld (ATTRIB),a		;2f59	32 a9 e0 	2 . . 
	ret			;2f5c	c9 	. 
	ld a,(CHRCNT)		;2f5d	3a b1 e0 	: . . 
	ld (CHRSAV),a		;2f60	32 b2 e0 	2 . . 
	ld a,(LNCNT)		;2f63	3a d1 e0 	: . . 
	ld (LNSAV),a		;2f66	32 d3 e0 	2 . . 
	ld a,(ATTRIB)		;2f69	3a a9 e0 	: . . 
	ld (ATTSAV),a		;2f6c	32 aa e0 	2 . . 
	ret			;2f6f	c9 	. 
	call 02f5dh		;2f70	cd 5d 2f 	. ] / 
	ld h,0e0h		;2f73	26 e0 	& . 
	ld a,(SRLFST)		;2f75	3a e8 e0 	: . . 
	ld l,a			;2f78	6f 	o 
	ld a,(FLAG2)		;2f79	3a bf e0 	: . . 
	and 002h		;2f7c	e6 02 	. . 
	jr z,$+6		;2f7e	28 04 	( . 
	ld a,(SRLLST)		;2f80	3a e9 e0 	: . . 
	ld l,a			;2f83	6f 	o 
	call 01fcdh		;2f84	cd cd 1f 	. . . 
	ld a,l			;2f87	7d 	} 
	rlca			;2f88	07 	. 
	ld l,a			;2f89	6f 	o 
	ex de,hl			;2f8a	eb 	. 
	xor a			;2f8b	af 	. 
	ld (CHRCNT),a		;2f8c	32 b1 e0 	2 . . 
	ld a,(PROTE)		;2f8f	3a de e0 	: . . 
	push af			;2f92	f5 	. 
	xor a			;2f93	af 	. 
	ld (PROTE),a		;2f94	32 de e0 	2 . . 
	call 0210fh		;2f97	cd 0f 21 	. . ! 
	pop af			;2f9a	f1 	. 
	ld (PROTE),a		;2f9b	32 de e0 	2 . . 
	ex de,hl			;2f9e	eb 	. 
	call 02fach		;2f9f	cd ac 2f 	. . / 
	ld a,(FLAG2)		;2fa2	3a bf e0 	: . . 
	rra			;2fa5	1f 	. 
	jr c,$-91		;2fa6	38 a3 	8 . 
	call 021f5h		;2fa8	cd f5 21 	. . ! 
	ret			;2fab	c9 	. 
	ld d,h			;2fac	54 	T 
	ld e,l			;2fad	5d 	] 
	ld c,(hl)			;2fae	4e 	N 
	inc hl			;2faf	23 	# 
	ld b,(hl)			;2fb0	46 	F 
	push bc			;2fb1	c5 	. 
	inc hl			;2fb2	23 	# 
	ld a,(SRLFST)		;2fb3	3a e8 e0 	: . . 
	ld b,a			;2fb6	47 	G 
	ld a,(SRLLST)		;2fb7	3a e9 e0 	: . . 
	sub b			;2fba	90 	. 
	jr nz,$+4		;2fbb	20 02 	  . 
	pop bc			;2fbd	c1 	. 
	ret			;2fbe	c9 	. 
	rlca			;2fbf	07 	. 
	ld c,a			;2fc0	4f 	O 
	ld b,000h		;2fc1	06 00 	. . 
	ld a,(FLAG2)		;2fc3	3a bf e0 	: . . 
	and 002h		;2fc6	e6 02 	. . 
	jr nz,$+11		;2fc8	20 09 	  . 
	ldir		;2fca	ed b0 	. . 
	pop hl			;2fcc	e1 	. 
	ld a,l			;2fcd	7d 	} 
	ld (de),a			;2fce	12 	. 
	inc de			;2fcf	13 	. 
	ld a,h			;2fd0	7c 	| 
	ld (de),a			;2fd1	12 	. 
	ret			;2fd2	c9 	. 
	dec hl			;2fd3	2b 	+ 
	dec hl			;2fd4	2b 	+ 
	dec hl			;2fd5	2b 	+ 
	inc de			;2fd6	13 	. 
	lddr		;2fd7	ed b8 	. . 
	pop hl			;2fd9	e1 	. 
	ld a,h			;2fda	7c 	| 
	ld (de),a			;2fdb	12 	. 
	dec de			;2fdc	1b 	. 
	ld a,l			;2fdd	7d 	} 
	ld (de),a			;2fde	12 	. 
	ret			;2fdf	c9 	. 
	pop hl			;2fe0	e1 	. 
	ld a,l			;2fe1	7d 	} 
	ld (de),a			;2fe2	12 	. 
	inc de			;2fe3	13 	. 
	ld a,h			;2fe4	7c 	| 
	ld (de),a			;2fe5	12 	. 
	ret			;2fe6	c9 	. 
	ld a,(PROTE)		;2fe7	3a de e0 	: . . 
	and a			;2fea	a7 	. 
	jr z,$+35		;2feb	28 21 	( ! 
	ld a,(LNCNT)		;2fed	3a d1 e0 	: . . 
	ld c,a			;2ff0	4f 	O 
	call 0301bh		;2ff1	cd 1b 30 	. . 0 
	jr z,$+10		;2ff4	28 08 	( . 
	call 01519h		;2ff6	cd 19 15 	. . . 
	call 01666h		;2ff9	cd 66 16 	. f . 
	pop hl			;2ffc	e1 	. 
	ret			;2ffd	c9 	. 
	ld a,(LASTLN)		;2ffe	3a cd e0 	: . . 
	cp c			;3001	b9 	. 
	jr z,$+9		;3002	28 07 	( . 
	inc c			;3004	0c 	. 
	call 0301bh		;3005	cd 1b 30 	. . 0 
	jr z,$-10		;3008	28 f4 	( . 
	dec c			;300a	0d 	. 
	ld a,c			;300b	79 	y 
	jr $+5		;300c	18 03 	. . 
	ld a,(LASTLN)		;300e	3a cd e0 	: . . 
	ld (SRLLST),a		;3011	32 e9 e0 	2 . . 
	ld a,(LNCNT)		;3014	3a d1 e0 	: . . 
	ld (SRLFST),a		;3017	32 e8 e0 	2 . . 
	ret			;301a	c9 	. 
	ld l,c			;301b	69 	i 
	ld h,0e0h		;301c	26 e0 	& . 
	call 01fcdh		;301e	cd cd 1f 	. . . 
	ex de,hl			;3021	eb 	. 
	ld a,(LNSIZE)		;3022	3a d4 e0 	: . . 
	ld b,a			;3025	47 	G 
	inc hl			;3026	23 	# 
	ld a,(hl)			;3027	7e 	~ 
	and 080h		;3028	e6 80 	. . 
	ret nz			;302a	c0 	. 
	inc hl			;302b	23 	# 
	djnz $-6		;302c	10 f8 	. . 
	ret			;302e	c9 	. 
	ld a,(PCDACT)		;302f	3a 97 e0 	: . . 
	and a			;3032	a7 	. 
	ret nz			;3033	c0 	. 
	ld a,(RXOFF)		;3034	3a e1 e0 	: . . 
	rra			;3037	1f 	. 
	ret c			;3038	d8 	. 
	call 00499h		;3039	cd 99 04 	. . . 
	and 020h		;303c	e6 20 	.   
	ret z			;303e	c8 	. 
	ld a,(MBYTE4)		;303f	3a 43 e0 	: C . 
	and 008h		;3042	e6 08 	. . 
	jr nz,$+67		;3044	20 41 	  A 
	call 0049dh		;3046	cd 9d 04 	. . . 
	and 001h		;3049	e6 01 	. . 
	ret z			;304b	c8 	. 
	call 004a1h		;304c	cd a1 04 	. . . 
	and 020h		;304f	e6 20 	.   
	jr nz,$+14		;3051	20 0c 	  . 
	call 02954h		;3053	cd 54 29 	. T ) 
	ld a,(KBLKD)		;3056	3a ca e0 	: . . 
	or 002h		;3059	f6 02 	. . 
	ld (KBLKD),a		;305b	32 ca e0 	2 . . 
	ret			;305e	c9 	. 
	ld a,(KBLKD)		;305f	3a ca e0 	: . . 
	and 002h		;3062	e6 02 	. . 
	jr z,$+13		;3064	28 0b 	( . 
	call 02963h		;3066	cd 63 29 	. c ) 
	ld a,(KBLKD)		;3069	3a ca e0 	: . . 
	and 0fdh		;306c	e6 fd 	. . 
	ld (KBLKD),a		;306e	32 ca e0 	2 . . 
	call 0049dh		;3071	cd 9d 04 	. . . 
	and 002h		;3074	e6 02 	. . 
	jr nz,$+11		;3076	20 09 	  . 
	call 0049dh		;3078	cd 9d 04 	. . . 
	or 002h		;307b	f6 02 	. . 
	ld b,a			;307d	47 	G 
	call 004afh		;307e	cd af 04 	. . . 
	call 004a1h		;3081	cd a1 04 	. . . 
	and 010h		;3084	e6 10 	. . 
	ret z			;3086	c8 	. 
	ld a,(TXCNT)		;3087	3a 8e e0 	: . . 
	and a			;308a	a7 	. 
	jp nz,030f8h		;308b	c2 f8 30 	. . 0 
	ld hl,(CURSOR)		;308e	2a b7 e0 	* . . 
	inc hl			;3091	23 	# 
	ld a,(PROTE)		;3092	3a de e0 	: . . 
	rra			;3095	1f 	. 
	jr nc,$+7		;3096	30 05 	0 . 
	ld a,(hl)			;3098	7e 	~ 
	and 080h		;3099	e6 80 	. . 
	jr nz,$+14		;309b	20 0c 	  . 
	ld hl,(CURSOR)		;309d	2a b7 e0 	* . . 
	ld b,(hl)			;30a0	46 	F 
	inc hl			;30a1	23 	# 
	ld a,(hl)			;30a2	7e 	~ 
	and 0dfh		;30a3	e6 df 	. . 
	ld (hl),a			;30a5	77 	w 
	call 0314ch		;30a6	cd 4c 31 	. L 1 
	ld a,(LNSIZE)		;30a9	3a d4 e0 	: . . 
	ld c,a			;30ac	4f 	O 
	ld a,(CHRCNT)		;30ad	3a b1 e0 	: . . 
	cp c			;30b0	b9 	. 
	jr nz,$+67		;30b1	20 41 	  A 
	ld a,(LASTLN)		;30b3	3a cd e0 	: . . 
	ld c,a			;30b6	4f 	O 
	ld a,(LNCNT)		;30b7	3a d1 e0 	: . . 
	cp c			;30ba	b9 	. 
	jr nz,$+57		;30bb	20 37 	  7 
	call 02f4bh		;30bd	cd 4b 2f 	. K / 
	xor a			;30c0	af 	. 
	ld (BLKSND),a		;30c1	32 ac e0 	2 . . 
	ld a,(FNCODE)		;30c4	3a f5 e0 	: . . 
	and a			;30c7	a7 	. 
	jr nz,$+10		;30c8	20 08 	  . 
	ld hl,(SAVEHL)		;30ca	2a e4 e0 	* . . 
	call 0268bh		;30cd	cd 8b 26 	. . & 
	jr $+26		;30d0	18 18 	. . 
	ld b,01eh		;30d2	06 1e 	. . 
	call 0314ch		;30d4	cd 4c 31 	. L 1 
	ld a,(FNCODE)		;30d7	3a f5 e0 	: . . 
	bit 7,a		;30da	cb 7f 	.  
	jr z,$+7		;30dc	28 05 	( . 
	ld b,012h		;30de	06 12 	. . 
	call 0314ch		;30e0	cd 4c 31 	. L 1 
	ld a,(FNCODE)		;30e3	3a f5 e0 	: . . 
	ld b,a			;30e6	47 	G 
	call 0314ch		;30e7	cd 4c 31 	. L 1 
	call 01d30h		;30ea	cd 30 1d 	. 0 . 
	call 031e2h		;30ed	cd e2 31 	. . 1 
	call 02963h		;30f0	cd 63 29 	. c ) 
	ret			;30f3	c9 	. 
	call 014bdh		;30f4	cd bd 14 	. . . 
	ret			;30f7	c9 	. 
	ld a,(TXCNT)		;30f8	3a 8e e0 	: . . 
	dec a			;30fb	3d 	= 
	ld (TXCNT),a		;30fc	32 8e e0 	2 . . 
	cp 060h		;30ff	fe 60 	. ` 
	call z,02963h		;3101	cc 63 29 	. c ) 
	ld hl,(TXOTAD)		;3104	2a 91 e0 	* . . 
	ld b,(hl)			;3107	46 	F 
	inc hl			;3108	23 	# 
	ld a,l			;3109	7d 	} 
	cp 0c0h		;310a	fe c0 	. . 
	jr nz,$+5		;310c	20 03 	  . 
	ld hl,0df00h		;310e	21 00 df 	! . . 
	ld (TXOTAD),hl		;3111	22 91 e0 	" . . 
	call 004b3h		;3114	cd b3 04 	. . . 
	ld a,(MBYTE5)		;3117	3a 44 e0 	: D . 
	and 004h		;311a	e6 04 	. . 
	jr z,$+10		;311c	28 08 	( . 
	ld a,001h		;311e	3e 01 	> . 
	ld (PCDACT),a		;3120	32 97 e0 	2 . . 
	call 0070bh		;3123	cd 0b 07 	. . . 
	ld a,(BLKSND)		;3126	3a ac e0 	: . . 
	rra			;3129	1f 	. 
	ret c			;312a	d8 	. 
	res 7,b		;312b	cb b8 	. . 
	ld a,b			;312d	78 	x 
	cp 00dh		;312e	fe 0d 	. . 
	jr z,$+13		;3130	28 0b 	( . 
	cp 00ah		;3132	fe 0a 	. . 
	jr z,$+9		;3134	28 07 	( . 
	cp 006h		;3136	fe 06 	. . 
	jr z,$+5		;3138	28 03 	( . 
	cp 015h		;313a	fe 15 	. . 
	ret nz			;313c	c0 	. 
	call 03188h		;313d	cd 88 31 	. . 1 
	ret			;3140	c9 	. 
	ld a,(BLKMD)		;3141	3a ab e0 	: . . 
	and a			;3144	a7 	. 
	jr z,$+7		;3145	28 05 	( . 
	ld a,(KBINP)		;3147	3a c9 e0 	: . . 
	and a			;314a	a7 	. 
	ret nz			;314b	c0 	. 
	res 7,b		;314c	cb b8 	. . 
	ld a,(MBYTE3)		;314e	3a 42 e0 	: B . 
	and 004h		;3151	e6 04 	. . 
	jr z,$+4		;3153	28 02 	( . 
	set 7,b		;3155	cb f8 	. . 
	ld a,(OBYTE1)		;3157	3a 46 e0 	: F . 
	and 001h		;315a	e6 01 	. . 
	ret nz			;315c	c0 	. 
	push af			;315d	f5 	. 
	push hl			;315e	e5 	. 
	ld hl,(TXINAD)		;315f	2a 8f e0 	* . . 
	ld (hl),b			;3162	70 	p 
	inc hl			;3163	23 	# 
	ld a,l			;3164	7d 	} 
	cp 0c0h		;3165	fe c0 	. . 
	jr nz,$+5		;3167	20 03 	  . 
	ld hl,0df00h		;3169	21 00 df 	! . . 
	ld (TXINAD),hl		;316c	22 8f e0 	" . . 
	ld a,(TXCNT)		;316f	3a 8e e0 	: . . 
	inc a			;3172	3c 	< 
	ld (TXCNT),a		;3173	32 8e e0 	2 . . 
	cp 0b0h		;3176	fe b0 	. . 
	call z,02954h		;3178	cc 54 29 	. T ) 
	xor a			;317b	af 	. 
	ld (TXDACT),a		;317c	32 99 e0 	2 . . 
	ld (TXEMPF),a		;317f	32 f0 e0 	2 . . 
	pop hl			;3182	e1 	. 
	pop af			;3183	f1 	. 
	ret			;3184	c9 	. 
	call 0314ch		;3185	cd 4c 31 	. L 1 
	ld a,(BLKSND)		;3188	3a ac e0 	: . . 
	and a			;318b	a7 	. 
	ret nz			;318c	c0 	. 
	ld a,(TXCNT)		;318d	3a 8e e0 	: . . 
	and a			;3190	a7 	. 
	jr nz,$+30		;3191	20 1c 	  . 
	ld a,(TXEMPF)		;3193	3a f0 e0 	: . . 
	rra			;3196	1f 	. 
	jr nc,$+10		;3197	30 08 	0 . 
	xor a			;3199	af 	. 
	ld (TXEMPF),a		;319a	32 f0 e0 	2 . . 
	call 0045ch		;319d	cd 5c 04 	. \ . 
	ret			;31a0	c9 	. 
	call 00499h		;31a1	cd 99 04 	. . . 
	and 060h		;31a4	e6 60 	. ` 
	cp 060h		;31a6	fe 60 	. ` 
	jr nz,$+7		;31a8	20 05 	  . 
	ld a,001h		;31aa	3e 01 	> . 
	ld (TXEMPF),a		;31ac	32 f0 e0 	2 . . 
	ld a,001h		;31af	3e 01 	> . 
	ld (TXDACT),a		;31b1	32 99 e0 	2 . . 
	call 0070bh		;31b4	cd 0b 07 	. . . 
	ret			;31b7	c9 	. 
	call 02954h		;31b8	cd 54 29 	. T ) 
	ld a,001h		;31bb	3e 01 	> . 
	ld (BLKSND),a		;31bd	32 ac e0 	2 . . 
	call 02f5dh		;31c0	cd 5d 2f 	. ] / 
	call 021fah		;31c3	cd fa 21 	. . ! 
	ld hl,0d89dh		;31c6	21 9d d8 	! . . 
	ld a,(hl)			;31c9	7e 	~ 
	inc hl			;31ca	23 	# 
	and 003h		;31cb	e6 03 	. . 
	cp 001h		;31cd	fe 01 	. . 
	ret nz			;31cf	c0 	. 
	ld d,(hl)			;31d0	56 	V 
	inc hl			;31d1	23 	# 
	ld e,(hl)			;31d2	5e 	^ 
	ex de,hl			;31d3	eb 	. 
	call 0268bh		;31d4	cd 8b 26 	. . & 
	ret			;31d7	c9 	. 
	ld a,(DLMENA)		;31d8	3a b9 e0 	: . . 
	and a			;31db	a7 	. 
	jr nz,$+6		;31dc	20 04 	  . 
	call 03188h		;31de	cd 88 31 	. . 1 
	ret			;31e1	c9 	. 
	ld b,00dh		;31e2	06 0d 	. . 
	call 0314ch		;31e4	cd 4c 31 	. L 1 
	ret			;31e7	c9 	. 
	push bc			;31e8	c5 	. 
	and 00fh		;31e9	e6 0f 	. . 
	ld b,a			;31eb	47 	G 
	ld a,(TOGAL)		;31ec	3a ef e0 	: . . 
	xor 040h		;31ef	ee 40 	. @ 
	ld (TOGAL),a		;31f1	32 ef e0 	2 . . 
	or b			;31f4	b0 	. 
	ld b,a			;31f5	47 	G 
	call 0314ch		;31f6	cd 4c 31 	. L 1 
	pop bc			;31f9	c1 	. 
	ret			;31fa	c9 	. 
	ld a,d			;31fb	7a 	z 
	ld (CHRCNT),a		;31fc	32 b1 e0 	2 . . 
	ld a,e			;31ff	7b 	{ 
	ld (LNCNT),a		;3200	32 d1 e0 	2 . . 
	ld h,0e0h		;3203	26 e0 	& . 
	ld a,(LNCNT)		;3205	3a d1 e0 	: . . 
	ld l,a			;3208	6f 	o 
	call 01fcdh		;3209	cd cd 1f 	. . . 
	ex de,hl			;320c	eb 	. 
	ld a,(CHRCNT)		;320d	3a b1 e0 	: . . 
	ld e,a			;3210	5f 	_ 
	ld d,000h		;3211	16 00 	. . 
	add hl,de			;3213	19 	. 
	add hl,de			;3214	19 	. 
	ld (CURSOR),hl		;3215	22 b7 e0 	" . . 
	ld a,(CHRCNT)		;3218	3a b1 e0 	: . . 
	inc a			;321b	3c 	< 
	out (01ch),a		;321c	d3 1c 	. . 
	ld a,(LNCNT)		;321e	3a d1 e0 	: . . 
	inc a			;3221	3c 	< 
	inc a			;3222	3c 	< 
	ld b,a			;3223	47 	G 
	ld a,(OBYTE4)		;3224	3a 49 e0 	: I . 
	and 004h		;3227	e6 04 	. . 
	jr z,$+11		;3229	28 09 	( . 
	ld a,b			;322b	78 	x 
	cp 01eh		;322c	fe 1e 	. . 
	jr c,$+13		;322e	38 0b 	8 . 
	sub 01eh		;3230	d6 1e 	. . 
	jr $+9		;3232	18 07 	. . 
	ld a,b			;3234	78 	x 
	cp 018h		;3235	fe 18 	. . 
	jr c,$+4		;3237	38 02 	8 . 
	sub 018h		;3239	d6 18 	. . 
	out (01dh),a		;323b	d3 1d 	. . 
	ret			;323d	c9 	. 
	call 0330ah		;323e	cd 0a 33 	. . 3 
	ld a,b			;3241	78 	x 
	or c			;3242	b1 	. 
	jr nz,$+15		;3243	20 0d 	  . 
	ld a,(LNSIZE)		;3245	3a d4 e0 	: . . 
	ld d,a			;3248	57 	W 
	ld a,(LASTLN)		;3249	3a cd e0 	: . . 
	ld e,a			;324c	5f 	_ 
	call 031fbh		;324d	cd fb 31 	. . 1 
	jr $-18		;3250	18 ec 	. . 
	ld a,b			;3252	78 	x 
	and a			;3253	a7 	. 
	jr nz,$+7		;3254	20 05 	  . 
	call 0329bh		;3256	cd 9b 32 	. . 2 
	jr $+9		;3259	18 07 	. . 
	dec b			;325b	05 	. 
	dec hl			;325c	2b 	+ 
	dec hl			;325d	2b 	+ 
	dec ix		;325e	dd 2b 	. + 
	dec ix		;3260	dd 2b 	. + 
	ld a,(ix+000h)		;3262	dd 7e 00 	. ~ . 
	and 040h		;3265	e6 40 	. @ 
	jr nz,$+45		;3267	20 2b 	  + 
	ld a,(hl)			;3269	7e 	~ 
	and d			;326a	a2 	. 
	jr nz,$-25		;326b	20 e5 	  . 
	ld a,b			;326d	78 	x 
	and a			;326e	a7 	. 
	jr nz,$+7		;326f	20 05 	  . 
	call 0329bh		;3271	cd 9b 32 	. . 2 
	jr $+9		;3274	18 07 	. . 
	dec b			;3276	05 	. 
	dec hl			;3277	2b 	+ 
	dec hl			;3278	2b 	+ 
	dec ix		;3279	dd 2b 	. + 
	dec ix		;327b	dd 2b 	. + 
	ld a,(ix+000h)		;327d	dd 7e 00 	. ~ . 
	and 040h		;3280	e6 40 	. @ 
	jr nz,$+18		;3282	20 10 	  . 
	ld a,(hl)			;3284	7e 	~ 
	and d			;3285	a2 	. 
	jr z,$-25		;3286	28 e5 	( . 
	ld a,(LNSIZE)		;3288	3a d4 e0 	: . . 
	cp b			;328b	b8 	. 
	jr z,$+5		;328c	28 03 	( . 
	inc b			;328e	04 	. 
	jr $+5		;328f	18 03 	. . 
	inc c			;3291	0c 	. 
	ld b,000h		;3292	06 00 	. . 
	ld d,b			;3294	50 	P 
	ld e,c			;3295	59 	Y 
	call 031fbh		;3296	cd fb 31 	. . 1 
	jr $+105		;3299	18 67 	. g 
	xor a			;329b	af 	. 
	or c			;329c	b1 	. 
	jr z,$+97		;329d	28 5f 	( _ 
	dec c			;329f	0d 	. 
	ld e,c			;32a0	59 	Y 
	ld a,(LNSIZE)		;32a1	3a d4 e0 	: . . 
	ld d,a			;32a4	57 	W 
	call 031fbh		;32a5	cd fb 31 	. . 1 
	call 0330ah		;32a8	cd 0a 33 	. . 3 
	ret			;32ab	c9 	. 
	call 0330ah		;32ac	cd 0a 33 	. . 3 
	jr $+27		;32af	18 19 	. . 
	ld a,(LNSIZE)		;32b1	3a d4 e0 	: . . 
	cp b			;32b4	b8 	. 
	jr nz,$+7		;32b5	20 05 	  . 
	call 032edh		;32b7	cd ed 32 	. . 2 
	jr $+9		;32ba	18 07 	. . 
	inc b			;32bc	04 	. 
	inc hl			;32bd	23 	# 
	inc hl			;32be	23 	# 
	inc ix		;32bf	dd 23 	. # 
	inc ix		;32c1	dd 23 	. # 
	ld a,(ix+000h)		;32c3	dd 7e 00 	. ~ . 
	and 040h		;32c6	e6 40 	. @ 
	jr nz,$-52		;32c8	20 ca 	  . 
	ld a,(hl)			;32ca	7e 	~ 
	and d			;32cb	a2 	. 
	jr z,$-27		;32cc	28 e3 	( . 
	ld a,(LNSIZE)		;32ce	3a d4 e0 	: . . 
	cp b			;32d1	b8 	. 
	jr nz,$+7		;32d2	20 05 	  . 
	call 032edh		;32d4	cd ed 32 	. . 2 
	jr $+9		;32d7	18 07 	. . 
	inc b			;32d9	04 	. 
	inc hl			;32da	23 	# 
	inc hl			;32db	23 	# 
	inc ix		;32dc	dd 23 	. # 
	inc ix		;32de	dd 23 	. # 
	ld a,(ix+000h)		;32e0	dd 7e 00 	. ~ . 
	and 040h		;32e3	e6 40 	. @ 
	jr nz,$-81		;32e5	20 ad 	  . 
	ld a,(hl)			;32e7	7e 	~ 
	and d			;32e8	a2 	. 
	jr nz,$-27		;32e9	20 e3 	  . 
	jr $-87		;32eb	18 a7 	. . 
	ld a,(LASTLN)		;32ed	3a cd e0 	: . . 
	cp c			;32f0	b9 	. 
	jr z,$+13		;32f1	28 0b 	( . 
	inc c			;32f3	0c 	. 
	ld e,c			;32f4	59 	Y 
	ld d,000h		;32f5	16 00 	. . 
	call 031fbh		;32f7	cd fb 31 	. . 1 
	call 0330ah		;32fa	cd 0a 33 	. . 3 
	ret			;32fd	c9 	. 
	call 021fah		;32fe	cd fa 21 	. . ! 
	pop hl			;3301	e1 	. 
	ld a,(TIPE)		;3302	3a ee e0 	: . . 
	and a			;3305	a7 	. 
	ret nz			;3306	c0 	. 
	jp 01666h		;3307	c3 66 16 	. f . 
	ld a,(CHRCNT)		;330a	3a b1 e0 	: . . 
	ld b,a			;330d	47 	G 
	ld e,a			;330e	5f 	_ 
	ld d,000h		;330f	16 00 	. . 
	ld ix,0d900h		;3311	dd 21 00 d9 	. ! . . 
	add ix,de		;3315	dd 19 	. . 
	add ix,de		;3317	dd 19 	. . 
	inc ix		;3319	dd 23 	. # 
	ld hl,(CURSOR)		;331b	2a b7 e0 	* . . 
	inc hl			;331e	23 	# 
	ld a,(LNCNT)		;331f	3a d1 e0 	: . . 
	ld c,a			;3322	4f 	O 
	ld a,(PROTE)		;3323	3a de e0 	: . . 
	rra			;3326	1f 	. 
	jr c,$+5		;3327	38 03 	8 . 
	ld d,010h		;3329	16 10 	. . 
	ret			;332b	c9 	. 
	ld d,080h		;332c	16 80 	. . 
	ret			;332e	c9 	. 
	ld c,057h		;332f	0e 57 	. W 
	call 01d8dh		;3331	cd 8d 1d 	. . . 
	ret			;3334	c9 	. 
	ld c,058h		;3335	0e 58 	. X 
	call 01d8dh		;3337	cd 8d 1d 	. . . 
	ret			;333a	c9 	. 
	ld hl,0d900h		;333b	21 00 d9 	! . . 
	inc hl			;333e	23 	# 
	ld a,(LNSIZE)		;333f	3a d4 e0 	: . . 
	ld b,a			;3342	47 	G 
	call 03368h		;3343	cd 68 33 	. h 3 
	inc hl			;3346	23 	# 
	inc hl			;3347	23 	# 
	djnz $-5		;3348	10 f9 	. . 
	ret			;334a	c9 	. 
	ld a,001h		;334b	3e 01 	> . 
	ld (TABST),a		;334d	32 ed e0 	2 . . 
	jr $+6		;3350	18 04 	. . 
	xor a			;3352	af 	. 
	ld (TABST),a		;3353	32 ed e0 	2 . . 
	ld a,(CHRCNT)		;3356	3a b1 e0 	: . . 
	ld e,a			;3359	5f 	_ 
	ld d,000h		;335a	16 00 	. . 
	ld hl,0d900h		;335c	21 00 d9 	! . . 
	add hl,de			;335f	19 	. 
	add hl,de			;3360	19 	. 
	inc hl			;3361	23 	# 
	ld a,(TABST)		;3362	3a ed e0 	: . . 
	rra			;3365	1f 	. 
	jr c,$+7		;3366	38 05 	8 . 
	ld a,(hl)			;3368	7e 	~ 
	and 0bfh		;3369	e6 bf 	. . 
	jr $+5		;336b	18 03 	. . 
	ld a,(hl)			;336d	7e 	~ 
	or 040h		;336e	f6 40 	. @ 
	ld (hl),a			;3370	77 	w 
	ret			;3371	c9 	. 
	ld a,(BLKMD)		;3372	3a ab e0 	: . . 
	and a			;3375	a7 	. 
	ret z			;3376	c8 	. 
	ld a,(KBINP)		;3377	3a c9 e0 	: . . 
	and a			;337a	a7 	. 
	ret			;337b	c9 	. 
	ld a,(PROTE)		;337c	3a de e0 	: . . 
	and a			;337f	a7 	. 
	ret z			;3380	c8 	. 
	ld hl,(CURSOR)		;3381	2a b7 e0 	* . . 
	inc hl			;3384	23 	# 
	ld a,(hl)			;3385	7e 	~ 
	and 080h		;3386	e6 80 	. . 
	ret			;3388	c9 	. 
	nop			;3389	00 	. 
	nop			;338a	00 	. 
	nop			;338b	00 	. 
	nop			;338c	00 	. 
	nop			;338d	00 	. 
	nop			;338e	00 	. 
	nop			;338f	00 	. 
	nop			;3390	00 	. 
	nop			;3391	00 	. 
	nop			;3392	00 	. 
	nop			;3393	00 	. 
	nop			;3394	00 	. 
	nop			;3395	00 	. 
	nop			;3396	00 	. 
	nop			;3397	00 	. 
	nop			;3398	00 	. 
	nop			;3399	00 	. 
	nop			;339a	00 	. 
	nop			;339b	00 	. 
	nop			;339c	00 	. 
	nop			;339d	00 	. 
	nop			;339e	00 	. 
	nop			;339f	00 	. 
	nop			;33a0	00 	. 
	nop			;33a1	00 	. 
	nop			;33a2	00 	. 
	nop			;33a3	00 	. 
	nop			;33a4	00 	. 
	nop			;33a5	00 	. 
	nop			;33a6	00 	. 
	nop			;33a7	00 	. 
	nop			;33a8	00 	. 
	nop			;33a9	00 	. 
	nop			;33aa	00 	. 
	nop			;33ab	00 	. 
	nop			;33ac	00 	. 
	nop			;33ad	00 	. 
	nop			;33ae	00 	. 
	nop			;33af	00 	. 
	nop			;33b0	00 	. 
	nop			;33b1	00 	. 
	nop			;33b2	00 	. 
	nop			;33b3	00 	. 
	nop			;33b4	00 	. 
	nop			;33b5	00 	. 
	nop			;33b6	00 	. 
	nop			;33b7	00 	. 
	nop			;33b8	00 	. 
	nop			;33b9	00 	. 
	nop			;33ba	00 	. 
	nop			;33bb	00 	. 
	nop			;33bc	00 	. 
	nop			;33bd	00 	. 
	nop			;33be	00 	. 
	nop			;33bf	00 	. 
	nop			;33c0	00 	. 
	nop			;33c1	00 	. 
	nop			;33c2	00 	. 
	nop			;33c3	00 	. 
	nop			;33c4	00 	. 
	nop			;33c5	00 	. 
	nop			;33c6	00 	. 
	nop			;33c7	00 	. 
	nop			;33c8	00 	. 
	nop			;33c9	00 	. 
	nop			;33ca	00 	. 
	nop			;33cb	00 	. 
	nop			;33cc	00 	. 
	nop			;33cd	00 	. 
	nop			;33ce	00 	. 
	nop			;33cf	00 	. 
	nop			;33d0	00 	. 
	nop			;33d1	00 	. 
	nop			;33d2	00 	. 
	nop			;33d3	00 	. 
	nop			;33d4	00 	. 
	nop			;33d5	00 	. 
	nop			;33d6	00 	. 
	nop			;33d7	00 	. 
	nop			;33d8	00 	. 
	nop			;33d9	00 	. 
	nop			;33da	00 	. 
	nop			;33db	00 	. 
	nop			;33dc	00 	. 
	nop			;33dd	00 	. 
	nop			;33de	00 	. 
	nop			;33df	00 	. 
	nop			;33e0	00 	. 
	nop			;33e1	00 	. 
	nop			;33e2	00 	. 
	nop			;33e3	00 	. 
	nop			;33e4	00 	. 
	nop			;33e5	00 	. 
	nop			;33e6	00 	. 
	nop			;33e7	00 	. 
	nop			;33e8	00 	. 
	nop			;33e9	00 	. 
	nop			;33ea	00 	. 
	nop			;33eb	00 	. 
	nop			;33ec	00 	. 
	nop			;33ed	00 	. 
	nop			;33ee	00 	. 
	nop			;33ef	00 	. 
	nop			;33f0	00 	. 
	nop			;33f1	00 	. 
	nop			;33f2	00 	. 
	nop			;33f3	00 	. 
	nop			;33f4	00 	. 
	nop			;33f5	00 	. 
	nop			;33f6	00 	. 
	nop			;33f7	00 	. 
	nop			;33f8	00 	. 
	nop			;33f9	00 	. 
	nop			;33fa	00 	. 
	nop			;33fb	00 	. 
	nop			;33fc	00 	. 
	nop			;33fd	00 	. 
	nop			;33fe	00 	. 
	nop			;33ff	00 	. 
	nop			;3400	00 	. 
	nop			;3401	00 	. 
	nop			;3402	00 	. 
	nop			;3403	00 	. 
	nop			;3404	00 	. 
	nop			;3405	00 	. 
	nop			;3406	00 	. 
	nop			;3407	00 	. 
	nop			;3408	00 	. 
	nop			;3409	00 	. 
	nop			;340a	00 	. 
	nop			;340b	00 	. 
	nop			;340c	00 	. 
	nop			;340d	00 	. 
	nop			;340e	00 	. 
	nop			;340f	00 	. 
	nop			;3410	00 	. 
	nop			;3411	00 	. 
	nop			;3412	00 	. 
	nop			;3413	00 	. 
	nop			;3414	00 	. 
	nop			;3415	00 	. 
	nop			;3416	00 	. 
	nop			;3417	00 	. 
	nop			;3418	00 	. 
	nop			;3419	00 	. 
	nop			;341a	00 	. 
	nop			;341b	00 	. 
	nop			;341c	00 	. 
	nop			;341d	00 	. 
	nop			;341e	00 	. 
	nop			;341f	00 	. 
	nop			;3420	00 	. 
	nop			;3421	00 	. 
	nop			;3422	00 	. 
	nop			;3423	00 	. 
	nop			;3424	00 	. 
	nop			;3425	00 	. 
	nop			;3426	00 	. 
	nop			;3427	00 	. 
	nop			;3428	00 	. 
	nop			;3429	00 	. 
	nop			;342a	00 	. 
	nop			;342b	00 	. 
	nop			;342c	00 	. 
	nop			;342d	00 	. 
	nop			;342e	00 	. 
	nop			;342f	00 	. 
	nop			;3430	00 	. 
	nop			;3431	00 	. 
	nop			;3432	00 	. 
	nop			;3433	00 	. 
	nop			;3434	00 	. 
	nop			;3435	00 	. 
	nop			;3436	00 	. 
	nop			;3437	00 	. 
	nop			;3438	00 	. 
	nop			;3439	00 	. 
	nop			;343a	00 	. 
	nop			;343b	00 	. 
	nop			;343c	00 	. 
	nop			;343d	00 	. 
	nop			;343e	00 	. 
	nop			;343f	00 	. 
	nop			;3440	00 	. 
	nop			;3441	00 	. 
	nop			;3442	00 	. 
	nop			;3443	00 	. 
	nop			;3444	00 	. 
	nop			;3445	00 	. 
	nop			;3446	00 	. 
	nop			;3447	00 	. 
	nop			;3448	00 	. 
	nop			;3449	00 	. 
	nop			;344a	00 	. 
	nop			;344b	00 	. 
	nop			;344c	00 	. 
	nop			;344d	00 	. 
	nop			;344e	00 	. 
	nop			;344f	00 	. 
	nop			;3450	00 	. 
	nop			;3451	00 	. 
	nop			;3452	00 	. 
	nop			;3453	00 	. 
	nop			;3454	00 	. 
	nop			;3455	00 	. 
	nop			;3456	00 	. 
	nop			;3457	00 	. 
	nop			;3458	00 	. 
	nop			;3459	00 	. 
	nop			;345a	00 	. 
	nop			;345b	00 	. 
	nop			;345c	00 	. 
	nop			;345d	00 	. 
	nop			;345e	00 	. 
	nop			;345f	00 	. 
	nop			;3460	00 	. 
	nop			;3461	00 	. 
	nop			;3462	00 	. 
	nop			;3463	00 	. 
	nop			;3464	00 	. 
	nop			;3465	00 	. 
	nop			;3466	00 	. 
	nop			;3467	00 	. 
	nop			;3468	00 	. 
	nop			;3469	00 	. 
	nop			;346a	00 	. 
	nop			;346b	00 	. 
	nop			;346c	00 	. 
	nop			;346d	00 	. 
	nop			;346e	00 	. 
	nop			;346f	00 	. 
	nop			;3470	00 	. 
	nop			;3471	00 	. 
	nop			;3472	00 	. 
	nop			;3473	00 	. 
	nop			;3474	00 	. 
	nop			;3475	00 	. 
	nop			;3476	00 	. 
	nop			;3477	00 	. 
	nop			;3478	00 	. 
	nop			;3479	00 	. 
	nop			;347a	00 	. 
	nop			;347b	00 	. 
	nop			;347c	00 	. 
	nop			;347d	00 	. 
	nop			;347e	00 	. 
	nop			;347f	00 	. 
	nop			;3480	00 	. 
	nop			;3481	00 	. 
	nop			;3482	00 	. 
	nop			;3483	00 	. 
	nop			;3484	00 	. 
	nop			;3485	00 	. 
	nop			;3486	00 	. 
	nop			;3487	00 	. 
	nop			;3488	00 	. 
	nop			;3489	00 	. 
	nop			;348a	00 	. 
	nop			;348b	00 	. 
	nop			;348c	00 	. 
	nop			;348d	00 	. 
	nop			;348e	00 	. 
	nop			;348f	00 	. 
	nop			;3490	00 	. 
	nop			;3491	00 	. 
	nop			;3492	00 	. 
	nop			;3493	00 	. 
	nop			;3494	00 	. 
	nop			;3495	00 	. 
	nop			;3496	00 	. 
	nop			;3497	00 	. 
	nop			;3498	00 	. 
	nop			;3499	00 	. 
	nop			;349a	00 	. 
	nop			;349b	00 	. 
	nop			;349c	00 	. 
	nop			;349d	00 	. 
	nop			;349e	00 	. 
	nop			;349f	00 	. 
	nop			;34a0	00 	. 
	nop			;34a1	00 	. 
	nop			;34a2	00 	. 
	nop			;34a3	00 	. 
	nop			;34a4	00 	. 
	nop			;34a5	00 	. 
	nop			;34a6	00 	. 
	nop			;34a7	00 	. 
	nop			;34a8	00 	. 
	nop			;34a9	00 	. 
	nop			;34aa	00 	. 
	nop			;34ab	00 	. 
	nop			;34ac	00 	. 
	nop			;34ad	00 	. 
	nop			;34ae	00 	. 
	nop			;34af	00 	. 
	nop			;34b0	00 	. 
	nop			;34b1	00 	. 
	nop			;34b2	00 	. 
	nop			;34b3	00 	. 
	nop			;34b4	00 	. 
	nop			;34b5	00 	. 
	nop			;34b6	00 	. 
	nop			;34b7	00 	. 
	nop			;34b8	00 	. 
	nop			;34b9	00 	. 
	nop			;34ba	00 	. 
	nop			;34bb	00 	. 
	nop			;34bc	00 	. 
	nop			;34bd	00 	. 
	nop			;34be	00 	. 
	nop			;34bf	00 	. 
	nop			;34c0	00 	. 
	nop			;34c1	00 	. 
	nop			;34c2	00 	. 
	nop			;34c3	00 	. 
	nop			;34c4	00 	. 
	nop			;34c5	00 	. 
	nop			;34c6	00 	. 
	nop			;34c7	00 	. 
	nop			;34c8	00 	. 
	nop			;34c9	00 	. 
	nop			;34ca	00 	. 
	nop			;34cb	00 	. 
	nop			;34cc	00 	. 
	nop			;34cd	00 	. 
	nop			;34ce	00 	. 
	nop			;34cf	00 	. 
	nop			;34d0	00 	. 
	nop			;34d1	00 	. 
	nop			;34d2	00 	. 
	nop			;34d3	00 	. 
	nop			;34d4	00 	. 
	nop			;34d5	00 	. 
	nop			;34d6	00 	. 
	nop			;34d7	00 	. 
	nop			;34d8	00 	. 
	nop			;34d9	00 	. 
	nop			;34da	00 	. 
	nop			;34db	00 	. 
	nop			;34dc	00 	. 
	nop			;34dd	00 	. 
	nop			;34de	00 	. 
	nop			;34df	00 	. 
	nop			;34e0	00 	. 
	nop			;34e1	00 	. 
	nop			;34e2	00 	. 
	nop			;34e3	00 	. 
	nop			;34e4	00 	. 
	nop			;34e5	00 	. 
	nop			;34e6	00 	. 
	nop			;34e7	00 	. 
	nop			;34e8	00 	. 
	nop			;34e9	00 	. 
	nop			;34ea	00 	. 
	nop			;34eb	00 	. 
	nop			;34ec	00 	. 
	nop			;34ed	00 	. 
	nop			;34ee	00 	. 
	nop			;34ef	00 	. 
	nop			;34f0	00 	. 
	nop			;34f1	00 	. 
	nop			;34f2	00 	. 
	nop			;34f3	00 	. 
	nop			;34f4	00 	. 
	nop			;34f5	00 	. 
	nop			;34f6	00 	. 
	nop			;34f7	00 	. 
	nop			;34f8	00 	. 
	nop			;34f9	00 	. 
	nop			;34fa	00 	. 
	nop			;34fb	00 	. 
	nop			;34fc	00 	. 
	nop			;34fd	00 	. 
	nop			;34fe	00 	. 
	nop			;34ff	00 	. 
	nop			;3500	00 	. 
	nop			;3501	00 	. 
	nop			;3502	00 	. 
	nop			;3503	00 	. 
	nop			;3504	00 	. 
	nop			;3505	00 	. 
	nop			;3506	00 	. 
	nop			;3507	00 	. 
	nop			;3508	00 	. 
	nop			;3509	00 	. 
	nop			;350a	00 	. 
	nop			;350b	00 	. 
	nop			;350c	00 	. 
	nop			;350d	00 	. 
	nop			;350e	00 	. 
	nop			;350f	00 	. 
	nop			;3510	00 	. 
	nop			;3511	00 	. 
	nop			;3512	00 	. 
	nop			;3513	00 	. 
	nop			;3514	00 	. 
	nop			;3515	00 	. 
	nop			;3516	00 	. 
	nop			;3517	00 	. 
	nop			;3518	00 	. 
	nop			;3519	00 	. 
	nop			;351a	00 	. 
	nop			;351b	00 	. 
	nop			;351c	00 	. 
	nop			;351d	00 	. 
	nop			;351e	00 	. 
	nop			;351f	00 	. 
	nop			;3520	00 	. 
	nop			;3521	00 	. 
	nop			;3522	00 	. 
	nop			;3523	00 	. 
	nop			;3524	00 	. 
	nop			;3525	00 	. 
	nop			;3526	00 	. 
	nop			;3527	00 	. 
	nop			;3528	00 	. 
	nop			;3529	00 	. 
	nop			;352a	00 	. 
	nop			;352b	00 	. 
	nop			;352c	00 	. 
	nop			;352d	00 	. 
	nop			;352e	00 	. 
	nop			;352f	00 	. 
	nop			;3530	00 	. 
	nop			;3531	00 	. 
	nop			;3532	00 	. 
	nop			;3533	00 	. 
	nop			;3534	00 	. 
	nop			;3535	00 	. 
	nop			;3536	00 	. 
	nop			;3537	00 	. 
	nop			;3538	00 	. 
	nop			;3539	00 	. 
	nop			;353a	00 	. 
	nop			;353b	00 	. 
	nop			;353c	00 	. 
	nop			;353d	00 	. 
	nop			;353e	00 	. 
	nop			;353f	00 	. 
	nop			;3540	00 	. 
	nop			;3541	00 	. 
	nop			;3542	00 	. 
	nop			;3543	00 	. 
	nop			;3544	00 	. 
	nop			;3545	00 	. 
	nop			;3546	00 	. 
	nop			;3547	00 	. 
	nop			;3548	00 	. 
	nop			;3549	00 	. 
	nop			;354a	00 	. 
	nop			;354b	00 	. 
	nop			;354c	00 	. 
	nop			;354d	00 	. 
	nop			;354e	00 	. 
	nop			;354f	00 	. 
	nop			;3550	00 	. 
	nop			;3551	00 	. 
	nop			;3552	00 	. 
	nop			;3553	00 	. 
	nop			;3554	00 	. 
	nop			;3555	00 	. 
	nop			;3556	00 	. 
	nop			;3557	00 	. 
	nop			;3558	00 	. 
	nop			;3559	00 	. 
	nop			;355a	00 	. 
	nop			;355b	00 	. 
	nop			;355c	00 	. 
	nop			;355d	00 	. 
	nop			;355e	00 	. 
	nop			;355f	00 	. 
	nop			;3560	00 	. 
	nop			;3561	00 	. 
	nop			;3562	00 	. 
	nop			;3563	00 	. 
	nop			;3564	00 	. 
	nop			;3565	00 	. 
	nop			;3566	00 	. 
	nop			;3567	00 	. 
	nop			;3568	00 	. 
	nop			;3569	00 	. 
	nop			;356a	00 	. 
	nop			;356b	00 	. 
	nop			;356c	00 	. 
	nop			;356d	00 	. 
	nop			;356e	00 	. 
	nop			;356f	00 	. 
	nop			;3570	00 	. 
	nop			;3571	00 	. 
	nop			;3572	00 	. 
	nop			;3573	00 	. 
	nop			;3574	00 	. 
	nop			;3575	00 	. 
	nop			;3576	00 	. 
	nop			;3577	00 	. 
	nop			;3578	00 	. 
	nop			;3579	00 	. 
	nop			;357a	00 	. 
	nop			;357b	00 	. 
	nop			;357c	00 	. 
	nop			;357d	00 	. 
	nop			;357e	00 	. 
	nop			;357f	00 	. 
	nop			;3580	00 	. 
	nop			;3581	00 	. 
	nop			;3582	00 	. 
	nop			;3583	00 	. 
	nop			;3584	00 	. 
	nop			;3585	00 	. 
	nop			;3586	00 	. 
	nop			;3587	00 	. 
	nop			;3588	00 	. 
	nop			;3589	00 	. 
	nop			;358a	00 	. 
	nop			;358b	00 	. 
	nop			;358c	00 	. 
	nop			;358d	00 	. 
	nop			;358e	00 	. 
	nop			;358f	00 	. 
	nop			;3590	00 	. 
	nop			;3591	00 	. 
	nop			;3592	00 	. 
	nop			;3593	00 	. 
	nop			;3594	00 	. 
	nop			;3595	00 	. 
	nop			;3596	00 	. 
	nop			;3597	00 	. 
	nop			;3598	00 	. 
	nop			;3599	00 	. 
	nop			;359a	00 	. 
	nop			;359b	00 	. 
	nop			;359c	00 	. 
	nop			;359d	00 	. 
	nop			;359e	00 	. 
	nop			;359f	00 	. 
	nop			;35a0	00 	. 
	nop			;35a1	00 	. 
	nop			;35a2	00 	. 
	nop			;35a3	00 	. 
	nop			;35a4	00 	. 
	nop			;35a5	00 	. 
	nop			;35a6	00 	. 
	nop			;35a7	00 	. 
	nop			;35a8	00 	. 
	nop			;35a9	00 	. 
	nop			;35aa	00 	. 
	nop			;35ab	00 	. 
	nop			;35ac	00 	. 
	nop			;35ad	00 	. 
	nop			;35ae	00 	. 
	nop			;35af	00 	. 
	nop			;35b0	00 	. 
	nop			;35b1	00 	. 
	nop			;35b2	00 	. 
	nop			;35b3	00 	. 
	nop			;35b4	00 	. 
	nop			;35b5	00 	. 
	nop			;35b6	00 	. 
	nop			;35b7	00 	. 
	nop			;35b8	00 	. 
	nop			;35b9	00 	. 
	nop			;35ba	00 	. 
	nop			;35bb	00 	. 
	nop			;35bc	00 	. 
	nop			;35bd	00 	. 
	nop			;35be	00 	. 
	nop			;35bf	00 	. 
	nop			;35c0	00 	. 
	nop			;35c1	00 	. 
	nop			;35c2	00 	. 
	nop			;35c3	00 	. 
	nop			;35c4	00 	. 
	nop			;35c5	00 	. 
	nop			;35c6	00 	. 
	nop			;35c7	00 	. 
	nop			;35c8	00 	. 
	nop			;35c9	00 	. 
	nop			;35ca	00 	. 
	nop			;35cb	00 	. 
	nop			;35cc	00 	. 
	nop			;35cd	00 	. 
	nop			;35ce	00 	. 
	nop			;35cf	00 	. 
	nop			;35d0	00 	. 
	nop			;35d1	00 	. 
	nop			;35d2	00 	. 
	nop			;35d3	00 	. 
	nop			;35d4	00 	. 
	nop			;35d5	00 	. 
	nop			;35d6	00 	. 
	nop			;35d7	00 	. 
	nop			;35d8	00 	. 
	nop			;35d9	00 	. 
	nop			;35da	00 	. 
	nop			;35db	00 	. 
	nop			;35dc	00 	. 
	nop			;35dd	00 	. 
	nop			;35de	00 	. 
	nop			;35df	00 	. 
	nop			;35e0	00 	. 
	nop			;35e1	00 	. 
	nop			;35e2	00 	. 
	nop			;35e3	00 	. 
	nop			;35e4	00 	. 
	nop			;35e5	00 	. 
	nop			;35e6	00 	. 
	nop			;35e7	00 	. 
	nop			;35e8	00 	. 
	nop			;35e9	00 	. 
	nop			;35ea	00 	. 
	nop			;35eb	00 	. 
	nop			;35ec	00 	. 
	nop			;35ed	00 	. 
	nop			;35ee	00 	. 
	nop			;35ef	00 	. 
	nop			;35f0	00 	. 
	nop			;35f1	00 	. 
	nop			;35f2	00 	. 
	nop			;35f3	00 	. 
	nop			;35f4	00 	. 
	nop			;35f5	00 	. 
	nop			;35f6	00 	. 
	nop			;35f7	00 	. 
	nop			;35f8	00 	. 
	nop			;35f9	00 	. 
	nop			;35fa	00 	. 
	nop			;35fb	00 	. 
	nop			;35fc	00 	. 
	nop			;35fd	00 	. 
	nop			;35fe	00 	. 
	nop			;35ff	00 	. 
	nop			;3600	00 	. 
	nop			;3601	00 	. 
	nop			;3602	00 	. 
	nop			;3603	00 	. 
	nop			;3604	00 	. 
	nop			;3605	00 	. 
	nop			;3606	00 	. 
	nop			;3607	00 	. 
	nop			;3608	00 	. 
	nop			;3609	00 	. 
	nop			;360a	00 	. 
	nop			;360b	00 	. 
	nop			;360c	00 	. 
	nop			;360d	00 	. 
	nop			;360e	00 	. 
	nop			;360f	00 	. 
	nop			;3610	00 	. 
	nop			;3611	00 	. 
	nop			;3612	00 	. 
	nop			;3613	00 	. 
	nop			;3614	00 	. 
	nop			;3615	00 	. 
	nop			;3616	00 	. 
	nop			;3617	00 	. 
	nop			;3618	00 	. 
	nop			;3619	00 	. 
	nop			;361a	00 	. 
	nop			;361b	00 	. 
	nop			;361c	00 	. 
	nop			;361d	00 	. 
	nop			;361e	00 	. 
	nop			;361f	00 	. 
	nop			;3620	00 	. 
	nop			;3621	00 	. 
	nop			;3622	00 	. 
	nop			;3623	00 	. 
	nop			;3624	00 	. 
	nop			;3625	00 	. 
	nop			;3626	00 	. 
	nop			;3627	00 	. 
	nop			;3628	00 	. 
	nop			;3629	00 	. 
	nop			;362a	00 	. 
	nop			;362b	00 	. 
	nop			;362c	00 	. 
	nop			;362d	00 	. 
	nop			;362e	00 	. 
	nop			;362f	00 	. 
	nop			;3630	00 	. 
	nop			;3631	00 	. 
	nop			;3632	00 	. 
	nop			;3633	00 	. 
	nop			;3634	00 	. 
	nop			;3635	00 	. 
	nop			;3636	00 	. 
	nop			;3637	00 	. 
	nop			;3638	00 	. 
	nop			;3639	00 	. 
	nop			;363a	00 	. 
	nop			;363b	00 	. 
	nop			;363c	00 	. 
	nop			;363d	00 	. 
	nop			;363e	00 	. 
	nop			;363f	00 	. 
	nop			;3640	00 	. 
	nop			;3641	00 	. 
	nop			;3642	00 	. 
	nop			;3643	00 	. 
	nop			;3644	00 	. 
	nop			;3645	00 	. 
	nop			;3646	00 	. 
	nop			;3647	00 	. 
	nop			;3648	00 	. 
	nop			;3649	00 	. 
	nop			;364a	00 	. 
	nop			;364b	00 	. 
	nop			;364c	00 	. 
	nop			;364d	00 	. 
	nop			;364e	00 	. 
	nop			;364f	00 	. 
	nop			;3650	00 	. 
	nop			;3651	00 	. 
	nop			;3652	00 	. 
	nop			;3653	00 	. 
	nop			;3654	00 	. 
	nop			;3655	00 	. 
	nop			;3656	00 	. 
	nop			;3657	00 	. 
	nop			;3658	00 	. 
	nop			;3659	00 	. 
	nop			;365a	00 	. 
	nop			;365b	00 	. 
	nop			;365c	00 	. 
	nop			;365d	00 	. 
	nop			;365e	00 	. 
	nop			;365f	00 	. 
	nop			;3660	00 	. 
	nop			;3661	00 	. 
	nop			;3662	00 	. 
	nop			;3663	00 	. 
	nop			;3664	00 	. 
	nop			;3665	00 	. 
	nop			;3666	00 	. 
	nop			;3667	00 	. 
	nop			;3668	00 	. 
	nop			;3669	00 	. 
	nop			;366a	00 	. 
	nop			;366b	00 	. 
	nop			;366c	00 	. 
	nop			;366d	00 	. 
	nop			;366e	00 	. 
	nop			;366f	00 	. 
	nop			;3670	00 	. 
	nop			;3671	00 	. 
	nop			;3672	00 	. 
	nop			;3673	00 	. 
	nop			;3674	00 	. 
	nop			;3675	00 	. 
	nop			;3676	00 	. 
	nop			;3677	00 	. 
	nop			;3678	00 	. 
	nop			;3679	00 	. 
	nop			;367a	00 	. 
	nop			;367b	00 	. 
	nop			;367c	00 	. 
	nop			;367d	00 	. 
	nop			;367e	00 	. 
	nop			;367f	00 	. 
	nop			;3680	00 	. 
	nop			;3681	00 	. 
	nop			;3682	00 	. 
	nop			;3683	00 	. 
	nop			;3684	00 	. 
	nop			;3685	00 	. 
	nop			;3686	00 	. 
	nop			;3687	00 	. 
	nop			;3688	00 	. 
	nop			;3689	00 	. 
	nop			;368a	00 	. 
	nop			;368b	00 	. 
	nop			;368c	00 	. 
	nop			;368d	00 	. 
	nop			;368e	00 	. 
	nop			;368f	00 	. 
	nop			;3690	00 	. 
	nop			;3691	00 	. 
	nop			;3692	00 	. 
	nop			;3693	00 	. 
	nop			;3694	00 	. 
	nop			;3695	00 	. 
	nop			;3696	00 	. 
	nop			;3697	00 	. 
	nop			;3698	00 	. 
	nop			;3699	00 	. 
	nop			;369a	00 	. 
	nop			;369b	00 	. 
	nop			;369c	00 	. 
	nop			;369d	00 	. 
	nop			;369e	00 	. 
	nop			;369f	00 	. 
	nop			;36a0	00 	. 
	nop			;36a1	00 	. 
	nop			;36a2	00 	. 
	nop			;36a3	00 	. 
	nop			;36a4	00 	. 
	nop			;36a5	00 	. 
	nop			;36a6	00 	. 
	nop			;36a7	00 	. 
	nop			;36a8	00 	. 
	nop			;36a9	00 	. 
	nop			;36aa	00 	. 
	nop			;36ab	00 	. 
	nop			;36ac	00 	. 
	nop			;36ad	00 	. 
	nop			;36ae	00 	. 
	nop			;36af	00 	. 
	nop			;36b0	00 	. 
	nop			;36b1	00 	. 
	nop			;36b2	00 	. 
	nop			;36b3	00 	. 
	nop			;36b4	00 	. 
	nop			;36b5	00 	. 
	nop			;36b6	00 	. 
	nop			;36b7	00 	. 
	nop			;36b8	00 	. 
	nop			;36b9	00 	. 
	nop			;36ba	00 	. 
	nop			;36bb	00 	. 
	nop			;36bc	00 	. 
	nop			;36bd	00 	. 
	nop			;36be	00 	. 
	nop			;36bf	00 	. 
	nop			;36c0	00 	. 
	nop			;36c1	00 	. 
	nop			;36c2	00 	. 
	nop			;36c3	00 	. 
	nop			;36c4	00 	. 
	nop			;36c5	00 	. 
	nop			;36c6	00 	. 
	nop			;36c7	00 	. 
	nop			;36c8	00 	. 
	nop			;36c9	00 	. 
	nop			;36ca	00 	. 
	nop			;36cb	00 	. 
	nop			;36cc	00 	. 
	nop			;36cd	00 	. 
	nop			;36ce	00 	. 
	nop			;36cf	00 	. 
	nop			;36d0	00 	. 
	nop			;36d1	00 	. 
	nop			;36d2	00 	. 
	nop			;36d3	00 	. 
	nop			;36d4	00 	. 
	nop			;36d5	00 	. 
	nop			;36d6	00 	. 
	nop			;36d7	00 	. 
	nop			;36d8	00 	. 
	nop			;36d9	00 	. 
	nop			;36da	00 	. 
	nop			;36db	00 	. 
	nop			;36dc	00 	. 
	nop			;36dd	00 	. 
	nop			;36de	00 	. 
	nop			;36df	00 	. 
	nop			;36e0	00 	. 
	nop			;36e1	00 	. 
	nop			;36e2	00 	. 
	nop			;36e3	00 	. 
	nop			;36e4	00 	. 
	nop			;36e5	00 	. 
	nop			;36e6	00 	. 
	nop			;36e7	00 	. 
	nop			;36e8	00 	. 
	nop			;36e9	00 	. 
	nop			;36ea	00 	. 
	nop			;36eb	00 	. 
	nop			;36ec	00 	. 
	nop			;36ed	00 	. 
	nop			;36ee	00 	. 
	nop			;36ef	00 	. 
	nop			;36f0	00 	. 
	nop			;36f1	00 	. 
	nop			;36f2	00 	. 
	nop			;36f3	00 	. 
	nop			;36f4	00 	. 
	nop			;36f5	00 	. 
	nop			;36f6	00 	. 
	nop			;36f7	00 	. 
	nop			;36f8	00 	. 
	nop			;36f9	00 	. 
	nop			;36fa	00 	. 
	nop			;36fb	00 	. 
	nop			;36fc	00 	. 
	nop			;36fd	00 	. 
	nop			;36fe	00 	. 
	nop			;36ff	00 	. 
	nop			;3700	00 	. 
	nop			;3701	00 	. 
	nop			;3702	00 	. 
	nop			;3703	00 	. 
	nop			;3704	00 	. 
	nop			;3705	00 	. 
	nop			;3706	00 	. 
	nop			;3707	00 	. 
	nop			;3708	00 	. 
	nop			;3709	00 	. 
	nop			;370a	00 	. 
	nop			;370b	00 	. 
	nop			;370c	00 	. 
	nop			;370d	00 	. 
	nop			;370e	00 	. 
	nop			;370f	00 	. 
	nop			;3710	00 	. 
	nop			;3711	00 	. 
	nop			;3712	00 	. 
	nop			;3713	00 	. 
	nop			;3714	00 	. 
	nop			;3715	00 	. 
	nop			;3716	00 	. 
	nop			;3717	00 	. 
	nop			;3718	00 	. 
	nop			;3719	00 	. 
	nop			;371a	00 	. 
	nop			;371b	00 	. 
	nop			;371c	00 	. 
	nop			;371d	00 	. 
	nop			;371e	00 	. 
	nop			;371f	00 	. 
	nop			;3720	00 	. 
	nop			;3721	00 	. 
	nop			;3722	00 	. 
	nop			;3723	00 	. 
	nop			;3724	00 	. 
	nop			;3725	00 	. 
	nop			;3726	00 	. 
	nop			;3727	00 	. 
	nop			;3728	00 	. 
	nop			;3729	00 	. 
	nop			;372a	00 	. 
	nop			;372b	00 	. 
	nop			;372c	00 	. 
	nop			;372d	00 	. 
	nop			;372e	00 	. 
	nop			;372f	00 	. 
	nop			;3730	00 	. 
	nop			;3731	00 	. 
	nop			;3732	00 	. 
	nop			;3733	00 	. 
	nop			;3734	00 	. 
	nop			;3735	00 	. 
	nop			;3736	00 	. 
	nop			;3737	00 	. 
	nop			;3738	00 	. 
	nop			;3739	00 	. 
	nop			;373a	00 	. 
	nop			;373b	00 	. 
	nop			;373c	00 	. 
	nop			;373d	00 	. 
	nop			;373e	00 	. 
	nop			;373f	00 	. 
	nop			;3740	00 	. 
	nop			;3741	00 	. 
	nop			;3742	00 	. 
	nop			;3743	00 	. 
	nop			;3744	00 	. 
	nop			;3745	00 	. 
	nop			;3746	00 	. 
	nop			;3747	00 	. 
	nop			;3748	00 	. 
	nop			;3749	00 	. 
	nop			;374a	00 	. 
	nop			;374b	00 	. 
	nop			;374c	00 	. 
	nop			;374d	00 	. 
	nop			;374e	00 	. 
	nop			;374f	00 	. 
	nop			;3750	00 	. 
	nop			;3751	00 	. 
	nop			;3752	00 	. 
	nop			;3753	00 	. 
	nop			;3754	00 	. 
	nop			;3755	00 	. 
	nop			;3756	00 	. 
	nop			;3757	00 	. 
	nop			;3758	00 	. 
	nop			;3759	00 	. 
	nop			;375a	00 	. 
	nop			;375b	00 	. 
	nop			;375c	00 	. 
	nop			;375d	00 	. 
	nop			;375e	00 	. 
	nop			;375f	00 	. 
	nop			;3760	00 	. 
	nop			;3761	00 	. 
	nop			;3762	00 	. 
	nop			;3763	00 	. 
	nop			;3764	00 	. 
	nop			;3765	00 	. 
	nop			;3766	00 	. 
	nop			;3767	00 	. 
	nop			;3768	00 	. 
	nop			;3769	00 	. 
	nop			;376a	00 	. 
	nop			;376b	00 	. 
	nop			;376c	00 	. 
	nop			;376d	00 	. 
	nop			;376e	00 	. 
	nop			;376f	00 	. 
	nop			;3770	00 	. 
	nop			;3771	00 	. 
	nop			;3772	00 	. 
	nop			;3773	00 	. 
	nop			;3774	00 	. 
	nop			;3775	00 	. 
	nop			;3776	00 	. 
	nop			;3777	00 	. 
	nop			;3778	00 	. 
	nop			;3779	00 	. 
	nop			;377a	00 	. 
	nop			;377b	00 	. 
	nop			;377c	00 	. 
	nop			;377d	00 	. 
	nop			;377e	00 	. 
	nop			;377f	00 	. 
	nop			;3780	00 	. 
	nop			;3781	00 	. 
	nop			;3782	00 	. 
	nop			;3783	00 	. 
	nop			;3784	00 	. 
	nop			;3785	00 	. 
	nop			;3786	00 	. 
	nop			;3787	00 	. 
	nop			;3788	00 	. 
	nop			;3789	00 	. 
	nop			;378a	00 	. 
	nop			;378b	00 	. 
	nop			;378c	00 	. 
	nop			;378d	00 	. 
	nop			;378e	00 	. 
	nop			;378f	00 	. 
	nop			;3790	00 	. 
	nop			;3791	00 	. 
	nop			;3792	00 	. 
	nop			;3793	00 	. 
	nop			;3794	00 	. 
	nop			;3795	00 	. 
	nop			;3796	00 	. 
	nop			;3797	00 	. 
	nop			;3798	00 	. 
	nop			;3799	00 	. 
	nop			;379a	00 	. 
	nop			;379b	00 	. 
	nop			;379c	00 	. 
	nop			;379d	00 	. 
	nop			;379e	00 	. 
	nop			;379f	00 	. 
	nop			;37a0	00 	. 
	nop			;37a1	00 	. 
	nop			;37a2	00 	. 
	nop			;37a3	00 	. 
	nop			;37a4	00 	. 
	nop			;37a5	00 	. 
	nop			;37a6	00 	. 
	nop			;37a7	00 	. 
	nop			;37a8	00 	. 
	nop			;37a9	00 	. 
	nop			;37aa	00 	. 
	nop			;37ab	00 	. 
	nop			;37ac	00 	. 
	nop			;37ad	00 	. 
	nop			;37ae	00 	. 
	nop			;37af	00 	. 
	nop			;37b0	00 	. 
	nop			;37b1	00 	. 
	nop			;37b2	00 	. 
	nop			;37b3	00 	. 
	nop			;37b4	00 	. 
	nop			;37b5	00 	. 
	nop			;37b6	00 	. 
	nop			;37b7	00 	. 
	nop			;37b8	00 	. 
	nop			;37b9	00 	. 
	nop			;37ba	00 	. 
	nop			;37bb	00 	. 
	nop			;37bc	00 	. 
	nop			;37bd	00 	. 
	nop			;37be	00 	. 
	nop			;37bf	00 	. 
	nop			;37c0	00 	. 
	nop			;37c1	00 	. 
	nop			;37c2	00 	. 
	nop			;37c3	00 	. 
	nop			;37c4	00 	. 
	nop			;37c5	00 	. 
	nop			;37c6	00 	. 
	nop			;37c7	00 	. 
	nop			;37c8	00 	. 
	nop			;37c9	00 	. 
	nop			;37ca	00 	. 
	nop			;37cb	00 	. 
	nop			;37cc	00 	. 
	nop			;37cd	00 	. 
	nop			;37ce	00 	. 
	nop			;37cf	00 	. 
	nop			;37d0	00 	. 
	nop			;37d1	00 	. 
	nop			;37d2	00 	. 
	nop			;37d3	00 	. 
	nop			;37d4	00 	. 
	nop			;37d5	00 	. 
	nop			;37d6	00 	. 
	nop			;37d7	00 	. 
	nop			;37d8	00 	. 
	nop			;37d9	00 	. 
	nop			;37da	00 	. 
	nop			;37db	00 	. 
	nop			;37dc	00 	. 
	nop			;37dd	00 	. 
	nop			;37de	00 	. 
	nop			;37df	00 	. 
	nop			;37e0	00 	. 
	nop			;37e1	00 	. 
	nop			;37e2	00 	. 
	nop			;37e3	00 	. 
	nop			;37e4	00 	. 
	nop			;37e5	00 	. 
	nop			;37e6	00 	. 
	nop			;37e7	00 	. 
	nop			;37e8	00 	. 
	nop			;37e9	00 	. 
	nop			;37ea	00 	. 
	nop			;37eb	00 	. 
	nop			;37ec	00 	. 
	nop			;37ed	00 	. 
	nop			;37ee	00 	. 
	nop			;37ef	00 	. 
	nop			;37f0	00 	. 
	nop			;37f1	00 	. 
	nop			;37f2	00 	. 
	nop			;37f3	00 	. 
	nop			;37f4	00 	. 
	nop			;37f5	00 	. 
	nop			;37f6	00 	. 
	nop			;37f7	00 	. 
	nop			;37f8	00 	. 
	nop			;37f9	00 	. 
	nop			;37fa	00 	. 
	nop			;37fb	00 	. 
	nop			;37fc	00 	. 
	nop			;37fd	00 	. 
	nop			;37fe	00 	. 
	nop			;37ff	00 	. 
	nop			;3800	00 	. 
	nop			;3801	00 	. 
	nop			;3802	00 	. 
	nop			;3803	00 	. 
	nop			;3804	00 	. 
	nop			;3805	00 	. 
	nop			;3806	00 	. 
	nop			;3807	00 	. 
	nop			;3808	00 	. 
	nop			;3809	00 	. 
	nop			;380a	00 	. 
	nop			;380b	00 	. 
	nop			;380c	00 	. 
	nop			;380d	00 	. 
	nop			;380e	00 	. 
	nop			;380f	00 	. 
	nop			;3810	00 	. 
	nop			;3811	00 	. 
	nop			;3812	00 	. 
	nop			;3813	00 	. 
	nop			;3814	00 	. 
	nop			;3815	00 	. 
	nop			;3816	00 	. 
	nop			;3817	00 	. 
	nop			;3818	00 	. 
	nop			;3819	00 	. 
	nop			;381a	00 	. 
	nop			;381b	00 	. 
	nop			;381c	00 	. 
	nop			;381d	00 	. 
	nop			;381e	00 	. 
	nop			;381f	00 	. 
	nop			;3820	00 	. 
	nop			;3821	00 	. 
	nop			;3822	00 	. 
	nop			;3823	00 	. 
	nop			;3824	00 	. 
	nop			;3825	00 	. 
	nop			;3826	00 	. 
	nop			;3827	00 	. 
	nop			;3828	00 	. 
	nop			;3829	00 	. 
	nop			;382a	00 	. 
	nop			;382b	00 	. 
	nop			;382c	00 	. 
	nop			;382d	00 	. 
	nop			;382e	00 	. 
	nop			;382f	00 	. 
	nop			;3830	00 	. 
	nop			;3831	00 	. 
	nop			;3832	00 	. 
	nop			;3833	00 	. 
	nop			;3834	00 	. 
	nop			;3835	00 	. 
	nop			;3836	00 	. 
	nop			;3837	00 	. 
	nop			;3838	00 	. 
	nop			;3839	00 	. 
	nop			;383a	00 	. 
	nop			;383b	00 	. 
	nop			;383c	00 	. 
	nop			;383d	00 	. 
	nop			;383e	00 	. 
	nop			;383f	00 	. 
	nop			;3840	00 	. 
	nop			;3841	00 	. 
	nop			;3842	00 	. 
	nop			;3843	00 	. 
	nop			;3844	00 	. 
	nop			;3845	00 	. 
	nop			;3846	00 	. 
	nop			;3847	00 	. 
	nop			;3848	00 	. 
	nop			;3849	00 	. 
	nop			;384a	00 	. 
	nop			;384b	00 	. 
	nop			;384c	00 	. 
	nop			;384d	00 	. 
	nop			;384e	00 	. 
	nop			;384f	00 	. 
	nop			;3850	00 	. 
	nop			;3851	00 	. 
	nop			;3852	00 	. 
	nop			;3853	00 	. 
	nop			;3854	00 	. 
	nop			;3855	00 	. 
	nop			;3856	00 	. 
	nop			;3857	00 	. 
	nop			;3858	00 	. 
	nop			;3859	00 	. 
	nop			;385a	00 	. 
	nop			;385b	00 	. 
	nop			;385c	00 	. 
	nop			;385d	00 	. 
	nop			;385e	00 	. 
	nop			;385f	00 	. 
	nop			;3860	00 	. 
	nop			;3861	00 	. 
	nop			;3862	00 	. 
	nop			;3863	00 	. 
	nop			;3864	00 	. 
	nop			;3865	00 	. 
	nop			;3866	00 	. 
	nop			;3867	00 	. 
	nop			;3868	00 	. 
	nop			;3869	00 	. 
	nop			;386a	00 	. 
	nop			;386b	00 	. 
	nop			;386c	00 	. 
	nop			;386d	00 	. 
	nop			;386e	00 	. 
	nop			;386f	00 	. 
	nop			;3870	00 	. 
	nop			;3871	00 	. 
	nop			;3872	00 	. 
	nop			;3873	00 	. 
	nop			;3874	00 	. 
	nop			;3875	00 	. 
	nop			;3876	00 	. 
	nop			;3877	00 	. 
	nop			;3878	00 	. 
	nop			;3879	00 	. 
	nop			;387a	00 	. 
	nop			;387b	00 	. 
	nop			;387c	00 	. 
	nop			;387d	00 	. 
	nop			;387e	00 	. 
	nop			;387f	00 	. 
	nop			;3880	00 	. 
	nop			;3881	00 	. 
	nop			;3882	00 	. 
	nop			;3883	00 	. 
	nop			;3884	00 	. 
	nop			;3885	00 	. 
	nop			;3886	00 	. 
	nop			;3887	00 	. 
	nop			;3888	00 	. 
	nop			;3889	00 	. 
	nop			;388a	00 	. 
	nop			;388b	00 	. 
	nop			;388c	00 	. 
	nop			;388d	00 	. 
	nop			;388e	00 	. 
	nop			;388f	00 	. 
	nop			;3890	00 	. 
	nop			;3891	00 	. 
	nop			;3892	00 	. 
	nop			;3893	00 	. 
	nop			;3894	00 	. 
	nop			;3895	00 	. 
	nop			;3896	00 	. 
	nop			;3897	00 	. 
	nop			;3898	00 	. 
	nop			;3899	00 	. 
	nop			;389a	00 	. 
	nop			;389b	00 	. 
	nop			;389c	00 	. 
	nop			;389d	00 	. 
	nop			;389e	00 	. 
	nop			;389f	00 	. 
	nop			;38a0	00 	. 
	nop			;38a1	00 	. 
	nop			;38a2	00 	. 
	nop			;38a3	00 	. 
	nop			;38a4	00 	. 
	nop			;38a5	00 	. 
	nop			;38a6	00 	. 
	nop			;38a7	00 	. 
	nop			;38a8	00 	. 
	nop			;38a9	00 	. 
	nop			;38aa	00 	. 
	nop			;38ab	00 	. 
	nop			;38ac	00 	. 
	nop			;38ad	00 	. 
	nop			;38ae	00 	. 
	nop			;38af	00 	. 
	nop			;38b0	00 	. 
	nop			;38b1	00 	. 
	nop			;38b2	00 	. 
	nop			;38b3	00 	. 
	nop			;38b4	00 	. 
	nop			;38b5	00 	. 
	nop			;38b6	00 	. 
	nop			;38b7	00 	. 
	nop			;38b8	00 	. 
	nop			;38b9	00 	. 
	nop			;38ba	00 	. 
	nop			;38bb	00 	. 
	nop			;38bc	00 	. 
	nop			;38bd	00 	. 
	nop			;38be	00 	. 
	nop			;38bf	00 	. 
	nop			;38c0	00 	. 
	nop			;38c1	00 	. 
	nop			;38c2	00 	. 
	nop			;38c3	00 	. 
	nop			;38c4	00 	. 
	nop			;38c5	00 	. 
	nop			;38c6	00 	. 
	nop			;38c7	00 	. 
	nop			;38c8	00 	. 
	nop			;38c9	00 	. 
	nop			;38ca	00 	. 
	nop			;38cb	00 	. 
	nop			;38cc	00 	. 
	nop			;38cd	00 	. 
	nop			;38ce	00 	. 
	nop			;38cf	00 	. 
	nop			;38d0	00 	. 
	nop			;38d1	00 	. 
	nop			;38d2	00 	. 
	nop			;38d3	00 	. 
	nop			;38d4	00 	. 
	nop			;38d5	00 	. 
	nop			;38d6	00 	. 
	nop			;38d7	00 	. 
	nop			;38d8	00 	. 
	nop			;38d9	00 	. 
	nop			;38da	00 	. 
	nop			;38db	00 	. 
	nop			;38dc	00 	. 
	nop			;38dd	00 	. 
	nop			;38de	00 	. 
	nop			;38df	00 	. 
	nop			;38e0	00 	. 
	nop			;38e1	00 	. 
	nop			;38e2	00 	. 
	nop			;38e3	00 	. 
	nop			;38e4	00 	. 
	nop			;38e5	00 	. 
	nop			;38e6	00 	. 
	nop			;38e7	00 	. 
	nop			;38e8	00 	. 
	nop			;38e9	00 	. 
	nop			;38ea	00 	. 
	nop			;38eb	00 	. 
	nop			;38ec	00 	. 
	nop			;38ed	00 	. 
	nop			;38ee	00 	. 
	nop			;38ef	00 	. 
	nop			;38f0	00 	. 
	nop			;38f1	00 	. 
	nop			;38f2	00 	. 
	nop			;38f3	00 	. 
	nop			;38f4	00 	. 
	nop			;38f5	00 	. 
	nop			;38f6	00 	. 
	nop			;38f7	00 	. 
	nop			;38f8	00 	. 
	nop			;38f9	00 	. 
	nop			;38fa	00 	. 
	nop			;38fb	00 	. 
	nop			;38fc	00 	. 
	nop			;38fd	00 	. 
	nop			;38fe	00 	. 
	nop			;38ff	00 	. 
	nop			;3900	00 	. 
	nop			;3901	00 	. 
	nop			;3902	00 	. 
	nop			;3903	00 	. 
	nop			;3904	00 	. 
	nop			;3905	00 	. 
	nop			;3906	00 	. 
	nop			;3907	00 	. 
	nop			;3908	00 	. 
	nop			;3909	00 	. 
	nop			;390a	00 	. 
	nop			;390b	00 	. 
	nop			;390c	00 	. 
	nop			;390d	00 	. 
	nop			;390e	00 	. 
	nop			;390f	00 	. 
	nop			;3910	00 	. 
	nop			;3911	00 	. 
	nop			;3912	00 	. 
	nop			;3913	00 	. 
	nop			;3914	00 	. 
	nop			;3915	00 	. 
	nop			;3916	00 	. 
	nop			;3917	00 	. 
	nop			;3918	00 	. 
	nop			;3919	00 	. 
	nop			;391a	00 	. 
	nop			;391b	00 	. 
	nop			;391c	00 	. 
	nop			;391d	00 	. 
	nop			;391e	00 	. 
	nop			;391f	00 	. 
	nop			;3920	00 	. 
	nop			;3921	00 	. 
	nop			;3922	00 	. 
	nop			;3923	00 	. 
	nop			;3924	00 	. 
	nop			;3925	00 	. 
	nop			;3926	00 	. 
	nop			;3927	00 	. 
	nop			;3928	00 	. 
	nop			;3929	00 	. 
	nop			;392a	00 	. 
	nop			;392b	00 	. 
	nop			;392c	00 	. 
	nop			;392d	00 	. 
	nop			;392e	00 	. 
	nop			;392f	00 	. 
	nop			;3930	00 	. 
	nop			;3931	00 	. 
	nop			;3932	00 	. 
	nop			;3933	00 	. 
	nop			;3934	00 	. 
	nop			;3935	00 	. 
	nop			;3936	00 	. 
	nop			;3937	00 	. 
	nop			;3938	00 	. 
	nop			;3939	00 	. 
	nop			;393a	00 	. 
	nop			;393b	00 	. 
	nop			;393c	00 	. 
	nop			;393d	00 	. 
	nop			;393e	00 	. 
	nop			;393f	00 	. 
	nop			;3940	00 	. 
	nop			;3941	00 	. 
	nop			;3942	00 	. 
	nop			;3943	00 	. 
	nop			;3944	00 	. 
	nop			;3945	00 	. 
	nop			;3946	00 	. 
	nop			;3947	00 	. 
	nop			;3948	00 	. 
	nop			;3949	00 	. 
	nop			;394a	00 	. 
	nop			;394b	00 	. 
	nop			;394c	00 	. 
	nop			;394d	00 	. 
	nop			;394e	00 	. 
	nop			;394f	00 	. 
	nop			;3950	00 	. 
	nop			;3951	00 	. 
	nop			;3952	00 	. 
	nop			;3953	00 	. 
	nop			;3954	00 	. 
	nop			;3955	00 	. 
	nop			;3956	00 	. 
	nop			;3957	00 	. 
	nop			;3958	00 	. 
	nop			;3959	00 	. 
	nop			;395a	00 	. 
	nop			;395b	00 	. 
	nop			;395c	00 	. 
	nop			;395d	00 	. 
	nop			;395e	00 	. 
	nop			;395f	00 	. 
	nop			;3960	00 	. 
	nop			;3961	00 	. 
	nop			;3962	00 	. 
	nop			;3963	00 	. 
	nop			;3964	00 	. 
	nop			;3965	00 	. 
	nop			;3966	00 	. 
	nop			;3967	00 	. 
	nop			;3968	00 	. 
	nop			;3969	00 	. 
	nop			;396a	00 	. 
	nop			;396b	00 	. 
	nop			;396c	00 	. 
	nop			;396d	00 	. 
	nop			;396e	00 	. 
	nop			;396f	00 	. 
	nop			;3970	00 	. 
	nop			;3971	00 	. 
	nop			;3972	00 	. 
	nop			;3973	00 	. 
	nop			;3974	00 	. 
	nop			;3975	00 	. 
	nop			;3976	00 	. 
	nop			;3977	00 	. 
	nop			;3978	00 	. 
	nop			;3979	00 	. 
	nop			;397a	00 	. 
	nop			;397b	00 	. 
	nop			;397c	00 	. 
	nop			;397d	00 	. 
	nop			;397e	00 	. 
	nop			;397f	00 	. 
	nop			;3980	00 	. 
	nop			;3981	00 	. 
	nop			;3982	00 	. 
	nop			;3983	00 	. 
	nop			;3984	00 	. 
	nop			;3985	00 	. 
	nop			;3986	00 	. 
	nop			;3987	00 	. 
	nop			;3988	00 	. 
	nop			;3989	00 	. 
	nop			;398a	00 	. 
	nop			;398b	00 	. 
	nop			;398c	00 	. 
	nop			;398d	00 	. 
	nop			;398e	00 	. 
	nop			;398f	00 	. 
	nop			;3990	00 	. 
	nop			;3991	00 	. 
	nop			;3992	00 	. 
	nop			;3993	00 	. 
	nop			;3994	00 	. 
	nop			;3995	00 	. 
	nop			;3996	00 	. 
	nop			;3997	00 	. 
	nop			;3998	00 	. 
	nop			;3999	00 	. 
	nop			;399a	00 	. 
	nop			;399b	00 	. 
	nop			;399c	00 	. 
	nop			;399d	00 	. 
	nop			;399e	00 	. 
	nop			;399f	00 	. 
	nop			;39a0	00 	. 
	nop			;39a1	00 	. 
	nop			;39a2	00 	. 
	nop			;39a3	00 	. 
	nop			;39a4	00 	. 
	nop			;39a5	00 	. 
	nop			;39a6	00 	. 
	nop			;39a7	00 	. 
	nop			;39a8	00 	. 
	nop			;39a9	00 	. 
	nop			;39aa	00 	. 
	nop			;39ab	00 	. 
	nop			;39ac	00 	. 
	nop			;39ad	00 	. 
	nop			;39ae	00 	. 
	nop			;39af	00 	. 
	nop			;39b0	00 	. 
	nop			;39b1	00 	. 
	nop			;39b2	00 	. 
	nop			;39b3	00 	. 
	nop			;39b4	00 	. 
	nop			;39b5	00 	. 
	nop			;39b6	00 	. 
	nop			;39b7	00 	. 
	nop			;39b8	00 	. 
	nop			;39b9	00 	. 
	nop			;39ba	00 	. 
	nop			;39bb	00 	. 
	nop			;39bc	00 	. 
	nop			;39bd	00 	. 
	nop			;39be	00 	. 
	nop			;39bf	00 	. 
	nop			;39c0	00 	. 
	nop			;39c1	00 	. 
	nop			;39c2	00 	. 
	nop			;39c3	00 	. 
	nop			;39c4	00 	. 
	nop			;39c5	00 	. 
	nop			;39c6	00 	. 
	nop			;39c7	00 	. 
	nop			;39c8	00 	. 
	nop			;39c9	00 	. 
	nop			;39ca	00 	. 
	nop			;39cb	00 	. 
	nop			;39cc	00 	. 
	nop			;39cd	00 	. 
	nop			;39ce	00 	. 
	nop			;39cf	00 	. 
	nop			;39d0	00 	. 
	nop			;39d1	00 	. 
	nop			;39d2	00 	. 
	nop			;39d3	00 	. 
	nop			;39d4	00 	. 
	nop			;39d5	00 	. 
	nop			;39d6	00 	. 
	nop			;39d7	00 	. 
	nop			;39d8	00 	. 
	nop			;39d9	00 	. 
	nop			;39da	00 	. 
	nop			;39db	00 	. 
	nop			;39dc	00 	. 
	nop			;39dd	00 	. 
	nop			;39de	00 	. 
	nop			;39df	00 	. 
	nop			;39e0	00 	. 
	nop			;39e1	00 	. 
	nop			;39e2	00 	. 
	nop			;39e3	00 	. 
	nop			;39e4	00 	. 
	nop			;39e5	00 	. 
	nop			;39e6	00 	. 
	nop			;39e7	00 	. 
	nop			;39e8	00 	. 
	nop			;39e9	00 	. 
	nop			;39ea	00 	. 
	nop			;39eb	00 	. 
	nop			;39ec	00 	. 
	nop			;39ed	00 	. 
	nop			;39ee	00 	. 
	nop			;39ef	00 	. 
	nop			;39f0	00 	. 
	nop			;39f1	00 	. 
	nop			;39f2	00 	. 
	nop			;39f3	00 	. 
	nop			;39f4	00 	. 
	nop			;39f5	00 	. 
	nop			;39f6	00 	. 
	nop			;39f7	00 	. 
	nop			;39f8	00 	. 
	nop			;39f9	00 	. 
	nop			;39fa	00 	. 
	nop			;39fb	00 	. 
	nop			;39fc	00 	. 
	nop			;39fd	00 	. 
	nop			;39fe	00 	. 
	nop			;39ff	00 	. 
	nop			;3a00	00 	. 
	nop			;3a01	00 	. 
	nop			;3a02	00 	. 
	nop			;3a03	00 	. 
	nop			;3a04	00 	. 
	nop			;3a05	00 	. 
	nop			;3a06	00 	. 
	nop			;3a07	00 	. 
	nop			;3a08	00 	. 
	nop			;3a09	00 	. 
	nop			;3a0a	00 	. 
	nop			;3a0b	00 	. 
	nop			;3a0c	00 	. 
	nop			;3a0d	00 	. 
	nop			;3a0e	00 	. 
	nop			;3a0f	00 	. 
	nop			;3a10	00 	. 
	nop			;3a11	00 	. 
	nop			;3a12	00 	. 
	nop			;3a13	00 	. 
	nop			;3a14	00 	. 
	nop			;3a15	00 	. 
	nop			;3a16	00 	. 
	nop			;3a17	00 	. 
	nop			;3a18	00 	. 
	nop			;3a19	00 	. 
	nop			;3a1a	00 	. 
	nop			;3a1b	00 	. 
	nop			;3a1c	00 	. 
	nop			;3a1d	00 	. 
	nop			;3a1e	00 	. 
	nop			;3a1f	00 	. 
	nop			;3a20	00 	. 
	nop			;3a21	00 	. 
	nop			;3a22	00 	. 
	nop			;3a23	00 	. 
	nop			;3a24	00 	. 
	nop			;3a25	00 	. 
	nop			;3a26	00 	. 
	nop			;3a27	00 	. 
	nop			;3a28	00 	. 
	nop			;3a29	00 	. 
	nop			;3a2a	00 	. 
	nop			;3a2b	00 	. 
	nop			;3a2c	00 	. 
	nop			;3a2d	00 	. 
	nop			;3a2e	00 	. 
	nop			;3a2f	00 	. 
	nop			;3a30	00 	. 
	nop			;3a31	00 	. 
	nop			;3a32	00 	. 
	nop			;3a33	00 	. 
	nop			;3a34	00 	. 
	nop			;3a35	00 	. 
	nop			;3a36	00 	. 
	nop			;3a37	00 	. 
	nop			;3a38	00 	. 
	nop			;3a39	00 	. 
	nop			;3a3a	00 	. 
	nop			;3a3b	00 	. 
	nop			;3a3c	00 	. 
	nop			;3a3d	00 	. 
	nop			;3a3e	00 	. 
	nop			;3a3f	00 	. 
	nop			;3a40	00 	. 
	nop			;3a41	00 	. 
	nop			;3a42	00 	. 
	nop			;3a43	00 	. 
	nop			;3a44	00 	. 
	nop			;3a45	00 	. 
	nop			;3a46	00 	. 
	nop			;3a47	00 	. 
	nop			;3a48	00 	. 
	nop			;3a49	00 	. 
	nop			;3a4a	00 	. 
	nop			;3a4b	00 	. 
	nop			;3a4c	00 	. 
	nop			;3a4d	00 	. 
	nop			;3a4e	00 	. 
	nop			;3a4f	00 	. 
	nop			;3a50	00 	. 
	nop			;3a51	00 	. 
	nop			;3a52	00 	. 
	nop			;3a53	00 	. 
	nop			;3a54	00 	. 
	nop			;3a55	00 	. 
	nop			;3a56	00 	. 
	nop			;3a57	00 	. 
	nop			;3a58	00 	. 
	nop			;3a59	00 	. 
	nop			;3a5a	00 	. 
	nop			;3a5b	00 	. 
	nop			;3a5c	00 	. 
	nop			;3a5d	00 	. 
	nop			;3a5e	00 	. 
	nop			;3a5f	00 	. 
	nop			;3a60	00 	. 
	nop			;3a61	00 	. 
	nop			;3a62	00 	. 
	nop			;3a63	00 	. 
	nop			;3a64	00 	. 
	nop			;3a65	00 	. 
	nop			;3a66	00 	. 
	nop			;3a67	00 	. 
	nop			;3a68	00 	. 
	nop			;3a69	00 	. 
	nop			;3a6a	00 	. 
	nop			;3a6b	00 	. 
	nop			;3a6c	00 	. 
	nop			;3a6d	00 	. 
	nop			;3a6e	00 	. 
	nop			;3a6f	00 	. 
	nop			;3a70	00 	. 
	nop			;3a71	00 	. 
	nop			;3a72	00 	. 
	nop			;3a73	00 	. 
	nop			;3a74	00 	. 
	nop			;3a75	00 	. 
	nop			;3a76	00 	. 
	nop			;3a77	00 	. 
	nop			;3a78	00 	. 
	nop			;3a79	00 	. 
	nop			;3a7a	00 	. 
	nop			;3a7b	00 	. 
	nop			;3a7c	00 	. 
	nop			;3a7d	00 	. 
	nop			;3a7e	00 	. 
	nop			;3a7f	00 	. 
	nop			;3a80	00 	. 
	nop			;3a81	00 	. 
	nop			;3a82	00 	. 
	nop			;3a83	00 	. 
	nop			;3a84	00 	. 
	nop			;3a85	00 	. 
	nop			;3a86	00 	. 
	nop			;3a87	00 	. 
	nop			;3a88	00 	. 
	nop			;3a89	00 	. 
	nop			;3a8a	00 	. 
	nop			;3a8b	00 	. 
	nop			;3a8c	00 	. 
	nop			;3a8d	00 	. 
	nop			;3a8e	00 	. 
	nop			;3a8f	00 	. 
	nop			;3a90	00 	. 
	nop			;3a91	00 	. 
	nop			;3a92	00 	. 
	nop			;3a93	00 	. 
	nop			;3a94	00 	. 
	nop			;3a95	00 	. 
	nop			;3a96	00 	. 
	nop			;3a97	00 	. 
	nop			;3a98	00 	. 
	nop			;3a99	00 	. 
	nop			;3a9a	00 	. 
	nop			;3a9b	00 	. 
	nop			;3a9c	00 	. 
	nop			;3a9d	00 	. 
	nop			;3a9e	00 	. 
	nop			;3a9f	00 	. 
	nop			;3aa0	00 	. 
	nop			;3aa1	00 	. 
	nop			;3aa2	00 	. 
	nop			;3aa3	00 	. 
	nop			;3aa4	00 	. 
	nop			;3aa5	00 	. 
	nop			;3aa6	00 	. 
	nop			;3aa7	00 	. 
	nop			;3aa8	00 	. 
	nop			;3aa9	00 	. 
	nop			;3aaa	00 	. 
	nop			;3aab	00 	. 
	nop			;3aac	00 	. 
	nop			;3aad	00 	. 
	nop			;3aae	00 	. 
	nop			;3aaf	00 	. 
	nop			;3ab0	00 	. 
	nop			;3ab1	00 	. 
	nop			;3ab2	00 	. 
	nop			;3ab3	00 	. 
	nop			;3ab4	00 	. 
	nop			;3ab5	00 	. 
	nop			;3ab6	00 	. 
	nop			;3ab7	00 	. 
	nop			;3ab8	00 	. 
	nop			;3ab9	00 	. 
	nop			;3aba	00 	. 
	nop			;3abb	00 	. 
	nop			;3abc	00 	. 
	nop			;3abd	00 	. 
	nop			;3abe	00 	. 
	nop			;3abf	00 	. 
	nop			;3ac0	00 	. 
	nop			;3ac1	00 	. 
	nop			;3ac2	00 	. 
	nop			;3ac3	00 	. 
	nop			;3ac4	00 	. 
	nop			;3ac5	00 	. 
	nop			;3ac6	00 	. 
	nop			;3ac7	00 	. 
	nop			;3ac8	00 	. 
	nop			;3ac9	00 	. 
	nop			;3aca	00 	. 
	nop			;3acb	00 	. 
	nop			;3acc	00 	. 
	nop			;3acd	00 	. 
	nop			;3ace	00 	. 
	nop			;3acf	00 	. 
	nop			;3ad0	00 	. 
	nop			;3ad1	00 	. 
	nop			;3ad2	00 	. 
	nop			;3ad3	00 	. 
	nop			;3ad4	00 	. 
	nop			;3ad5	00 	. 
	nop			;3ad6	00 	. 
	nop			;3ad7	00 	. 
	nop			;3ad8	00 	. 
	nop			;3ad9	00 	. 
	nop			;3ada	00 	. 
	nop			;3adb	00 	. 
	nop			;3adc	00 	. 
	nop			;3add	00 	. 
	nop			;3ade	00 	. 
	nop			;3adf	00 	. 
	nop			;3ae0	00 	. 
	nop			;3ae1	00 	. 
	nop			;3ae2	00 	. 
	nop			;3ae3	00 	. 
	nop			;3ae4	00 	. 
	nop			;3ae5	00 	. 
	nop			;3ae6	00 	. 
	nop			;3ae7	00 	. 
	nop			;3ae8	00 	. 
	nop			;3ae9	00 	. 
	nop			;3aea	00 	. 
	nop			;3aeb	00 	. 
	nop			;3aec	00 	. 
	nop			;3aed	00 	. 
	nop			;3aee	00 	. 
	nop			;3aef	00 	. 
	nop			;3af0	00 	. 
	nop			;3af1	00 	. 
	nop			;3af2	00 	. 
	nop			;3af3	00 	. 
	nop			;3af4	00 	. 
	nop			;3af5	00 	. 
	nop			;3af6	00 	. 
	nop			;3af7	00 	. 
	nop			;3af8	00 	. 
	nop			;3af9	00 	. 
	nop			;3afa	00 	. 
	nop			;3afb	00 	. 
	nop			;3afc	00 	. 
	nop			;3afd	00 	. 
	nop			;3afe	00 	. 
	nop			;3aff	00 	. 
	nop			;3b00	00 	. 
	nop			;3b01	00 	. 
	nop			;3b02	00 	. 
	nop			;3b03	00 	. 
	nop			;3b04	00 	. 
	nop			;3b05	00 	. 
	nop			;3b06	00 	. 
	nop			;3b07	00 	. 
	nop			;3b08	00 	. 
	nop			;3b09	00 	. 
	nop			;3b0a	00 	. 
	nop			;3b0b	00 	. 
	nop			;3b0c	00 	. 
	nop			;3b0d	00 	. 
	nop			;3b0e	00 	. 
	nop			;3b0f	00 	. 
	nop			;3b10	00 	. 
	nop			;3b11	00 	. 
	nop			;3b12	00 	. 
	nop			;3b13	00 	. 
	nop			;3b14	00 	. 
	nop			;3b15	00 	. 
	nop			;3b16	00 	. 
	nop			;3b17	00 	. 
	nop			;3b18	00 	. 
	nop			;3b19	00 	. 
	nop			;3b1a	00 	. 
	nop			;3b1b	00 	. 
	nop			;3b1c	00 	. 
	nop			;3b1d	00 	. 
	nop			;3b1e	00 	. 
	nop			;3b1f	00 	. 
	nop			;3b20	00 	. 
	nop			;3b21	00 	. 
	nop			;3b22	00 	. 
	nop			;3b23	00 	. 
	nop			;3b24	00 	. 
	nop			;3b25	00 	. 
	nop			;3b26	00 	. 
	nop			;3b27	00 	. 
	nop			;3b28	00 	. 
	nop			;3b29	00 	. 
	nop			;3b2a	00 	. 
	nop			;3b2b	00 	. 
	nop			;3b2c	00 	. 
	nop			;3b2d	00 	. 
	nop			;3b2e	00 	. 
	nop			;3b2f	00 	. 
	nop			;3b30	00 	. 
	nop			;3b31	00 	. 
	nop			;3b32	00 	. 
	nop			;3b33	00 	. 
	nop			;3b34	00 	. 
	nop			;3b35	00 	. 
	nop			;3b36	00 	. 
	nop			;3b37	00 	. 
	nop			;3b38	00 	. 
	nop			;3b39	00 	. 
	nop			;3b3a	00 	. 
	nop			;3b3b	00 	. 
	nop			;3b3c	00 	. 
	nop			;3b3d	00 	. 
	nop			;3b3e	00 	. 
	nop			;3b3f	00 	. 
	nop			;3b40	00 	. 
	nop			;3b41	00 	. 
	nop			;3b42	00 	. 
	nop			;3b43	00 	. 
	nop			;3b44	00 	. 
	nop			;3b45	00 	. 
	nop			;3b46	00 	. 
	nop			;3b47	00 	. 
	nop			;3b48	00 	. 
	nop			;3b49	00 	. 
	nop			;3b4a	00 	. 
	nop			;3b4b	00 	. 
	nop			;3b4c	00 	. 
	nop			;3b4d	00 	. 
	nop			;3b4e	00 	. 
	nop			;3b4f	00 	. 
	nop			;3b50	00 	. 
	nop			;3b51	00 	. 
	nop			;3b52	00 	. 
	nop			;3b53	00 	. 
	nop			;3b54	00 	. 
	nop			;3b55	00 	. 
	nop			;3b56	00 	. 
	nop			;3b57	00 	. 
	nop			;3b58	00 	. 
	nop			;3b59	00 	. 
	nop			;3b5a	00 	. 
	nop			;3b5b	00 	. 
	nop			;3b5c	00 	. 
	nop			;3b5d	00 	. 
	nop			;3b5e	00 	. 
	nop			;3b5f	00 	. 
	nop			;3b60	00 	. 
	nop			;3b61	00 	. 
	nop			;3b62	00 	. 
	nop			;3b63	00 	. 
	nop			;3b64	00 	. 
	nop			;3b65	00 	. 
	nop			;3b66	00 	. 
	nop			;3b67	00 	. 
	nop			;3b68	00 	. 
	nop			;3b69	00 	. 
	nop			;3b6a	00 	. 
	nop			;3b6b	00 	. 
	nop			;3b6c	00 	. 
	nop			;3b6d	00 	. 
	nop			;3b6e	00 	. 
	nop			;3b6f	00 	. 
	nop			;3b70	00 	. 
	nop			;3b71	00 	. 
	nop			;3b72	00 	. 
	nop			;3b73	00 	. 
	nop			;3b74	00 	. 
	nop			;3b75	00 	. 
	nop			;3b76	00 	. 
	nop			;3b77	00 	. 
	nop			;3b78	00 	. 
	nop			;3b79	00 	. 
	nop			;3b7a	00 	. 
	nop			;3b7b	00 	. 
	nop			;3b7c	00 	. 
	nop			;3b7d	00 	. 
	nop			;3b7e	00 	. 
	nop			;3b7f	00 	. 
	nop			;3b80	00 	. 
	nop			;3b81	00 	. 
	nop			;3b82	00 	. 
	nop			;3b83	00 	. 
	nop			;3b84	00 	. 
	nop			;3b85	00 	. 
	nop			;3b86	00 	. 
	nop			;3b87	00 	. 
	nop			;3b88	00 	. 
	nop			;3b89	00 	. 
	nop			;3b8a	00 	. 
	nop			;3b8b	00 	. 
	nop			;3b8c	00 	. 
	nop			;3b8d	00 	. 
	nop			;3b8e	00 	. 
	nop			;3b8f	00 	. 
	nop			;3b90	00 	. 
	nop			;3b91	00 	. 
	nop			;3b92	00 	. 
	nop			;3b93	00 	. 
	nop			;3b94	00 	. 
	nop			;3b95	00 	. 
	nop			;3b96	00 	. 
	nop			;3b97	00 	. 
	nop			;3b98	00 	. 
	nop			;3b99	00 	. 
	nop			;3b9a	00 	. 
	nop			;3b9b	00 	. 
	nop			;3b9c	00 	. 
	nop			;3b9d	00 	. 
	nop			;3b9e	00 	. 
	nop			;3b9f	00 	. 
	nop			;3ba0	00 	. 
	nop			;3ba1	00 	. 
	nop			;3ba2	00 	. 
	nop			;3ba3	00 	. 
	nop			;3ba4	00 	. 
	nop			;3ba5	00 	. 
	nop			;3ba6	00 	. 
	nop			;3ba7	00 	. 
	nop			;3ba8	00 	. 
	nop			;3ba9	00 	. 
	nop			;3baa	00 	. 
	nop			;3bab	00 	. 
	nop			;3bac	00 	. 
	nop			;3bad	00 	. 
	nop			;3bae	00 	. 
	nop			;3baf	00 	. 
	nop			;3bb0	00 	. 
	nop			;3bb1	00 	. 
	nop			;3bb2	00 	. 
	nop			;3bb3	00 	. 
	nop			;3bb4	00 	. 
	nop			;3bb5	00 	. 
	nop			;3bb6	00 	. 
	nop			;3bb7	00 	. 
	nop			;3bb8	00 	. 
	nop			;3bb9	00 	. 
	nop			;3bba	00 	. 
	nop			;3bbb	00 	. 
	nop			;3bbc	00 	. 
	nop			;3bbd	00 	. 
	nop			;3bbe	00 	. 
	nop			;3bbf	00 	. 
	nop			;3bc0	00 	. 
	nop			;3bc1	00 	. 
	nop			;3bc2	00 	. 
	nop			;3bc3	00 	. 
	nop			;3bc4	00 	. 
	nop			;3bc5	00 	. 
	nop			;3bc6	00 	. 
	nop			;3bc7	00 	. 
	nop			;3bc8	00 	. 
	nop			;3bc9	00 	. 
	nop			;3bca	00 	. 
	nop			;3bcb	00 	. 
	nop			;3bcc	00 	. 
	nop			;3bcd	00 	. 
	nop			;3bce	00 	. 
	nop			;3bcf	00 	. 
	nop			;3bd0	00 	. 
	nop			;3bd1	00 	. 
	nop			;3bd2	00 	. 
	nop			;3bd3	00 	. 
	nop			;3bd4	00 	. 
	nop			;3bd5	00 	. 
	nop			;3bd6	00 	. 
	nop			;3bd7	00 	. 
	nop			;3bd8	00 	. 
	nop			;3bd9	00 	. 
	nop			;3bda	00 	. 
	nop			;3bdb	00 	. 
	nop			;3bdc	00 	. 
	nop			;3bdd	00 	. 
	nop			;3bde	00 	. 
	nop			;3bdf	00 	. 
	nop			;3be0	00 	. 
	nop			;3be1	00 	. 
	nop			;3be2	00 	. 
	nop			;3be3	00 	. 
	nop			;3be4	00 	. 
	nop			;3be5	00 	. 
	nop			;3be6	00 	. 
	nop			;3be7	00 	. 
	nop			;3be8	00 	. 
	nop			;3be9	00 	. 
	nop			;3bea	00 	. 
	nop			;3beb	00 	. 
	nop			;3bec	00 	. 
	nop			;3bed	00 	. 
	nop			;3bee	00 	. 
	nop			;3bef	00 	. 
	nop			;3bf0	00 	. 
	nop			;3bf1	00 	. 
	nop			;3bf2	00 	. 
	nop			;3bf3	00 	. 
	nop			;3bf4	00 	. 
	nop			;3bf5	00 	. 
	nop			;3bf6	00 	. 
	nop			;3bf7	00 	. 
	nop			;3bf8	00 	. 
	nop			;3bf9	00 	. 
	nop			;3bfa	00 	. 
	nop			;3bfb	00 	. 
	nop			;3bfc	00 	. 
	nop			;3bfd	00 	. 
	nop			;3bfe	00 	. 
	nop			;3bff	00 	. 
	nop			;3c00	00 	. 
	nop			;3c01	00 	. 
	nop			;3c02	00 	. 
	nop			;3c03	00 	. 
	nop			;3c04	00 	. 
	nop			;3c05	00 	. 
	nop			;3c06	00 	. 
	nop			;3c07	00 	. 
	nop			;3c08	00 	. 
	nop			;3c09	00 	. 
	nop			;3c0a	00 	. 
	nop			;3c0b	00 	. 
	nop			;3c0c	00 	. 
	nop			;3c0d	00 	. 
	nop			;3c0e	00 	. 
	nop			;3c0f	00 	. 
	nop			;3c10	00 	. 
	nop			;3c11	00 	. 
	nop			;3c12	00 	. 
	nop			;3c13	00 	. 
	nop			;3c14	00 	. 
	nop			;3c15	00 	. 
	nop			;3c16	00 	. 
	nop			;3c17	00 	. 
	nop			;3c18	00 	. 
	nop			;3c19	00 	. 
	nop			;3c1a	00 	. 
	nop			;3c1b	00 	. 
	nop			;3c1c	00 	. 
	nop			;3c1d	00 	. 
	nop			;3c1e	00 	. 
	nop			;3c1f	00 	. 
	nop			;3c20	00 	. 
	nop			;3c21	00 	. 
	nop			;3c22	00 	. 
	nop			;3c23	00 	. 
	nop			;3c24	00 	. 
	nop			;3c25	00 	. 
	nop			;3c26	00 	. 
	nop			;3c27	00 	. 
	nop			;3c28	00 	. 
	nop			;3c29	00 	. 
	nop			;3c2a	00 	. 
	nop			;3c2b	00 	. 
	nop			;3c2c	00 	. 
	nop			;3c2d	00 	. 
	nop			;3c2e	00 	. 
	nop			;3c2f	00 	. 
	nop			;3c30	00 	. 
	nop			;3c31	00 	. 
	nop			;3c32	00 	. 
	nop			;3c33	00 	. 
	nop			;3c34	00 	. 
	nop			;3c35	00 	. 
	nop			;3c36	00 	. 
	nop			;3c37	00 	. 
	nop			;3c38	00 	. 
	nop			;3c39	00 	. 
	nop			;3c3a	00 	. 
	nop			;3c3b	00 	. 
	nop			;3c3c	00 	. 
	nop			;3c3d	00 	. 
	nop			;3c3e	00 	. 
	nop			;3c3f	00 	. 
	nop			;3c40	00 	. 
	nop			;3c41	00 	. 
	nop			;3c42	00 	. 
	nop			;3c43	00 	. 
	nop			;3c44	00 	. 
	nop			;3c45	00 	. 
	nop			;3c46	00 	. 
	nop			;3c47	00 	. 
	nop			;3c48	00 	. 
	nop			;3c49	00 	. 
	nop			;3c4a	00 	. 
	nop			;3c4b	00 	. 
	nop			;3c4c	00 	. 
	nop			;3c4d	00 	. 
	nop			;3c4e	00 	. 
	nop			;3c4f	00 	. 
	nop			;3c50	00 	. 
	nop			;3c51	00 	. 
	nop			;3c52	00 	. 
	nop			;3c53	00 	. 
	nop			;3c54	00 	. 
	nop			;3c55	00 	. 
	nop			;3c56	00 	. 
	nop			;3c57	00 	. 
	nop			;3c58	00 	. 
	nop			;3c59	00 	. 
	nop			;3c5a	00 	. 
	nop			;3c5b	00 	. 
	nop			;3c5c	00 	. 
	nop			;3c5d	00 	. 
	nop			;3c5e	00 	. 
	nop			;3c5f	00 	. 
	nop			;3c60	00 	. 
	nop			;3c61	00 	. 
	nop			;3c62	00 	. 
	nop			;3c63	00 	. 
	nop			;3c64	00 	. 
	nop			;3c65	00 	. 
	nop			;3c66	00 	. 
	nop			;3c67	00 	. 
	nop			;3c68	00 	. 
	nop			;3c69	00 	. 
	nop			;3c6a	00 	. 
	nop			;3c6b	00 	. 
	nop			;3c6c	00 	. 
	nop			;3c6d	00 	. 
	nop			;3c6e	00 	. 
	nop			;3c6f	00 	. 
	nop			;3c70	00 	. 
	nop			;3c71	00 	. 
	nop			;3c72	00 	. 
	nop			;3c73	00 	. 
	nop			;3c74	00 	. 
	nop			;3c75	00 	. 
	nop			;3c76	00 	. 
	nop			;3c77	00 	. 
	nop			;3c78	00 	. 
	nop			;3c79	00 	. 
	nop			;3c7a	00 	. 
	nop			;3c7b	00 	. 
	nop			;3c7c	00 	. 
	nop			;3c7d	00 	. 
	nop			;3c7e	00 	. 
	nop			;3c7f	00 	. 
	nop			;3c80	00 	. 
	nop			;3c81	00 	. 
	nop			;3c82	00 	. 
	nop			;3c83	00 	. 
	nop			;3c84	00 	. 
	nop			;3c85	00 	. 
	nop			;3c86	00 	. 
	nop			;3c87	00 	. 
	nop			;3c88	00 	. 
	nop			;3c89	00 	. 
	nop			;3c8a	00 	. 
	nop			;3c8b	00 	. 
	nop			;3c8c	00 	. 
	nop			;3c8d	00 	. 
	nop			;3c8e	00 	. 
	nop			;3c8f	00 	. 
	nop			;3c90	00 	. 
	nop			;3c91	00 	. 
	nop			;3c92	00 	. 
	nop			;3c93	00 	. 
	nop			;3c94	00 	. 
	nop			;3c95	00 	. 
	nop			;3c96	00 	. 
	nop			;3c97	00 	. 
	nop			;3c98	00 	. 
	nop			;3c99	00 	. 
	nop			;3c9a	00 	. 
	nop			;3c9b	00 	. 
	nop			;3c9c	00 	. 
	nop			;3c9d	00 	. 
	nop			;3c9e	00 	. 
	nop			;3c9f	00 	. 
	nop			;3ca0	00 	. 
	nop			;3ca1	00 	. 
	nop			;3ca2	00 	. 
	nop			;3ca3	00 	. 
	nop			;3ca4	00 	. 
	nop			;3ca5	00 	. 
	nop			;3ca6	00 	. 
	nop			;3ca7	00 	. 
	nop			;3ca8	00 	. 
	nop			;3ca9	00 	. 
	nop			;3caa	00 	. 
	nop			;3cab	00 	. 
	nop			;3cac	00 	. 
	nop			;3cad	00 	. 
	nop			;3cae	00 	. 
	nop			;3caf	00 	. 
	nop			;3cb0	00 	. 
	nop			;3cb1	00 	. 
	nop			;3cb2	00 	. 
	nop			;3cb3	00 	. 
	nop			;3cb4	00 	. 
	nop			;3cb5	00 	. 
	nop			;3cb6	00 	. 
	nop			;3cb7	00 	. 
	nop			;3cb8	00 	. 
	nop			;3cb9	00 	. 
	nop			;3cba	00 	. 
	nop			;3cbb	00 	. 
	nop			;3cbc	00 	. 
	nop			;3cbd	00 	. 
	nop			;3cbe	00 	. 
	nop			;3cbf	00 	. 
	nop			;3cc0	00 	. 
	nop			;3cc1	00 	. 
	nop			;3cc2	00 	. 
	nop			;3cc3	00 	. 
	nop			;3cc4	00 	. 
	nop			;3cc5	00 	. 
	nop			;3cc6	00 	. 
	nop			;3cc7	00 	. 
	nop			;3cc8	00 	. 
	nop			;3cc9	00 	. 
	nop			;3cca	00 	. 
	nop			;3ccb	00 	. 
	nop			;3ccc	00 	. 
	nop			;3ccd	00 	. 
	nop			;3cce	00 	. 
	nop			;3ccf	00 	. 
	nop			;3cd0	00 	. 
	nop			;3cd1	00 	. 
	nop			;3cd2	00 	. 
	nop			;3cd3	00 	. 
	nop			;3cd4	00 	. 
	nop			;3cd5	00 	. 
	nop			;3cd6	00 	. 
	nop			;3cd7	00 	. 
	nop			;3cd8	00 	. 
	nop			;3cd9	00 	. 
	nop			;3cda	00 	. 
	nop			;3cdb	00 	. 
	nop			;3cdc	00 	. 
	nop			;3cdd	00 	. 
	nop			;3cde	00 	. 
	nop			;3cdf	00 	. 
	nop			;3ce0	00 	. 
	nop			;3ce1	00 	. 
	nop			;3ce2	00 	. 
	nop			;3ce3	00 	. 
	nop			;3ce4	00 	. 
	nop			;3ce5	00 	. 
	nop			;3ce6	00 	. 
	nop			;3ce7	00 	. 
	nop			;3ce8	00 	. 
	nop			;3ce9	00 	. 
	nop			;3cea	00 	. 
	nop			;3ceb	00 	. 
	nop			;3cec	00 	. 
	nop			;3ced	00 	. 
	nop			;3cee	00 	. 
	nop			;3cef	00 	. 
	nop			;3cf0	00 	. 
	nop			;3cf1	00 	. 
	nop			;3cf2	00 	. 
	nop			;3cf3	00 	. 
	nop			;3cf4	00 	. 
	nop			;3cf5	00 	. 
	nop			;3cf6	00 	. 
	nop			;3cf7	00 	. 
	nop			;3cf8	00 	. 
	nop			;3cf9	00 	. 
	nop			;3cfa	00 	. 
	nop			;3cfb	00 	. 
	nop			;3cfc	00 	. 
	nop			;3cfd	00 	. 
	nop			;3cfe	00 	. 
	nop			;3cff	00 	. 
	jp 03d15h		;3d00	c3 15 3d 	. . = 
	jp 03d35h		;3d03	c3 35 3d 	. 5 = 
	jp 03d3fh		;3d06	c3 3f 3d 	. ? = 
	jp 03e4ch		;3d09	c3 4c 3e 	. L > 
	jp 03d51h		;3d0c	c3 51 3d 	. Q = 
	jp 03d57h		;3d0f	c3 57 3d 	. W = 
	jp 03d5dh		;3d12	c3 5d 3d 	. ] = 
; Clears memory from D000-FFFF (?)
	ld hl,0ffffh		;3d15	21 ff ff 	! . . 
	ld de,0fffeh		;3d18	11 fe ff 	. . . 
	ld bc,03fffh		;3d1b	01 ff 3f 	. . ? 
	ld (hl),000h		;3d1e	36 00 	6 . 
	lddr		;3d20	ed b8 	. . 
	call INIT00		;3d22	cd 03 00 	. . . 
	call INIT01		;3d25	cd 06 00 	. . . 
    ; Since memory was zeroed, we call TIPRAM to mirror
    ; the terminal data again from NVRAM to e060
	call 000bah		;3d28	move terminal installation
    ; Switch from NVRAM to 16K rom
	ld a,008h		;3d2b	3e 08 	> . 
	out (BANKSELECT),a		;3d2d	d3 70 	. p 
    ; store new bank config in BANKS location
	ld (BANKS),a		;3d2f	32 f2 e0 	2 . . 
    ; Jump to beginning of 16K rom
	jp 04000h		;3d32	c3 00 40 	. . @ 
	ld a,008h		;3d35	3e 08 	> . 
	out (BANKSELECT),a		;3d37	d3 70 	. p 
	ld (BANKS),a		;3d39	32 f2 e0 	2 . . 
	jp 04003h		;3d3c	c3 03 40 	. . @ 
	ld a,008h		;3d3f	3e 08 	> . 
	out (BANKSELECT),a		;3d41	d3 70 	. p 
	ld (BANKS),a		;3d43	32 f2 e0 	2 . . 
	jp 04006h		;3d46	c3 06 40 	. . @ 
	xor a			;3d49	af 	. 
	out (BANKSELECT),a		;3d4a	d3 70 	. p 
	ld (BANKS),a		;3d4c	32 f2 e0 	2 . . 
	jp (ix)		;3d4f	dd e9 	. . 
	call 03e17h		;3d51	cd 17 3e 	. . > 
	jp 0400ch		;3d54	c3 0c 40 	. . @ 
	call 03e17h		;3d57	cd 17 3e 	. . > 
	jp 0400fh		;3d5a	c3 0f 40 	. . @ 
	ld a,008h		;3d5d	3e 08 	> . 
	out (BANKSELECT),a		;3d5f	d3 70 	. p 
	jp 04012h		;3d61	c3 12 40 	. . @ 
	push af			;3d64	f5 	. 
	ld a,01ch		;3d65	3e 1c 	> . 
	out (BANKSELECT),a		;3d67	d3 70 	. p 
	pop af			;3d69	f1 	. 
	push af			;3d6a	f5 	. 
	ld (de),a			;3d6b	12 	. 
	ld a,008h		;3d6c	3e 08 	> . 
	out (BANKSELECT),a		;3d6e	d3 70 	. p 
	pop af			;3d70	f1 	. 
	ret			;3d71	c9 	. 
	ld a,01ch		;3d72	3e 1c 	> . 
	out (BANKSELECT),a		;3d74	d3 70 	. p 
	ld a,(de)			;3d76	1a 	. 
	push af			;3d77	f5 	. 
	ld a,008h		;3d78	3e 08 	> . 
	out (BANKSELECT),a		;3d7a	d3 70 	. p 
	pop af			;3d7c	f1 	. 
	ret			;3d7d	c9 	. 
	push af			;3d7e	f5 	. 
	ld a,01ch		;3d7f	3e 1c 	> . 
	out (BANKSELECT),a		;3d81	d3 70 	. p 
	pop af			;3d83	f1 	. 
	push af			;3d84	f5 	. 
	ld (hl),a			;3d85	77 	w 
	ld a,008h		;3d86	3e 08 	> . 
	out (BANKSELECT),a		;3d88	d3 70 	. p 
	pop af			;3d8a	f1 	. 
	ret			;3d8b	c9 	. 
	ld a,01ch		;3d8c	3e 1c 	> . 
	out (BANKSELECT),a		;3d8e	d3 70 	. p 
	ld (BANKS),a		;3d90	32 f2 e0 	2 . . 
	jp (hl)			;3d93	e9 	. 
	ld a,01ch		;3d94	3e 1c 	> . 
	out (BANKSELECT),a		;3d96	d3 70 	. p 
	ld (BANKS),a		;3d98	32 f2 e0 	2 . . 
	jp (iy)		;3d9b	fd e9 	. . 
	ld a,01ch		;3d9d	3e 1c 	> . 
	out (BANKSELECT),a		;3d9f	d3 70 	. p 
	ld (BANKS),a		;3da1	32 f2 e0 	2 . . 
	jp (ix)		;3da4	dd e9 	. . 
	pop iy		;3da6	fd e1 	. . 
	xor a			;3da8	af 	. 
	out (BANKSELECT),a		;3da9	d3 70 	. p 
	ld hl,SAVEA		;3dab	21 e2 e0 	! . . 
	ld a,055h		;3dae	3e 55 	> U 
	ld (hl),a			;3db0	77 	w 
	ld de,04800h		;3db1	11 00 48 	. . H 
	ld bc,00400h		;3db4	01 00 04 	. . . 
	ldi		;3db7	ed a0 	. . 
	dec hl			;3db9	2b 	+ 
	jp pe,03db7h		;3dba	ea b7 3d 	. . = 
	ld hl,04800h		;3dbd	21 00 48 	! . H 
	ld bc,00400h		;3dc0	01 00 04 	. . . 
	ld a,055h		;3dc3	3e 55 	> U 
	cpi		;3dc5	ed a1 	. . 
	jr nz,$+62		;3dc7	20 3c 	  < 
	jp pe,03dc3h		;3dc9	ea c3 3d 	. . = 
	ld hl,SAVEA		;3dcc	21 e2 e0 	! . . 
	ld a,0aah		;3dcf	3e aa 	> . 
	ld (hl),a			;3dd1	77 	w 
	ld de,04800h		;3dd2	11 00 48 	. . H 
	ld bc,00400h		;3dd5	01 00 04 	. . . 
	ldi		;3dd8	ed a0 	. . 
	dec hl			;3dda	2b 	+ 
	jp pe,03dd8h		;3ddb	ea d8 3d 	. . = 
	ld hl,04800h		;3dde	21 00 48 	! . H 
	ld bc,00400h		;3de1	01 00 04 	. . . 
	ld a,0aah		;3de4	3e aa 	> . 
	cpi		;3de6	ed a1 	. . 
	jr nz,$+29		;3de8	20 1b 	  . 
	jp pe,03de4h		;3dea	ea e4 3d 	. . = 
	ld hl,041a2h		;3ded	21 a2 41 	! . A 
	ld (0e10eh),hl		;3df0	22 0e e1 	" . . 
	ld hl,0e000h		;3df3	21 00 e0 	! . . 
	ld de,04800h		;3df6	11 00 48 	. . H 
	ld bc,00111h		;3df9	01 11 01 	. . . 
	ldir		;3dfc	ed b0 	. . 
	ld a,008h		;3dfe	3e 08 	> . 
	out (BANKSELECT),a		;3e00	d3 70 	. p 
	xor a			;3e02	af 	. 
	jp (iy)		;3e03	fd e9 	. . 
	ld a,008h		;3e05	3e 08 	> . 
	out (BANKSELECT),a		;3e07	d3 70 	. p 
	scf			;3e09	37 	7 
	jp (iy)		;3e0a	fd e9 	. . 
	xor a			;3e0c	af 	. 
	out (BANKSELECT),a		;3e0d	d3 70 	. p 
	call 03e4ch		;3e0f	cd 4c 3e 	. L > 
	ld a,008h		;3e12	3e 08 	> . 
	out (BANKSELECT),a		;3e14	d3 70 	. p 
	ret			;3e16	c9 	. 
	ld a,008h		;3e17	3e 08 	> . 
	out (BANKSELECT),a		;3e19	d3 70 	. p 
	ld (BANKS),a		;3e1b	32 f2 e0 	2 . . 
	ld a,(MBYTE5)		;3e1e	3a 44 e0 	: D . 
	ld (0d91bh),a		;3e21	32 1b d9 	2 . . 
	ld a,(OBYTE2)		;3e24	3a 47 e0 	: G . 
	ld (0d91ch),a		;3e27	32 1c d9 	2 . . 
	xor a			;3e2a	af 	. 
	ld (MBYTE5),a		;3e2b	32 44 e0 	2 D . 
	ld (OBYTE2),a		;3e2e	32 47 e0 	2 G . 
	ret			;3e31	c9 	. 
	xor a			;3e32	af 	. 
	out (BANKSELECT),a		;3e33	d3 70 	. p 
	ld hl,04800h		;3e35	21 00 48 	! . H 
	ld de,0e000h		;3e38	11 00 e0 	. . . 
	ld bc,00111h		;3e3b	01 11 01 	. . . 
	ldir		;3e3e	ed b0 	. . 
	ld a,0e1h		;3e40	3e e1 	> . 
	ld i,a		;3e42	ed 47 	. G 
	call 00042h		;3e44	cd 42 00 	. B . 
	ld a,008h		;3e47	3e 08 	> . 
	out (BANKSELECT),a		;3e49	d3 70 	. p 
	ret			;3e4b	c9 	. 
	ld bc,00000h		;3e4c	01 00 00 	. . . 
	ld l,000h		;3e4f	2e 00 	. . 
	ld a,(hl)			;3e51	7e 	~ 
	ld e,a			;3e52	5f 	_ 
	xor c			;3e53	a9 	. 
	rlca			;3e54	07 	. 
	ld c,a			;3e55	4f 	O 
	ld a,e			;3e56	7b 	{ 
	and 07fh		;3e57	e6 7f 	.  
	xor b			;3e59	a8 	. 
	rlca			;3e5a	07 	. 
	bit 4,a		;3e5b	cb 67 	. g 
	jr z,$+4		;3e5d	28 02 	( . 
	or 001h		;3e5f	f6 01 	. . 
	and 00fh		;3e61	e6 0f 	. . 
	ld b,a			;3e63	47 	G 
	inc hl			;3e64	23 	# 
	ld a,h			;3e65	7c 	| 
	cp d			;3e66	ba 	. 
	jr nz,$-22		;3e67	20 e8 	  . 
	ld a,c			;3e69	79 	y 
	and a			;3e6a	a7 	. 
	ret z			;3e6b	c8 	. 
	ld (0cffch),a		;3e6c	32 fc cf 	2 . . 
	ret			;3e6f	c9 	. 
	ld iy,04051h		;3e70	fd 21 51 40 	. ! Q @ 
	ld hl,0ff00h		;3e74	21 00 ff 	! . . 
	ld b,000h		;3e77	06 00 	. . 
	ld a,055h		;3e79	3e 55 	> U 
	ld (hl),a			;3e7b	77 	w 
	inc hl			;3e7c	23 	# 
	djnz $-2		;3e7d	10 fc 	. . 
	ld hl,0ff00h		;3e7f	21 00 ff 	! . . 
	ld b,000h		;3e82	06 00 	. . 
	ld a,055h		;3e84	3e 55 	> U 
	cp (hl)			;3e86	be 	. 
	jp nz,03ea9h		;3e87	c2 a9 3e 	. . > 
	inc hl			;3e8a	23 	# 
	djnz $-7		;3e8b	10 f7 	. . 
	ld hl,0ff00h		;3e8d	21 00 ff 	! . . 
	ld b,000h		;3e90	06 00 	. . 
	ld a,0aah		;3e92	3e aa 	> . 
	ld (hl),a			;3e94	77 	w 
	inc hl			;3e95	23 	# 
	djnz $-2		;3e96	10 fc 	. . 
	ld hl,0ff00h		;3e98	21 00 ff 	! . . 
	ld b,000h		;3e9b	06 00 	. . 
	ld a,0aah		;3e9d	3e aa 	> . 
	cp (hl)			;3e9f	be 	. 
	jp nz,03ea9h		;3ea0	c2 a9 3e 	. . > 
	inc hl			;3ea3	23 	# 
	djnz $-7		;3ea4	10 f7 	. . 
	xor a			;3ea6	af 	. 
	jp (iy)		;3ea7	fd e9 	. . 
	ld iy,04054h		;3ea9	fd 21 54 40 	. ! T @ 
	ld b,a			;3ead	47 	G 
	ld a,(hl)			;3eae	7e 	~ 
	jp 04015h		;3eaf	c3 15 40 	. . @ 
	nop			;3eb2	00 	. 
	nop			;3eb3	00 	. 
	nop			;3eb4	00 	. 
	nop			;3eb5	00 	. 
	nop			;3eb6	00 	. 
	nop			;3eb7	00 	. 
	nop			;3eb8	00 	. 
	nop			;3eb9	00 	. 
	nop			;3eba	00 	. 
	nop			;3ebb	00 	. 
	nop			;3ebc	00 	. 
	nop			;3ebd	00 	. 
	nop			;3ebe	00 	. 
	nop			;3ebf	00 	. 
	nop			;3ec0	00 	. 
	nop			;3ec1	00 	. 
	nop			;3ec2	00 	. 
	nop			;3ec3	00 	. 
	nop			;3ec4	00 	. 
	nop			;3ec5	00 	. 
	nop			;3ec6	00 	. 
	nop			;3ec7	00 	. 
	nop			;3ec8	00 	. 
	nop			;3ec9	00 	. 
	nop			;3eca	00 	. 
	nop			;3ecb	00 	. 
	nop			;3ecc	00 	. 
	nop			;3ecd	00 	. 
	nop			;3ece	00 	. 
	nop			;3ecf	00 	. 
	nop			;3ed0	00 	. 
	nop			;3ed1	00 	. 
	nop			;3ed2	00 	. 
	nop			;3ed3	00 	. 
	nop			;3ed4	00 	. 
	nop			;3ed5	00 	. 
	nop			;3ed6	00 	. 
	nop			;3ed7	00 	. 
	nop			;3ed8	00 	. 
	nop			;3ed9	00 	. 
	nop			;3eda	00 	. 
	nop			;3edb	00 	. 
	nop			;3edc	00 	. 
	nop			;3edd	00 	. 
	nop			;3ede	00 	. 
	nop			;3edf	00 	. 
	nop			;3ee0	00 	. 
	nop			;3ee1	00 	. 
	nop			;3ee2	00 	. 
	nop			;3ee3	00 	. 
	nop			;3ee4	00 	. 
	nop			;3ee5	00 	. 
	nop			;3ee6	00 	. 
	nop			;3ee7	00 	. 
	nop			;3ee8	00 	. 
	nop			;3ee9	00 	. 
	nop			;3eea	00 	. 
	nop			;3eeb	00 	. 
	nop			;3eec	00 	. 
	nop			;3eed	00 	. 
	nop			;3eee	00 	. 
	nop			;3eef	00 	. 
	nop			;3ef0	00 	. 
	nop			;3ef1	00 	. 
	nop			;3ef2	00 	. 
	nop			;3ef3	00 	. 
	nop			;3ef4	00 	. 
	nop			;3ef5	00 	. 
	nop			;3ef6	00 	. 
	nop			;3ef7	00 	. 
	nop			;3ef8	00 	. 
	nop			;3ef9	00 	. 
	nop			;3efa	00 	. 
	nop			;3efb	00 	. 
	nop			;3efc	00 	. 
	nop			;3efd	00 	. 
	nop			;3efe	00 	. 
	nop			;3eff	00 	. 
	nop			;3f00	00 	. 
	nop			;3f01	00 	. 
	nop			;3f02	00 	. 
	nop			;3f03	00 	. 
	nop			;3f04	00 	. 
	nop			;3f05	00 	. 
	nop			;3f06	00 	. 
	nop			;3f07	00 	. 
	nop			;3f08	00 	. 
	nop			;3f09	00 	. 
	nop			;3f0a	00 	. 
	nop			;3f0b	00 	. 
	nop			;3f0c	00 	. 
	nop			;3f0d	00 	. 
	nop			;3f0e	00 	. 
	nop			;3f0f	00 	. 
	nop			;3f10	00 	. 
	nop			;3f11	00 	. 
	nop			;3f12	00 	. 
	nop			;3f13	00 	. 
	nop			;3f14	00 	. 
	nop			;3f15	00 	. 
	nop			;3f16	00 	. 
	nop			;3f17	00 	. 
	nop			;3f18	00 	. 
	nop			;3f19	00 	. 
	nop			;3f1a	00 	. 
	nop			;3f1b	00 	. 
	nop			;3f1c	00 	. 
	nop			;3f1d	00 	. 
	nop			;3f1e	00 	. 
	nop			;3f1f	00 	. 
	nop			;3f20	00 	. 
	nop			;3f21	00 	. 
	nop			;3f22	00 	. 
	nop			;3f23	00 	. 
	nop			;3f24	00 	. 
	nop			;3f25	00 	. 
	nop			;3f26	00 	. 
	nop			;3f27	00 	. 
	nop			;3f28	00 	. 
	nop			;3f29	00 	. 
	nop			;3f2a	00 	. 
	nop			;3f2b	00 	. 
	nop			;3f2c	00 	. 
	nop			;3f2d	00 	. 
	nop			;3f2e	00 	. 
	nop			;3f2f	00 	. 
	nop			;3f30	00 	. 
	nop			;3f31	00 	. 
	nop			;3f32	00 	. 
	nop			;3f33	00 	. 
	nop			;3f34	00 	. 
	nop			;3f35	00 	. 
	nop			;3f36	00 	. 
	nop			;3f37	00 	. 
	nop			;3f38	00 	. 
	nop			;3f39	00 	. 
	nop			;3f3a	00 	. 
	nop			;3f3b	00 	. 
	nop			;3f3c	00 	. 
	nop			;3f3d	00 	. 
	nop			;3f3e	00 	. 
	nop			;3f3f	00 	. 
	nop			;3f40	00 	. 
	nop			;3f41	00 	. 
	nop			;3f42	00 	. 
	nop			;3f43	00 	. 
	nop			;3f44	00 	. 
	nop			;3f45	00 	. 
	nop			;3f46	00 	. 
	nop			;3f47	00 	. 
	nop			;3f48	00 	. 
	nop			;3f49	00 	. 
	nop			;3f4a	00 	. 
	nop			;3f4b	00 	. 
	nop			;3f4c	00 	. 
	nop			;3f4d	00 	. 
	nop			;3f4e	00 	. 
	nop			;3f4f	00 	. 
	nop			;3f50	00 	. 
	nop			;3f51	00 	. 
	nop			;3f52	00 	. 
	nop			;3f53	00 	. 
	nop			;3f54	00 	. 
	nop			;3f55	00 	. 
	nop			;3f56	00 	. 
	nop			;3f57	00 	. 
	nop			;3f58	00 	. 
	nop			;3f59	00 	. 
	nop			;3f5a	00 	. 
	nop			;3f5b	00 	. 
	nop			;3f5c	00 	. 
	nop			;3f5d	00 	. 
	nop			;3f5e	00 	. 
	nop			;3f5f	00 	. 
	nop			;3f60	00 	. 
	nop			;3f61	00 	. 
	nop			;3f62	00 	. 
	nop			;3f63	00 	. 
	nop			;3f64	00 	. 
	nop			;3f65	00 	. 
	nop			;3f66	00 	. 
	nop			;3f67	00 	. 
	nop			;3f68	00 	. 
	nop			;3f69	00 	. 
	nop			;3f6a	00 	. 
	nop			;3f6b	00 	. 
	nop			;3f6c	00 	. 
	nop			;3f6d	00 	. 
	nop			;3f6e	00 	. 
	nop			;3f6f	00 	. 
	nop			;3f70	00 	. 
	nop			;3f71	00 	. 
	nop			;3f72	00 	. 
	nop			;3f73	00 	. 
	nop			;3f74	00 	. 
	nop			;3f75	00 	. 
	nop			;3f76	00 	. 
	nop			;3f77	00 	. 
	nop			;3f78	00 	. 
	nop			;3f79	00 	. 
	nop			;3f7a	00 	. 
	nop			;3f7b	00 	. 
	nop			;3f7c	00 	. 
	nop			;3f7d	00 	. 
	nop			;3f7e	00 	. 
	nop			;3f7f	00 	. 
	nop			;3f80	00 	. 
	nop			;3f81	00 	. 
	nop			;3f82	00 	. 
	nop			;3f83	00 	. 
	nop			;3f84	00 	. 
	nop			;3f85	00 	. 
	nop			;3f86	00 	. 
	nop			;3f87	00 	. 
	nop			;3f88	00 	. 
	nop			;3f89	00 	. 
	nop			;3f8a	00 	. 
	nop			;3f8b	00 	. 
	nop			;3f8c	00 	. 
	nop			;3f8d	00 	. 
	nop			;3f8e	00 	. 
	nop			;3f8f	00 	. 
	nop			;3f90	00 	. 
	nop			;3f91	00 	. 
	nop			;3f92	00 	. 
	nop			;3f93	00 	. 
	nop			;3f94	00 	. 
	nop			;3f95	00 	. 
	nop			;3f96	00 	. 
	nop			;3f97	00 	. 
	nop			;3f98	00 	. 
	nop			;3f99	00 	. 
	nop			;3f9a	00 	. 
	nop			;3f9b	00 	. 
	nop			;3f9c	00 	. 
	nop			;3f9d	00 	. 
	nop			;3f9e	00 	. 
	nop			;3f9f	00 	. 
	nop			;3fa0	00 	. 
	nop			;3fa1	00 	. 
	nop			;3fa2	00 	. 
	nop			;3fa3	00 	. 
	nop			;3fa4	00 	. 
	nop			;3fa5	00 	. 
	nop			;3fa6	00 	. 
	nop			;3fa7	00 	. 
	nop			;3fa8	00 	. 
	nop			;3fa9	00 	. 
	nop			;3faa	00 	. 
	nop			;3fab	00 	. 
	nop			;3fac	00 	. 
	nop			;3fad	00 	. 
	nop			;3fae	00 	. 
	nop			;3faf	00 	. 
	nop			;3fb0	00 	. 
	nop			;3fb1	00 	. 
	nop			;3fb2	00 	. 
	nop			;3fb3	00 	. 
	nop			;3fb4	00 	. 
	nop			;3fb5	00 	. 
	nop			;3fb6	00 	. 
	nop			;3fb7	00 	. 
	nop			;3fb8	00 	. 
	nop			;3fb9	00 	. 
	nop			;3fba	00 	. 
	nop			;3fbb	00 	. 
	nop			;3fbc	00 	. 
	nop			;3fbd	00 	. 
	nop			;3fbe	00 	. 
	nop			;3fbf	00 	. 
	nop			;3fc0	00 	. 
	nop			;3fc1	00 	. 
	nop			;3fc2	00 	. 
	nop			;3fc3	00 	. 
	nop			;3fc4	00 	. 
	nop			;3fc5	00 	. 
	nop			;3fc6	00 	. 
	nop			;3fc7	00 	. 
	nop			;3fc8	00 	. 
	nop			;3fc9	00 	. 
	nop			;3fca	00 	. 
	nop			;3fcb	00 	. 
	nop			;3fcc	00 	. 
	nop			;3fcd	00 	. 
	nop			;3fce	00 	. 
	nop			;3fcf	00 	. 
	nop			;3fd0	00 	. 
	nop			;3fd1	00 	. 
	nop			;3fd2	00 	. 
	nop			;3fd3	00 	. 
	nop			;3fd4	00 	. 
	nop			;3fd5	00 	. 
	nop			;3fd6	00 	. 
	nop			;3fd7	00 	. 
	nop			;3fd8	00 	. 
	nop			;3fd9	00 	. 
	nop			;3fda	00 	. 
	nop			;3fdb	00 	. 
	nop			;3fdc	00 	. 
	nop			;3fdd	00 	. 
	nop			;3fde	00 	. 
	nop			;3fdf	00 	. 
	nop			;3fe0	00 	. 
	nop			;3fe1	00 	. 
	nop			;3fe2	00 	. 
	nop			;3fe3	00 	. 
	nop			;3fe4	00 	. 
	nop			;3fe5	00 	. 
	nop			;3fe6	00 	. 
	nop			;3fe7	00 	. 
	nop			;3fe8	00 	. 
	nop			;3fe9	00 	. 
	nop			;3fea	00 	. 
	nop			;3feb	00 	. 
	nop			;3fec	00 	. 
	nop			;3fed	00 	. 
	nop			;3fee	00 	. 
	nop			;3fef	00 	. 
	nop			;3ff0	00 	. 
	nop			;3ff1	00 	. 
	nop			;3ff2	00 	. 
	nop			;3ff3	00 	. 
	nop			;3ff4	00 	. 
	nop			;3ff5	00 	. 
	nop			;3ff6	00 	. 
	nop			;3ff7	00 	. 
	nop			;3ff8	00 	. 
	nop			;3ff9	00 	. 
	nop			;3ffa	00 	. 
	nop			;3ffb	00 	. 
	nop			;3ffc	00 	. 
	nop			;3ffd	00 	. 
	nop			;3ffe	00 	. 
	nop			;3fff	00 	. 
; z80dasm 1.1.5
; command line: z80dasm -t -g 0x4000 16krom.bin

	org	04000h

	jp 04018h		;4000	c3 18 40 	. . @ 
	jp 043c0h		;4003	c3 c0 43 	. . C 
	jp 0442dh		;4006	c3 2d 44 	. - D 
	nop			;4009	00 	. 
	nop			;400a	00 	. 
	nop			;400b	00 	. 
	jp 04be4h		;400c	c3 e4 4b 	. . K 
	jp 04b16h		;400f	c3 16 4b 	. . K 
	jp 04a25h		;4012	c3 25 4a 	. % J 
	jp 041a2h		;4015	c3 a2 41 	. . A 
    ; set DTR SWITCHED and RTS SWITCHED in MBYTE
	ld a,003h		;4018	3e 03 	> . 
	ld (MBYTE4),a		;401a	32 43 e0 	2 C . 
	di			;401d	f3 	. 
    ; call INIT00
	call 00003h		;401e	cd 03 00 	. . . 
    ; write 11100000 to PPIC Port A
	ld a,0e0h		;4021	3e e0 	> . 
	out (030h),a		;4023	d3 30 	. 0 

	ld a,(MBYTE5)		;4025	3a 44 e0 	: D . 
	ld (SPFLAG),a		;4028	32 e7 e0 	2 . . 
	ld a,(OBYTE2)		;402b	3a 47 e0 	: G . 
	ld (SAVEB),a		;402e	32 e3 e0 	2 . . 
	ld a,(MBYTE2)		;4031	3a 41 e0 	: A . 
	ld (TIPE),a		;4034	32 ee e0 	2 . . 
	xor a			;4037	af 	. 
	ld (MBYTE5),a		;4038	32 44 e0 	2 D . 
	ld (OBYTE2),a		;403b	32 47 e0 	2 G . 
	ld (MBYTE2),a		;403e	32 41 e0 	2 A . 
	call 03da6h		;4041	cd a6 3d 	. . = 
	jr nc,$+10		;4044	30 08 	0 . 
	ld hl,049d1h		;4046	21 d1 49 	! . I 
	call 04702h		;4049	cd 02 47 	. . G 
	jr $+26		;404c	18 18 	. . 
	jp 03e70h		;404e	c3 70 3e 	. p > 
	call 04144h		;4051	cd 44 41 	. D A 
	push af			;4054	f5 	. 
	call 03e32h		;4055	cd 32 3e 	. 2 > 
	ld a,0e1h		;4058	3e e1 	> . 
	ld i,a		;405a	ed 47 	. G 
	call 00042h		;405c	cd 42 00 	. B . 
	pop af			;405f	f1 	. 
	ld hl,0485eh		;4060	21 5e 48 	! ^ H 
	call c,043e7h		;4063	dc e7 43 	. . C 
	call 041cch		;4066	cd cc 41 	. . A 
	ld hl,04863h		;4069	21 63 48 	! c H 
	call c,043e7h		;406c	dc e7 43 	. . C 
	ld a,060h		;406f	3e 60 	> ` 
	ld (INTMSK),a		;4071	32 a0 e0 	2 . . 
	cpl			;4074	2f 	/ 
	out (031h),a		;4075	d3 31 	. 1 
	call 04232h		;4077	cd 32 42 	. 2 B 
	call 042bfh		;407a	cd bf 42 	. . B 
	call 042feh		;407d	cd fe 42 	. . B 
	call 0429fh		;4080	cd 9f 42 	. . B 
	ld a,(TBYTE2)		;4083	3a 61 e0 	: a . 
	bit 2,a		;4086	cb 57 	. W 
	jr z,$+16		;4088	28 0e 	( . 
	ld a,028h		;408a	3e 28 	> ( 
	out (BANKSELECT),a		;408c	d3 70 	. p 
	ld a,(08009h)		;408e	3a 09 80 	: . . 
	cp 0c3h		;4091	fe c3 	. . 
	jr nz,$+5		;4093	20 03 	  . 
	call 08009h		;4095	cd 09 80 	. . . 
	ld a,008h		;4098	3e 08 	> . 
	out (BANKSELECT),a		;409a	d3 70 	. p 
	ld a,(TBYTE1)		;409c	3a 60 e0 	: ` . 
	bit 2,a		;409f	cb 57 	. W 
	jr z,$+31		;40a1	28 1d 	( . 
	ld hl,04a04h		;40a3	21 04 4a 	! . J 
	xor a			;40a6	af 	. 
	out (084h),a		;40a7	d3 84 	. . 
	out (094h),a		;40a9	d3 94 	. . 
	in a,(086h)		;40ab	db 86 	. . 
	ld c,a			;40ad	4f 	O 
	in a,(096h)		;40ae	db 96 	. . 
	or c			;40b0	b1 	. 
	bit 6,a		;40b1	cb 77 	. w 
	jr z,$+13		;40b3	28 0b 	( . 
	call 00063h		;40b5	cd 63 00 	. c . 
	ld hl,ERRORF		;40b8	21 ff e0 	! . . 
	set 0,(hl)		;40bb	cb c6 	. . 
	call 04b05h		;40bd	cd 05 4b 	. . K 
	call 046ebh		;40c0	cd eb 46 	. . F 
	jr z,$+37		;40c3	28 23 	( # 
	ld hl,ERRORF		;40c5	21 ff e0 	! . . 
	set 0,(hl)		;40c8	cb c6 	. . 
	call 04b05h		;40ca	cd 05 4b 	. . K 
	call 04404h		;40cd	cd 04 44 	. . D 
	ld hl,048f1h		;40d0	21 f1 48 	! . H 
	call nz,04702h		;40d3	c4 02 47 	. . G 
	ld c,020h		;40d6	0e 20 	.   
	ei			;40d8	fb 	. 
	call 0461eh		;40d9	cd 1e 46 	. . F 
	ld hl,049e0h		;40dc	21 e0 49 	! . I 
	call nz,04702h		;40df	c4 02 47 	. . G 
	ld hl,048a1h		;40e2	21 a1 48 	! . H 
	call 00063h		;40e5	cd 63 00 	. c . 
	in a,(026h)		;40e8	db 26 	. & 
	and 040h		;40ea	e6 40 	. @ 
	jr z,$+10		;40ec	28 08 	( . 
	ld a,(08003h)		;40ee	3a 03 80 	: . . 
	cp 0c3h		;40f1	fe c3 	. . 
	call z,08003h		;40f3	cc 03 80 	. . . 
	ld a,(ERRORF)		;40f6	3a ff e0 	: . . 
	bit 2,a		;40f9	cb 57 	. W 
	jr z,$+12		;40fb	28 0a 	( . 
	bit 0,a		;40fd	cb 47 	. G 
	jr nz,$+0		;40ff	20 fe 	  . 
	call 00042h		;4101	cd 42 00 	. B . 
	jp 043d3h		;4104	c3 d3 43 	. . C 
	call 04311h		;4107	cd 11 43 	. . C 
	di			;410a	f3 	. 
	ld a,001h		;410b	3e 01 	> . 
	out (033h),a		;410d	d3 33 	. 3 
	ld hl,04901h		;410f	21 01 49 	! . I 
	call 00063h		;4112	cd 63 00 	. c . 
	ld a,(000deh)		;4115	3a de 00 	: . . 
	ld b,a			;4118	47 	G 
	call 00039h		;4119	cd 39 00 	. 9 . 
	ld hl,0490bh		;411c	21 0b 49 	! . I 
	call 00063h		;411f	cd 63 00 	. c . 
	ld a,(000dfh)		;4122	3a df 00 	: . . 
	ld b,a			;4125	47 	G 
	call 00039h		;4126	cd 39 00 	. 9 . 
	ld a,(SPFLAG)		;4129	3a e7 e0 	: . . 
	ld (MBYTE5),a		;412c	32 44 e0 	2 D . 
	ld a,(SAVEB)		;412f	3a e3 e0 	: . . 
	ld (OBYTE2),a		;4132	32 47 e0 	2 G . 
	ld a,(TIPE)		;4135	3a ee e0 	: . . 
	ld (MBYTE2),a		;4138	32 41 e0 	2 A . 
	call 00012h		;413b	cd 12 00 	. . . 
	call 00018h		;413e	cd 18 00 	. . . 
	jp 03d49h		;4141	c3 49 3d 	. I = 
	pop iy		;4144	fd e1 	. . 
	ld sp,0ffffh		;4146	31 ff ff 	1 . . 
	ld a,049h		;4149	3e 49 	> I 
	ld i,a		;414b	ed 47 	. G 
	ld a,07fh		;414d	3e 7f 	>  
	out (031h),a		;414f	d3 31 	. 1 
	ei			;4151	fb 	. 
	ld b,055h		;4152	06 55 	. U 
	ld h,0c0h		;4154	26 c0 	& . 
	ld d,0feh		;4156	16 fe 	. . 
	call 04165h		;4158	cd 65 41 	. e A 
	ld b,0aah		;415b	06 aa 	. . 
	ld h,0c0h		;415d	26 c0 	& . 
	call 04165h		;415f	cd 65 41 	. e A 
	di			;4162	f3 	. 
	jr $+87		;4163	18 55 	. U 
	ld l,000h		;4165	2e 00 	. . 
	push hl			;4167	e5 	. 
	ld (hl),b			;4168	70 	p 
	inc hl			;4169	23 	# 
	ld a,h			;416a	7c 	| 
	cp d			;416b	ba 	. 
	jr nz,$-4		;416c	20 fa 	  . 
	pop hl			;416e	e1 	. 
	ld a,(hl)			;416f	7e 	~ 
	cp b			;4170	b8 	. 
	jr nz,$+49		;4171	20 2f 	  / 
	inc hl			;4173	23 	# 
	ld a,h			;4174	7c 	| 
	cp d			;4175	ba 	. 
	jr nz,$-7		;4176	20 f7 	  . 
	ret			;4178	c9 	. 
	ld a,01eh		;4179	3e 1e 	> . 
	out (BANKSELECT),a		;417b	d3 70 	. p 
	ld hl,0c03dh		;417d	21 3d c0 	! = . 
	ld (0e10eh),hl		;4180	22 0e e1 	" . . 
	ld a,0e1h		;4183	3e e1 	> . 
	ld i,a		;4185	ed 47 	. G 
	ei			;4187	fb 	. 
	ld h,000h		;4188	26 00 	& . 
	ld d,0c0h		;418a	16 c0 	. . 
	ld b,055h		;418c	06 55 	. U 
	call 0c000h		;418e	cd 00 c0 	. . . 
	ld h,000h		;4191	26 00 	& . 
	ld b,0aah		;4193	06 aa 	. . 
	call 0c000h		;4195	cd 00 c0 	. . . 
	di			;4198	f3 	. 
	ld sp,0e000h		;4199	31 00 e0 	1 . . 
	ld a,008h		;419c	3e 08 	> . 
	out (BANKSELECT),a		;419e	d3 70 	. p 
	jp (iy)		;41a0	fd e9 	. . 
	di			;41a2	f3 	. 
	ld c,a			;41a3	4f 	O 
	ld a,0c0h		;41a4	3e c0 	> . 
	out (030h),a		;41a6	d3 30 	. 0 
	ld a,0e0h		;41a8	3e e0 	> . 
	out (030h),a		;41aa	d3 30 	. 0 
	ld a,008h		;41ac	3e 08 	> . 
	out (BANKSELECT),a		;41ae	d3 70 	. p 
	out (0ffh),a		;41b0	d3 ff 	. . 
	ld sp,0e000h		;41b2	31 00 e0 	1 . . 
	push bc			;41b5	c5 	. 
	push hl			;41b6	e5 	. 
	scf			;41b7	37 	7 
	jp (iy)		;41b8	fd e9 	. . 
	xor a			;41ba	af 	. 
	ld sp,0e000h		;41bb	31 00 e0 	1 . . 
	ld hl,04165h		;41be	21 65 41 	! e A 
	ld de,0c000h		;41c1	11 00 c0 	. . . 
	ld bc,00100h		;41c4	01 00 01 	. . . 
	ldir		;41c7	ed b0 	. . 
	jp 0c014h		;41c9	c3 14 c0 	. . . 
	pop iy		;41cc	fd e1 	. . 
	xor a			;41ce	af 	. 
	ld a,(TBYTE3)		;41cf	3a 62 e0 	: b . 
	bit 0,a		;41d2	cb 47 	. G 
	jr z,$-28		;41d4	28 e2 	( . 
	ld a,060h		;41d6	3e 60 	> ` 
	out (030h),a		;41d8	d3 30 	. 0 
	out (0fdh),a		;41da	d3 fd 	. . 
	ld a,0fah		;41dc	3e fa 	> . 
	out (BANKSELECT),a		;41de	d3 70 	. p 
	ld sp,03fffh		;41e0	31 ff 3f 	1 . ? 
	ld b,055h		;41e3	06 55 	. U 
	ld h,080h		;41e5	26 80 	& . 
	ld d,000h		;41e7	16 00 	. . 
	call 04165h		;41e9	cd 65 41 	. e A 
	ld b,0aah		;41ec	06 aa 	. . 
	ld h,080h		;41ee	26 80 	& . 
	call 04165h		;41f0	cd 65 41 	. e A 
	xor a			;41f3	af 	. 
	ld (08000h),a		;41f4	32 00 80 	2 . . 
	out (0fch),a		;41f7	d3 fc 	. . 
	ld hl,00fffh		;41f9	21 ff 0f 	! . . 
	in a,(0fdh)		;41fc	db fd 	. . 
	bit 0,a		;41fe	cb 47 	. G 
	jr z,$+31		;4200	28 1d 	( . 
	in a,(0fdh)		;4202	db fd 	. . 
	bit 0,a		;4204	cb 47 	. G 
	jr z,$+9		;4206	28 07 	( . 
	call 04725h		;4208	cd 25 47 	. % G 
	jr nz,$-9		;420b	20 f5 	  . 
	jr $+18		;420d	18 10 	. . 
	ld hl,08000h		;420f	21 00 80 	! . . 
	ld bc,08000h		;4212	01 00 80 	. . . 
	xor a			;4215	af 	. 
	cpi		;4216	ed a1 	. . 
	jr nz,$+7		;4218	20 05 	  . 
	jp po,04229h		;421a	e2 29 42 	. ) B 
	jr $-7		;421d	18 f7 	. . 
	ld a,008h		;421f	3e 08 	> . 
	out (BANKSELECT),a		;4221	d3 70 	. p 
	ld hl,04863h		;4223	21 63 48 	! c H 
	call 04702h		;4226	cd 02 47 	. . G 
	ld a,0e0h		;4229	3e e0 	> . 
	out (030h),a		;422b	d3 30 	. 0 
	out (0ffh),a		;422d	d3 ff 	. . 
	jp 04198h		;422f	c3 98 41 	. . A 
	xor a			;4232	af 	. 
	ld (0cffch),a		;4233	32 fc cf 	2 . . 
	ld h,000h		;4236	26 00 	& . 
	ld d,020h		;4238	16 20 	.   
	call 03e4ch		;423a	cd 4c 3e 	. L > 
	ld (0cfe3h),a		;423d	32 e3 cf 	2 . . 
	ld h,040h		;4240	26 40 	& @ 
	ld d,050h		;4242	16 50 	. P 
	call 03e4ch		;4244	cd 4c 3e 	. L > 
	ld (0cfe2h),a		;4247	32 e2 cf 	2 . . 
	ld h,020h		;424a	26 20 	&   
	ld d,040h		;424c	16 40 	. @ 
	call 03e4ch		;424e	cd 4c 3e 	. L > 
	ld (0cfe1h),a		;4251	32 e1 cf 	2 . . 
	ld a,(0cffch)		;4254	3a fc cf 	: . . 
	and a			;4257	a7 	. 
	jr z,$+24		;4258	28 16 	( . 
	ld hl,0486dh		;425a	21 6d 48 	! m H 
	call 04702h		;425d	cd 02 47 	. . G 
	ld hl,0cfe3h		;4260	21 e3 cf 	! . . 
	ld b,003h		;4263	06 03 	. . 
	push bc			;4265	c5 	. 
	push hl			;4266	e5 	. 
	ld a,(hl)			;4267	7e 	~ 
	call 046fah		;4268	cd fa 46 	. . F 
	pop hl			;426b	e1 	. 
	dec hl			;426c	2b 	+ 
	pop bc			;426d	c1 	. 
	djnz $-9		;426e	10 f5 	. . 
	ld hl,04000h		;4270	21 00 40 	! . @ 
	ld d,041h		;4273	16 41 	. A 
	call 03e0ch		;4275	cd 0c 3e 	. . > 
	ld a,b			;4278	78 	x 
	and a			;4279	a7 	. 
	ld hl,04872h		;427a	21 72 48 	! r H 
	call nz,04702h		;427d	c4 02 47 	. . G 
	ld a,0f0h		;4280	3e f0 	> . 
	ld (0cff3h),a		;4282	32 f3 cf 	2 . . 
	call 04750h		;4285	cd 50 47 	. P G 
	ld c,040h		;4288	0e 40 	. @ 
	call 0461eh		;428a	cd 1e 46 	. . F 
	ld hl,0487ah		;428d	21 7a 48 	! z H 
	call nz,04702h		;4290	c4 02 47 	. . G 
	ld c,020h		;4293	0e 20 	.   
	call 0461eh		;4295	cd 1e 46 	. . F 
	ret z			;4298	c8 	. 
	ld hl,04883h		;4299	21 83 48 	! . H 
	jp 04702h		;429c	c3 02 47 	. . G 
	ld a,(TBYTE1)		;429f	3a 60 e0 	: ` . 
	bit 2,a		;42a2	cb 57 	. W 
	ret z			;42a4	c8 	. 
	call 047c6h		;42a5	cd c6 47 	. . G 
	ld c,080h		;42a8	0e 80 	. . 
	call 0461eh		;42aa	cd 1e 46 	. . F 
	ld hl,0491dh		;42ad	21 1d 49 	! . I 
	call nz,04702h		;42b0	c4 02 47 	. . G 
	ld c,090h		;42b3	0e 90 	. . 
	call 0461eh		;42b5	cd 1e 46 	. . F 
	ret z			;42b8	c8 	. 
	ld hl,04912h		;42b9	21 12 49 	! . I 
	jp 04702h		;42bc	c3 02 47 	. . G 
	ld a,000h		;42bf	3e 00 	> . 
	ld (T3RUN),a		;42c1	32 f3 e0 	2 . . 
	ld de,042efh		;42c4	11 ef 42 	. . B 
	ld c,006h		;42c7	0e 06 	. . 
	ld b,040h		;42c9	06 40 	. @ 
	call 0001eh		;42cb	cd 1e 00 	. . . 
	ei			;42ce	fb 	. 
	call 00090h		;42cf	cd 90 00 	. . . 
	call 042dch		;42d2	cd dc 42 	. . B 
	ld hl,0488dh		;42d5	21 8d 48 	! . H 
	call nz,04702h		;42d8	c4 02 47 	. . G 
	ret			;42db	c9 	. 
	ld de,0ffffh		;42dc	11 ff ff 	. . . 
	xor a			;42df	af 	. 
	ld (0cfe5h),a		;42e0	32 e5 cf 	2 . . 
	ld a,(0cfe5h)		;42e3	3a e5 cf 	: . . 
	cp 055h		;42e6	fe 55 	. U 
	ret z			;42e8	c8 	. 
	inc de			;42e9	13 	. 
	bit 7,d		;42ea	cb 7a 	. z 
	jr z,$-9		;42ec	28 f5 	( . 
	ret			;42ee	c9 	. 
	push af			;42ef	f5 	. 
	ld a,033h		;42f0	3e 33 	> 3 
	out (PPIC+PPIC_CONTROL),a		;42f2	d3 03 	. . 
	out (PPIC+PPIC_PORTA),a		;42f4	d3 00 	. . 
	ld a,055h		;42f6	3e 55 	> U 
	ld (0cfe5h),a		;42f8	32 e5 cf 	2 . . 
	pop af			;42fb	f1 	. 
	retn		;42fc	ed 45 	. E 
	xor a			;42fe	af 	. 
	out (024h),a		;42ff	d3 24 	. $ 
	in a,(026h)		;4301	db 26 	. & 
	bit 7,a		;4303	cb 7f 	.  
	ret z			;4305	c8 	. 
	ld hl,ERRORF		;4306	21 ff e0 	! . . 
	set 1,(hl)		;4309	cb ce 	. . 
	ld hl,04894h		;430b	21 94 48 	! . H 
	jp 00063h		;430e	c3 63 00 	. c . 
	ld a,000h		;4311	3e 00 	> . 
	out (033h),a		;4313	d3 33 	. 3 
	call 0431fh		;4315	cd 1f 43 	. . C 
	ld a,002h		;4318	3e 02 	> . 
	out (024h),a		;431a	d3 24 	. $ 
	call 04322h		;431c	cd 22 43 	. " C 
	xor a			;431f	af 	. 
	out (024h),a		;4320	d3 24 	. $ 
	ld hl,04fffh		;4322	21 ff 4f 	! . O 
	call 04725h		;4325	cd 25 47 	. % G 
	jr nz,$-3		;4328	20 fb 	  . 
	ret			;432a	c9 	. 
	di			;432b	f3 	. 
	ld a,004h		;432c	3e 04 	> . 
	out (0abh),a		;432e	d3 ab 	. . 
	ld a,00ah		;4330	3e 0a 	> . 
	out (0abh),a		;4332	d3 ab 	. . 
	ld a,055h		;4334	3e 55 	> U 
	out (0aah),a		;4336	d3 aa 	. . 
	in a,(0aah)		;4338	db aa 	. . 
	ld b,a			;433a	47 	G 
	call 043b4h		;433b	cd b4 43 	. . C 
	ld a,b			;433e	78 	x 
	cp 055h		;433f	fe 55 	. U 
	jr nz,$+125		;4341	20 7b 	  { 
	ld a,00ah		;4343	3e 0a 	> . 
	out (0abh),a		;4345	d3 ab 	. . 
	ld a,0aah		;4347	3e aa 	> . 
	out (0aah),a		;4349	d3 aa 	. . 
	in a,(0aah)		;434b	db aa 	. . 
	ld b,a			;434d	47 	G 
	call 043b4h		;434e	cd b4 43 	. . C 
	ld a,b			;4351	78 	x 
	xor 0aah		;4352	ee aa 	. . 
	jr nz,$+106		;4354	20 68 	  h 
	ld a,e			;4356	7b 	{ 
	bit 1,a		;4357	cb 4f 	. O 
	jr z,$+101		;4359	28 63 	( c 
	ld a,002h		;435b	3e 02 	> . 
	out (0abh),a		;435d	d3 ab 	. . 
	ret			;435f	c9 	. 
	di			;4360	f3 	. 
	ld b,040h		;4361	06 40 	. @ 
	ld a,008h		;4363	3e 08 	> . 
	out (0afh),a		;4365	d3 af 	. . 
	dec b			;4367	05 	. 
	jr z,$+86		;4368	28 54 	( T 
	call 04bc8h		;436a	cd c8 4b 	. . K 
	call 043b1h		;436d	cd b1 43 	. . C 
	xor 048h		;4370	ee 48 	. H 
	jr nz,$-11		;4372	20 f3 	  . 
	ld a,0f7h		;4374	3e f7 	> . 
	out (0afh),a		;4376	d3 af 	. . 
	ld de,0ffffh		;4378	11 ff ff 	. . . 
	dec de			;437b	1b 	. 
	ld a,d			;437c	7a 	z 
	or e			;437d	b3 	. 
	jr z,$+64		;437e	28 3e 	( > 
	call 04bc8h		;4380	cd c8 4b 	. . K 
	call 043b1h		;4383	cd b1 43 	. . C 
	cp 040h		;4386	fe 40 	. @ 
	jr nz,$-13		;4388	20 f1 	  . 
	ld b,a			;438a	47 	G 
	ld a,004h		;438b	3e 04 	> . 
	out (0afh),a		;438d	d3 af 	. . 
	dec b			;438f	05 	. 
	jr z,$+46		;4390	28 2c 	( , 
	call 04bc8h		;4392	cd c8 4b 	. . K 
	call 043b1h		;4395	cd b1 43 	. . C 
	xor 048h		;4398	ee 48 	. H 
	jr nz,$-11		;439a	20 f3 	  . 
	ld b,040h		;439c	06 40 	. @ 
	ld a,0fbh		;439e	3e fb 	> . 
	out (0afh),a		;43a0	d3 af 	. . 
	dec b			;43a2	05 	. 
	jr z,$+27		;43a3	28 19 	( . 
	call 04bc8h		;43a5	cd c8 4b 	. . K 
	call 043b1h		;43a8	cd b1 43 	. . C 
	xor 04ah		;43ab	ee 4a 	. J 
	jr nz,$-11		;43ad	20 f3 	  . 
	xor a			;43af	af 	. 
	ret			;43b0	c9 	. 
	in a,(0afh)		;43b1	db af 	. . 
	ld c,a			;43b3	4f 	O 
	in a,(088h)		;43b4	db 88 	. . 
	ld e,a			;43b6	5f 	_ 
	bit 0,a		;43b7	cb 47 	. G 
	jr nz,$+4		;43b9	20 02 	  . 
	ld a,c			;43bb	79 	y 
	ret			;43bc	c9 	. 
	pop hl			;43bd	e1 	. 
	scf			;43be	37 	7 
	ret			;43bf	c9 	. 
	ld a,(KBINP)		;43c0	3a c9 e0 	: . . 
	bit 0,a		;43c3	cb 47 	. G 
	jr z,$+14		;43c5	28 0c 	( . 
	ld a,(OBYTE1)		;43c7	3a 46 e0 	: F . 
	bit 0,a		;43ca	cb 47 	. G 
	jr z,$+22		;43cc	28 14 	( . 
	ld a,004h		;43ce	3e 04 	> . 
	ld (ERRORF),a		;43d0	32 ff e0 	2 . . 
	di			;43d3	f3 	. 
	ld a,(ERRORF)		;43d4	3a ff e0 	: . . 
	and 004h		;43d7	e6 04 	. . 
	ld (ERRORF),a		;43d9	32 ff e0 	2 . . 
	call 04610h		;43dc	cd 10 46 	. . F 
	jp 0401eh		;43df	c3 1e 40 	. . @ 
	pop ix		;43e2	dd e1 	. . 
	jp 03d49h		;43e4	c3 49 3d 	. I = 
	pop iy		;43e7	fd e1 	. . 
	call 04702h		;43e9	cd 02 47 	. . G 
	pop hl			;43ec	e1 	. 
	push hl			;43ed	e5 	. 
	ld a,h			;43ee	7c 	| 
	call 04716h		;43ef	cd 16 47 	. . G 
	pop hl			;43f2	e1 	. 
	ld a,l			;43f3	7d 	} 
	call 046fah		;43f4	cd fa 46 	. . F 
	pop bc			;43f7	c1 	. 
	push bc			;43f8	c5 	. 
	ld a,c			;43f9	79 	y 
	call 046fah		;43fa	cd fa 46 	. . F 
	pop bc			;43fd	c1 	. 
	ld a,b			;43fe	78 	x 
	call 04716h		;43ff	cd 16 47 	. . G 
	jp (iy)		;4402	fd e9 	. . 
	ld c,006h		;4404	0e 06 	. . 
	ld b,040h		;4406	06 40 	. @ 
	ld de,042efh		;4408	11 ef 42 	. . B 
	call 0001eh		;440b	cd 1e 00 	. . . 
	ei			;440e	fb 	. 
	xor a			;440f	af 	. 
	out (PPIC+PPIC_PORTA),a		;4410	d3 00 	. . 
	ld a,033h		;4412	3e 33 	> 3 
	out (PPIC+PPIC_PORTA),a		;4414	d3 00 	. . 
	ld a,0f7h		;4416	3e f7 	> . 
	out (PPIC+PPIC_PORTA),a		;4418	d3 00 	. . 
	ld a,0bbh		;441a	3e bb 	> . 
	out (PPIC+PPIC_PORTA),a		;441c	d3 00 	. . 
	call 042dch		;441e	cd dc 42 	. . B 
	ld a,033h		;4421	3e 33 	> 3 
	out (PPIC+PPIC_PORTA),a		;4423	d3 00 	. . 
	ret			;4425	c9 	. 
	jr nz,$+67		;4426	20 41 	  A 
	ld h,c			;4428	61 	a 
	add a,b			;4429	80 	. 
	and b			;442a	a0 	. 
	ret nz			;442b	c0 	. 
	nop			;442c	00 	. 
	call 00006h		;442d	cd 06 00 	. . . 
	call 04610h		;4430	cd 10 46 	. . F 
	ld c,005h		;4433	0e 05 	. . 
	ld b,020h		;4435	06 20 	.   
	ld de,00024h		;4437	11 24 00 	. $ . 
	call 0001eh		;443a	cd 1e 00 	. . . 
	ld a,(TBYTE3)		;443d	3a 62 e0 	: b . 
	bit 0,a		;4440	cb 47 	. G 
	jr z,$+47		;4442	28 2d 	( - 
	call 04518h		;4444	cd 18 45 	. . E 
	ei			;4447	fb 	. 
	ld a,040h		;4448	3e 40 	> @ 
	out (030h),a		;444a	d3 30 	. 0 
	out (0fdh),a		;444c	d3 fd 	. . 
	ld a,0f8h		;444e	3e f8 	> . 
	out (BANKSELECT),a		;4450	d3 70 	. p 
	ld a,055h		;4452	3e 55 	> U 
	ld (08000h),a		;4454	32 00 80 	2 . . 
	ld a,008h		;4457	3e 08 	> . 
	out (BANKSELECT),a		;4459	d3 70 	. p 
	out (0fch),a		;445b	d3 fc 	. . 
	out (0feh),a		;445d	d3 fe 	. . 
	call 045f6h		;445f	cd f6 45 	. . E 
	jr nz,$+9		;4462	20 07 	  . 
	in a,(0feh)		;4464	db fe 	. . 
	call 045f6h		;4466	cd f6 45 	. . E 
	jr z,$-12		;4469	28 f2 	( . 
	out (0ffh),a		;446b	d3 ff 	. . 
	ld a,0c0h		;446d	3e c0 	> . 
	out (030h),a		;446f	d3 30 	. 0 
	xor a			;4471	af 	. 
	ld (OBYTE1),a		;4472	32 46 e0 	2 F . 
	ld (MBYTE5),a		;4475	32 44 e0 	2 D . 
	ld (OBYTE2),a		;4478	32 47 e0 	2 G . 
	call 0000ch		;447b	cd 0c 00 	. . . 
	ld b,000h		;447e	06 00 	. . 
	call 0001bh		;4480	cd 1b 00 	. . . 
	ld b,002h		;4483	06 02 	. . 
	call 0001bh		;4485	cd 1b 00 	. . . 
	ei			;4488	fb 	. 
	ld c,004h		;4489	0e 04 	. . 
	ld b,010h		;448b	06 10 	. . 
	ld de,047f6h		;448d	11 f6 47 	. . G 
	call 0001eh		;4490	cd 1e 00 	. . . 
	ei			;4493	fb 	. 
	call 00042h		;4494	cd 42 00 	. B . 
	call 00054h		;4497	cd 54 00 	. T . 
	call 04729h		;449a	cd 29 47 	. ) G 
	ld bc,01c00h		;449d	01 00 1c 	. . . 
	call 04605h		;44a0	cd 05 46 	. . F 
	call 04729h		;44a3	cd 29 47 	. ) G 
	ld b,000h		;44a6	06 00 	. . 
	call 04609h		;44a8	cd 09 46 	. . F 
	ld b,01eh		;44ab	06 1e 	. . 
	push bc			;44ad	c5 	. 
	call 04736h		;44ae	cd 36 47 	. 6 G 
	call 00054h		;44b1	cd 54 00 	. T . 
	pop bc			;44b4	c1 	. 
	djnz $-8		;44b5	10 f6 	. . 
	call 0007eh		;44b7	cd 7e 00 	. ~ . 
	call 00054h		;44ba	cd 54 00 	. T . 
	call 046c5h		;44bd	cd c5 46 	. . F 
	ld e,007h		;44c0	1e 07 	. . 
	ld b,000h		;44c2	06 00 	. . 
	ld hl,04426h		;44c4	21 26 44 	! & D 
	push de			;44c7	d5 	. 
	push hl			;44c8	e5 	. 
	ld c,(hl)			;44c9	4e 	N 
	call 046bbh		;44ca	cd bb 46 	. . F 
	pop hl			;44cd	e1 	. 
	inc hl			;44ce	23 	# 
	pop de			;44cf	d1 	. 
	dec e			;44d0	1d 	. 
	jr nz,$-10		;44d1	20 f4 	  . 
	ld hl,04806h		;44d3	21 06 48 	! . H 
	call 00063h		;44d6	cd 63 00 	. c . 
	call 046c5h		;44d9	cd c5 46 	. . F 
	ld hl,0483ah		;44dc	21 3a 48 	! : H 
	call 00063h		;44df	cd 63 00 	. c . 
	call 046c5h		;44e2	cd c5 46 	. . F 
	ld hl,04849h		;44e5	21 49 48 	! I H 
	call 00063h		;44e8	cd 63 00 	. c . 
	call 046c5h		;44eb	cd c5 46 	. . F 
	ld hl,048b6h		;44ee	21 b6 48 	! . H 
	call 00063h		;44f1	cd 63 00 	. c . 
	ld a,0feh		;44f4	3e fe 	> . 
	ld (0cff3h),a		;44f6	32 f3 cf 	2 . . 
	ld hl,00fffh		;44f9	21 ff 0f 	! . . 
	push hl			;44fc	e5 	. 
	ld a,(KBCNT)		;44fd	3a 89 e0 	: . . 
	cp 000h		;4500	fe 00 	. . 
	call nz,046ach		;4502	c4 ac 46 	. . F 
	call 046ebh		;4505	cd eb 46 	. . F 
	jr nz,$+26		;4508	20 18 	  . 
	pop hl			;450a	e1 	. 
	call 04725h		;450b	cd 25 47 	. % G 
	jr nz,$-18		;450e	20 ec 	  . 
	ld a,(0cff3h)		;4510	3a f3 cf 	: . . 
	out (050h),a		;4513	d3 50 	. P 
	rlca			;4515	07 	. 
	jr $-32		;4516	18 de 	. . 
	ld a,05fh		;4518	3e 5f 	> _ 
	out (013h),a		;451a	d3 13 	. . 
	xor a			;451c	af 	. 
	out (01ah),a		;451d	d3 1a 	. . 
	out (01eh),a		;451f	d3 1e 	. . 
	ret			;4521	c9 	. 
	ld b,010h		;4522	06 10 	. . 
	call 0001bh		;4524	cd 1b 00 	. . . 
	call 00042h		;4527	cd 42 00 	. B . 
	ld hl,048eeh		;452a	21 ee 48 	! . H 
	call 00063h		;452d	cd 63 00 	. c . 
	call 04404h		;4530	cd 04 44 	. . D 
	ld hl,048eeh		;4533	21 ee 48 	! . H 
	call nz,04702h		;4536	c4 02 47 	. . G 
	ld a,(TBYTE1)		;4539	3a 60 e0 	: ` . 
	bit 3,a		;453c	cb 5f 	. _ 
	jr z,$+7		;453e	28 05 	( . 
	call 0432bh		;4540	cd 2b 43 	. + C 
	jr $+12		;4543	18 0a 	. . 
	ld a,(TBYTE2)		;4545	3a 61 e0 	: a . 
	bit 0,a		;4548	cb 47 	. G 
	jr z,$+18		;454a	28 10 	( . 
	call 04360h		;454c	cd 60 43 	. ` C 
	ld hl,04932h		;454f	21 32 49 	! 2 I 
	jr nc,$+7		;4552	30 05 	0 . 
	call 0470dh		;4554	cd 0d 47 	. . G 
	jr $+5		;4557	18 03 	. . 
	call 00063h		;4559	cd 63 00 	. c . 
	call 04750h		;455c	cd 50 47 	. P G 
	call 047c6h		;455f	cd c6 47 	. . G 
	ld hl,04880h		;4562	21 80 48 	! . H 
	call 045edh		;4565	cd ed 45 	. . E 
	xor a			;4568	af 	. 
	call 045dch		;4569	cd dc 45 	. . E 
	ld hl,04877h		;456c	21 77 48 	! w H 
	ld c,046h		;456f	0e 46 	. F 
	ld b,000h		;4571	06 00 	. . 
	call 045e5h		;4573	cd e5 45 	. . E 
	ld a,(TBYTE1)		;4576	3a 60 e0 	: ` . 
	bit 2,a		;4579	cb 57 	. W 
	jr z,$+22		;457b	28 14 	( . 
	ld hl,0491ah		;457d	21 1a 49 	! . I 
	ld c,086h		;4580	0e 86 	. . 
	ld b,040h		;4582	06 40 	. @ 
	call 045e5h		;4584	cd e5 45 	. . E 
	ld hl,0490fh		;4587	21 0f 49 	! . I 
	ld c,096h		;458a	0e 96 	. . 
	ld b,040h		;458c	06 40 	. @ 
	call 045e5h		;458e	cd e5 45 	. . E 
	ld a,00fh		;4591	3e 0f 	> . 
	call 045dch		;4593	cd dc 45 	. . E 
	ei			;4596	fb 	. 
	ld c,020h		;4597	0e 20 	.   
	call 0461eh		;4599	cd 1e 46 	. . F 
	ld hl,04880h		;459c	21 80 48 	! . H 
	call nz,0470dh		;459f	c4 0d 47 	. . G 
	ld a,0f0h		;45a2	3e f0 	> . 
	ld (0cff3h),a		;45a4	32 f3 cf 	2 . . 
	ld c,040h		;45a7	0e 40 	. @ 
	call 0461eh		;45a9	cd 1e 46 	. . F 
	ld hl,04877h		;45ac	21 77 48 	! w H 
	call nz,0470dh		;45af	c4 0d 47 	. . G 
	ld a,(TBYTE1)		;45b2	3a 60 e0 	: ` . 
	bit 2,a		;45b5	cb 57 	. W 
	jr z,$+29		;45b7	28 1b 	( . 
	ld a,0b0h		;45b9	3e b0 	> . 
	ld (0cff3h),a		;45bb	32 f3 cf 	2 . . 
	ld c,080h		;45be	0e 80 	. . 
	call 0461eh		;45c0	cd 1e 46 	. . F 
	ld hl,0491ah		;45c3	21 1a 49 	! . I 
	call nz,0470dh		;45c6	c4 0d 47 	. . G 
	ld c,090h		;45c9	0e 90 	. . 
	call 0461eh		;45cb	cd 1e 46 	. . F 
	ld hl,0490fh		;45ce	21 0f 49 	! . I 
	call nz,0470dh		;45d1	c4 0d 47 	. . G 
	call 046ebh		;45d4	cd eb 46 	. . F 
	jp z,0442dh		;45d7	ca 2d 44 	. - D 
	jr $-73		;45da	18 b5 	. . 
	out (024h),a		;45dc	d3 24 	. $ 
	out (044h),a		;45de	d3 44 	. D 
	out (094h),a		;45e0	d3 94 	. . 
	out (084h),a		;45e2	d3 84 	. . 
	ret			;45e4	c9 	. 
	in a,(c)		;45e5	ed 78 	. x 
	and 0f0h		;45e7	e6 f0 	. . 
	cp b			;45e9	b8 	. 
	jp nz,0470dh		;45ea	c2 0d 47 	. . G 
	call 00063h		;45ed	cd 63 00 	. c . 
	ld hl,049c8h		;45f0	21 c8 49 	! . I 
	jp 00063h		;45f3	c3 63 00 	. c . 
	ld hl,0ffffh		;45f6	21 ff ff 	! . . 
	call 04725h		;45f9	cd 25 47 	. % G 
	ret z			;45fc	c8 	. 
	ld a,(KBCNT)		;45fd	3a 89 e0 	: . . 
	bit 1,a		;4600	cb 4f 	. O 
	jr z,$-9		;4602	28 f5 	( . 
	ret			;4604	c9 	. 
	ld a,c			;4605	79 	y 
	ld (CHRCNT),a		;4606	32 b1 e0 	2 . . 
	ld a,b			;4609	78 	x 
	ld (LNCNT),a		;460a	32 d1 e0 	2 . . 
	jp 0008dh		;460d	c3 8d 00 	. . . 
	call 0000ch		;4610	cd 0c 00 	. . . 
	ld a,05dh		;4613	3e 5d 	> ] 
	out (013h),a		;4615	d3 13 	. . 
	ld a,00bh		;4617	3e 0b 	> . 
	out (015h),a		;4619	d3 15 	. . 
	jp 0451ch		;461b	c3 1c 45 	. . E 
	ld b,c			;461e	41 	A 
	ld a,006h		;461f	3e 06 	> . 
	add a,c			;4621	81 	. 
	ld c,a			;4622	4f 	O 
	in a,(c)		;4623	ed 78 	. x 
	ld c,b			;4625	48 	H 
	ld a,001h		;4626	3e 01 	> . 
	add a,b			;4628	80 	. 
	ld c,a			;4629	4f 	O 
	ld a,001h		;462a	3e 01 	> . 
	out (c),a		;462c	ed 79 	. y 
	ld d,000h		;462e	16 00 	. . 
	ld c,b			;4630	48 	H 
	in a,(c)		;4631	ed 78 	. x 
	in a,(c)		;4633	ed 78 	. x 
	ld a,005h		;4635	3e 05 	> . 
	add a,b			;4637	80 	. 
	ld c,a			;4638	4f 	O 
	ld hl,07fffh		;4639	21 ff 7f 	! .  
	call 04725h		;463c	cd 25 47 	. % G 
	jr z,$+92		;463f	28 5a 	( Z 
	in a,(c)		;4641	ed 78 	. x 
	and 060h		;4643	e6 60 	. ` 
	cp 060h		;4645	fe 60 	. ` 
	jr nz,$-11		;4647	20 f3 	  . 
	ld a,006h		;4649	3e 06 	> . 
	add a,b			;464b	80 	. 
	ld c,a			;464c	4f 	O 
	in a,(c)		;464d	ed 78 	. x 
	and 0f0h		;464f	e6 f0 	. . 
	ld l,a			;4651	6f 	o 
	ld a,(0cff3h)		;4652	3a f3 cf 	: . . 
	cp l			;4655	bd 	. 
	jr z,$+7		;4656	28 05 	( . 
	ld a,b			;4658	78 	x 
	cp 020h		;4659	fe 20 	.   
	jr nz,$+64		;465b	20 3e 	  > 
	ld c,b			;465d	48 	H 
	out (c),d		;465e	ed 51 	. Q 
	ld hl,07fffh		;4660	21 ff 7f 	! .  
	call 04725h		;4663	cd 25 47 	. % G 
	jr z,$+53		;4666	28 33 	( 3 
	ld a,(0cfe5h)		;4668	3a e5 cf 	: . . 
	xor 0aah		;466b	ee aa 	. . 
	jr nz,$-10		;466d	20 f4 	  . 
	ld (0cfe5h),a		;466f	32 e5 cf 	2 . . 
	ld a,002h		;4672	3e 02 	> . 
	add a,b			;4674	80 	. 
	ld c,a			;4675	4f 	O 
	in a,(c)		;4676	ed 78 	. x 
	and 006h		;4678	e6 06 	. . 
	jr z,$+33		;467a	28 1f 	( . 
	ld a,005h		;467c	3e 05 	> . 
	add a,b			;467e	80 	. 
	ld c,a			;467f	4f 	O 
	in a,(c)		;4680	ed 78 	. x 
	bit 0,a		;4682	cb 47 	. G 
	jr z,$+23		;4684	28 15 	( . 
	and 01eh		;4686	e6 1e 	. . 
	and a			;4688	a7 	. 
	jr nz,$+18		;4689	20 10 	  . 
	ld c,b			;468b	48 	H 
	in a,(c)		;468c	ed 78 	. x 
	and 07fh		;468e	e6 7f 	.  
	xor d			;4690	aa 	. 
	ei			;4691	fb 	. 
	jr nz,$+9		;4692	20 07 	  . 
	inc d			;4694	14 	. 
	bit 7,d		;4695	cb 7a 	. z 
	jr nz,$+10		;4697	20 08 	  . 
	jr $-100		;4699	18 9a 	. . 
	ld c,b			;469b	48 	H 
	in a,(c)		;469c	ed 78 	. x 
	ei			;469e	fb 	. 
	ld a,001h		;469f	3e 01 	> . 
	or a			;46a1	b7 	. 
	ret			;46a2	c9 	. 
	push af			;46a3	f5 	. 
	ld a,0aah		;46a4	3e aa 	> . 
	ld (0cfe5h),a		;46a6	32 e5 cf 	2 . . 
	pop af			;46a9	f1 	. 
	reti		;46aa	ed 4d 	. M 
	ld bc,01313h		;46ac	01 13 13 	. . . 
	call 04605h		;46af	cd 05 46 	. . F 
	call 0006fh		;46b2	cd 6f 00 	. o . 
	ld a,b			;46b5	78 	x 
	call 04716h		;46b6	cd 16 47 	. . G 
	retn		;46b9	ed 45 	. E 
	push bc			;46bb	c5 	. 
	call 0005ah		;46bc	cd 5a 00 	. Z . 
	pop bc			;46bf	c1 	. 
	inc b			;46c0	04 	. 
	ld a,b			;46c1	78 	x 
	cp c			;46c2	b9 	. 
	jr nz,$-8		;46c3	20 f6 	  . 
	ld a,(LNCNT)		;46c5	3a d1 e0 	: . . 
	add a,002h		;46c8	c6 02 	. . 
	ld (LNCNT),a		;46ca	32 d1 e0 	2 . . 
	ld a,005h		;46cd	3e 05 	> . 
	ld (CHRCNT),a		;46cf	32 b1 e0 	2 . . 
	push bc			;46d2	c5 	. 
	call 0008dh		;46d3	cd 8d 00 	. . . 
	pop bc			;46d6	c1 	. 
	ret			;46d7	c9 	. 
	ld b,a			;46d8	47 	G 
	and 0f0h		;46d9	e6 f0 	. . 
	rrca			;46db	0f 	. 
	rrca			;46dc	0f 	. 
	rrca			;46dd	0f 	. 
	rrca			;46de	0f 	. 
	call 00066h		;46df	cd 66 00 	. f . 
	ld d,a			;46e2	57 	W 
	ld a,b			;46e3	78 	x 
	and 00fh		;46e4	e6 0f 	. . 
	call 00066h		;46e6	cd 66 00 	. f . 
	ld e,a			;46e9	5f 	_ 
	ret			;46ea	c9 	. 
	ld a,003h		;46eb	3e 03 	> . 
	out (044h),a		;46ed	d3 44 	. D 
	in a,(024h)		;46ef	db 24 	. $ 
	and 00fh		;46f1	e6 0f 	. . 
	out (024h),a		;46f3	d3 24 	. $ 
	in a,(026h)		;46f5	db 26 	. & 
	bit 4,a		;46f7	cb 67 	. g 
	ret			;46f9	c9 	. 
	call 04716h		;46fa	cd 16 47 	. . G 
	ld b,020h		;46fd	06 20 	.   
	jp 00039h		;46ff	c3 39 00 	. 9 . 
	call 04b05h		;4702	cd 05 4b 	. . K 
	ld a,(ERRORF)		;4705	3a ff e0 	: . . 
	or 001h		;4708	f6 01 	. . 
	ld (ERRORF),a		;470a	32 ff e0 	2 . . 
	call 00063h		;470d	cd 63 00 	. c . 
	ld hl,048e4h		;4710	21 e4 48 	! . H 
	jp 00063h		;4713	c3 63 00 	. c . 
	call 046d8h		;4716	cd d8 46 	. . F 
	push de			;4719	d5 	. 
	ld a,d			;471a	7a 	z 
	ld b,a			;471b	47 	G 
	call 00039h		;471c	cd 39 00 	. 9 . 
	pop de			;471f	d1 	. 
	ld a,e			;4720	7b 	{ 
	ld b,a			;4721	47 	G 
	jp 00039h		;4722	c3 39 00 	. 9 . 
	dec hl			;4725	2b 	+ 
	ld a,h			;4726	7c 	| 
	or a			;4727	b7 	. 
	ret			;4728	c9 	. 
	ld d,050h		;4729	16 50 	. P 
	ld b,0bdh		;472b	06 bd 	. . 
	push de			;472d	d5 	. 
	call 0005ah		;472e	cd 5a 00 	. Z . 
	pop de			;4731	d1 	. 
	dec d			;4732	15 	. 
	jr nz,$-8		;4733	20 f6 	  . 
	ret			;4735	c9 	. 
	ld a,003h		;4736	3e 03 	> . 
	ld (CHRCNT),a		;4738	32 b1 e0 	2 . . 
	call 0008dh		;473b	cd 8d 00 	. . . 
	ld b,0bfh		;473e	06 bf 	. . 
	call 0005ah		;4740	cd 5a 00 	. Z . 
	ld a,04ch		;4743	3e 4c 	> L 
	ld (CHRCNT),a		;4745	32 b1 e0 	2 . . 
	call 0008dh		;4748	cd 8d 00 	. . . 
	ld b,0bfh		;474b	06 bf 	. . 
	jp 0005ah		;474d	c3 5a 00 	. Z . 
	ld a,(TBAUD)		;4750	3a 58 e0 	: X . 
	push af			;4753	f5 	. 
	ld a,(RBAUD)		;4754	3a 59 e0 	: Y . 
	push af			;4757	f5 	. 
	ld a,00ah		;4758	3e 0a 	> . 
	ld (TBAUD),a		;475a	32 58 e0 	2 X . 
	ld (RBAUD),a		;475d	32 59 e0 	2 Y . 
	ld a,(OBYTE2)		;4760	3a 47 e0 	: G . 
	push af			;4763	f5 	. 
	xor a			;4764	af 	. 
	ld (OBYTE2),a		;4765	32 47 e0 	2 G . 
	call 00012h		;4768	cd 12 00 	. . . 
	ld c,005h		;476b	0e 05 	. . 
	ld b,020h		;476d	06 20 	.   
	ld de,046a3h		;476f	11 a3 46 	. . F 
	call 0001eh		;4772	cd 1e 00 	. . . 
	ld a,(MBYTE3)		;4775	3a 42 e0 	: B . 
	push af			;4778	f5 	. 
	ld a,002h		;4779	3e 02 	> . 
	ld (MBYTE3),a		;477b	32 42 e0 	2 B . 
	call 00015h		;477e	cd 15 00 	. . . 
	pop af			;4781	f1 	. 
	ld (MBYTE3),a		;4782	32 42 e0 	2 B . 
	pop af			;4785	f1 	. 
	ld (OBYTE2),a		;4786	32 47 e0 	2 G . 
	pop af			;4789	f1 	. 
	ld (RBAUD),a		;478a	32 59 e0 	2 Y . 
	pop af			;478d	f1 	. 
	ld (TBAUD),a		;478e	32 58 e0 	2 X . 
	ld a,01fh		;4791	3e 1f 	> . 
	out (044h),a		;4793	d3 44 	. D 
	out (024h),a		;4795	d3 24 	. $ 
	ld a,01fh		;4797	3e 1f 	> . 
	out (084h),a		;4799	d3 84 	. . 
	out (094h),a		;479b	d3 94 	. . 
	ld hl,07fffh		;479d	21 ff 7f 	! .  
	call 04725h		;47a0	cd 25 47 	. % G 
	jr nz,$-3		;47a3	20 fb 	  . 
	ld (0cfe5h),a		;47a5	32 e5 cf 	2 . . 
	in a,(045h)		;47a8	db 45 	. E 
	in a,(040h)		;47aa	db 40 	. @ 
	in a,(040h)		;47ac	db 40 	. @ 
	in a,(085h)		;47ae	db 85 	. . 
	in a,(080h)		;47b0	db 80 	. . 
	in a,(080h)		;47b2	db 80 	. . 
	in a,(095h)		;47b4	db 95 	. . 
	in a,(090h)		;47b6	db 90 	. . 
	in a,(090h)		;47b8	db 90 	. . 
	ld c,000h		;47ba	0e 00 	. . 
	ld b,001h		;47bc	06 01 	. . 
	ld de,046a3h		;47be	11 a3 46 	. . F 
	call 0001eh		;47c1	cd 1e 00 	. . . 
	ei			;47c4	fb 	. 
	ret			;47c5	c9 	. 
	ld a,(CHABD)		;47c6	3a 6f e0 	: o . 
	push af			;47c9	f5 	. 
	ld a,(CHBBD)		;47ca	3a 71 e0 	: q . 
	push af			;47cd	f5 	. 
	ld a,00ah		;47ce	3e 0a 	> . 
	ld (CHABD),a		;47d0	32 6f e0 	2 o . 
	ld (CHBBD),a		;47d3	32 71 e0 	2 q . 
	ld hl,0c000h		;47d6	21 00 c0 	! . . 
	call 00075h		;47d9	cd 75 00 	. u . 
	ld hl,0c000h		;47dc	21 00 c0 	! . . 
	call 00078h		;47df	cd 78 00 	. x . 
	pop af			;47e2	f1 	. 
	ld (CHBBD),a		;47e3	32 71 e0 	2 q . 
	pop af			;47e6	f1 	. 
	ld (CHABD),a		;47e7	32 6f e0 	2 o . 
	ld c,002h		;47ea	0e 02 	. . 
	ld b,004h		;47ec	06 04 	. . 
	ld de,046a3h		;47ee	11 a3 46 	. . F 
	call 0001eh		;47f1	cd 1e 00 	. . . 
	jr $-93		;47f4	18 a1 	. . 
	push af			;47f6	f5 	. 
	exx			;47f7	d9 	. 
	call 0009fh		;47f8	cd 9f 00 	. . . 
	ld a,b			;47fb	78 	x 
	ld (0cffdh),a		;47fc	32 fd cf 	2 . . 
	call 0008ah		;47ff	cd 8a 00 	. . . 
	exx			;4802	d9 	. 
	pop af			;4803	f1 	. 
	ei			;4804	fb 	. 
	ret			;4805	c9 	. 
	inc bc			;4806	03 	. 
	ld c,042h		;4807	0e 42 	. B 
	ld c,h			;4809	4c 	L 
	ld c,c			;480a	49 	I 
	ld c,(hl)			;480b	4e 	N 
	ld c,e			;480c	4b 	K 
	jr nz,$+17		;480d	20 0f 	  . 
	inc e			;480f	1c 	. 
	ld b,h			;4810	44 	D 
	ld c,c			;4811	49 	I 
	ld c,l			;4812	4d 	M 
	jr nz,$+31		;4813	20 1d 	  . 
	inc d			;4815	14 	. 
	ld d,l			;4816	55 	U 
	ld c,(hl)			;4817	4e 	N 
	ld b,h			;4818	44 	D 
	ld b,l			;4819	45 	E 
	ld d,d			;481a	52 	R 
	ld d,e			;481b	53 	S 
	ld b,e			;481c	43 	C 
	ld c,a			;481d	4f 	O 
	ld d,d			;481e	52 	R 
	ld b,l			;481f	45 	E 
	dec d			;4820	15 	. 
	jr nz,$+32		;4821	20 1e 	  . 
	ld b,h			;4823	44 	D 
	ld c,c			;4824	49 	I 
	ld c,(hl)			;4825	4e 	N 
	ld d,(hl)			;4826	56 	V 
	ld b,l			;4827	45 	E 
	ld d,d			;4828	52 	R 
	ld d,e			;4829	53 	S 
	ld b,l			;482a	45 	E 
	ld e,045h		;482b	1e 45 	. E 
	jr nz,$+32		;482d	20 1e 	  . 
	ld (de),a			;482f	12 	. 
	ld e,e			;4830	5b 	[ 
	ld b,d			;4831	42 	B 
	ld c,h			;4832	4c 	L 
	ld b,c			;4833	41 	A 
	ld c,(hl)			;4834	4e 	N 
	ld c,e			;4835	4b 	K 
	ld e,012h		;4836	1e 12 	. . 
	ld e,h			;4838	5c 	\ 
	rst 38h			;4839	ff 	. 
	ld c,e			;483a	4b 	K 
	ld b,l			;483b	45 	E 
	ld e,c			;483c	59 	Y 
	ld b,d			;483d	42 	B 
	ld c,a			;483e	4f 	O 
	ld b,c			;483f	41 	A 
	ld d,d			;4840	52 	R 
	ld b,h			;4841	44 	D 
	jr nz,$+86		;4842	20 54 	  T 
	ld b,l			;4844	45 	E 
	ld d,e			;4845	53 	S 
	ld d,h			;4846	54 	T 
	ld a,(bc)			;4847	0a 	. 
	rst 38h			;4848	ff 	. 
	ld d,h			;4849	54 	T 
	ld c,a			;484a	4f 	O 
	ld d,l			;484b	55 	U 
	ld b,e			;484c	43 	C 
	ld c,b			;484d	48 	H 
	jr nz,$+82		;484e	20 50 	  P 
	ld b,c			;4850	41 	A 
	ld c,(hl)			;4851	4e 	N 
	ld b,l			;4852	45 	E 
	ld c,h			;4853	4c 	L 
	jr nz,$+71		;4854	20 45 	  E 
	ld c,(hl)			;4856	4e 	N 
	ld b,c			;4857	41 	A 
	ld b,d			;4858	42 	B 
	ld c,h			;4859	4c 	L 
	ld b,l			;485a	45 	E 
	ld b,h			;485b	44 	D 
	ld a,(bc)			;485c	0a 	. 
	rst 38h			;485d	ff 	. 
	ld a,(bc)			;485e	0a 	. 
	ld d,d			;485f	52 	R 
	ld b,c			;4860	41 	A 
	ld c,l			;4861	4d 	M 
	rst 38h			;4862	ff 	. 
	ld a,(bc)			;4863	0a 	. 
	ld b,a			;4864	47 	G 
	ld d,d			;4865	52 	R 
	ld b,c			;4866	41 	A 
	ld d,b			;4867	50 	P 
	ld c,b			;4868	48 	H 
	ld c,c			;4869	49 	I 
	ld b,e			;486a	43 	C 
	ld d,e			;486b	53 	S 
	rst 38h			;486c	ff 	. 
	ld a,(bc)			;486d	0a 	. 
	ld d,d			;486e	52 	R 
	ld c,a			;486f	4f 	O 
	ld c,l			;4870	4d 	M 
	rst 38h			;4871	ff 	. 
	ld a,(bc)			;4872	0a 	. 
	ld c,(hl)			;4873	4e 	N 
	ld d,(hl)			;4874	56 	V 
	ld c,l			;4875	4d 	M 
	rst 38h			;4876	ff 	. 
	djnz $+5		;4877	10 03 	. . 
	ld a,(bc)			;4879	0a 	. 
	ld a,(bc)			;487a	0a 	. 
	ld b,e			;487b	43 	C 
	ld c,a			;487c	4f 	O 
	ld c,l			;487d	4d 	M 
	ld c,l			;487e	4d 	M 
	rst 38h			;487f	ff 	. 
	djnz $+5		;4880	10 03 	. . 
	inc c			;4882	0c 	. 
	ld a,(bc)			;4883	0a 	. 
	ld c,e			;4884	4b 	K 
	ld b,l			;4885	45 	E 
	ld e,c			;4886	59 	Y 
	ld b,d			;4887	42 	B 
	ld c,a			;4888	4f 	O 
	ld b,c			;4889	41 	A 
	ld d,d			;488a	52 	R 
	ld b,h			;488b	44 	D 
	rst 38h			;488c	ff 	. 
	ld a,(bc)			;488d	0a 	. 
	ld d,h			;488e	54 	T 
	ld c,c			;488f	49 	I 
	ld c,l			;4890	4d 	M 
	ld b,l			;4891	45 	E 
	ld d,d			;4892	52 	R 
	rst 38h			;4893	ff 	. 
	ld a,(bc)			;4894	0a 	. 
	ld b,d			;4895	42 	B 
	ld b,c			;4896	41 	A 
	ld d,h			;4897	54 	T 
	ld d,h			;4898	54 	T 
	ld b,l			;4899	45 	E 
	ld d,d			;489a	52 	R 
	ld e,c			;489b	59 	Y 
	jr nz,$+78		;489c	20 4c 	  L 
	ld c,a			;489e	4f 	O 
	ld d,a			;489f	57 	W 
	rst 38h			;48a0	ff 	. 
	ld a,(bc)			;48a1	0a 	. 
	ld d,h			;48a2	54 	T 
	ld b,l			;48a3	45 	E 
	ld d,e			;48a4	53 	S 
	ld d,h			;48a5	54 	T 
	jr nz,$+85		;48a6	20 53 	  S 
	ld d,a			;48a8	57 	W 
	ld c,c			;48a9	49 	I 
	ld d,h			;48aa	54 	T 
	ld b,e			;48ab	43 	C 
	ld c,b			;48ac	48 	H 
	jr nz,$+71		;48ad	20 45 	  E 
	ld c,(hl)			;48af	4e 	N 
	ld b,c			;48b0	41 	A 
	ld b,d			;48b1	42 	B 
	ld c,h			;48b2	4c 	L 
	ld b,l			;48b3	45 	E 
	ld b,h			;48b4	44 	D 
	rst 38h			;48b5	ff 	. 
	ld d,h			;48b6	54 	T 
	ld c,a			;48b7	4f 	O 
	jr nz,$+84		;48b8	20 52 	  R 
	ld d,l			;48ba	55 	U 
	ld c,(hl)			;48bb	4e 	N 
	jr nz,$+71		;48bc	20 45 	  E 
	ld e,b			;48be	58 	X 
	ld d,h			;48bf	54 	T 
	ld b,l			;48c0	45 	E 
	ld d,d			;48c1	52 	R 
	ld c,(hl)			;48c2	4e 	N 
	ld b,c			;48c3	41 	A 
	ld c,h			;48c4	4c 	L 
	jr nz,$+78		;48c5	20 4c 	  L 
	ld c,a			;48c7	4f 	O 
	ld c,a			;48c8	4f 	O 
	ld d,b			;48c9	50 	P 
	ld b,d			;48ca	42 	B 
	ld b,c			;48cb	41 	A 
	ld b,e			;48cc	43 	C 
	ld c,e			;48cd	4b 	K 
	dec l			;48ce	2d 	- 
	ld b,l			;48cf	45 	E 
	ld c,(hl)			;48d0	4e 	N 
	ld b,c			;48d1	41 	A 
	ld b,d			;48d2	42 	B 
	ld c,h			;48d3	4c 	L 
	ld b,l			;48d4	45 	E 
	jr nz,$+86		;48d5	20 54 	  T 
	ld b,l			;48d7	45 	E 
	ld d,e			;48d8	53 	S 
	ld d,h			;48d9	54 	T 
	jr nz,$+85		;48da	20 53 	  S 
	ld d,a			;48dc	57 	W 
	ld c,c			;48dd	49 	I 
	ld d,h			;48de	54 	T 
	ld b,e			;48df	43 	C 
	ld c,b			;48e0	48 	H 
	ld b,l			;48e1	45 	E 
	ld d,e			;48e2	53 	S 
	rst 38h			;48e3	ff 	. 
	jr nz,$+72		;48e4	20 46 	  F 
	ld b,c			;48e6	41 	A 
	ld c,c			;48e7	49 	I 
	ld c,h			;48e8	4c 	L 
	jr nz,$+34		;48e9	20 20 	    
	jr nz,$+34		;48eb	20 20 	    
	rst 38h			;48ed	ff 	. 
	djnz $+2		;48ee	10 00 	. . 
	dec b			;48f0	05 	. 
	ld a,(bc)			;48f1	0a 	. 
	ld c,e			;48f2	4b 	K 
	ld b,d			;48f3	42 	B 
	ld b,h			;48f4	44 	D 
	jr nz,$+69		;48f5	20 43 	  C 
	ld c,h			;48f7	4c 	L 
	ld c,a			;48f8	4f 	O 
	ld b,e			;48f9	43 	C 
	ld c,e			;48fa	4b 	K 
	jr nz,$+81		;48fb	20 4f 	  O 
	ld c,e			;48fd	4b 	K 
	add hl,de			;48fe	19 	. 
	add hl,de			;48ff	19 	. 
	rst 38h			;4900	ff 	. 
	ld a,(bc)			;4901	0a 	. 
	ld d,d			;4902	52 	R 
	ld b,l			;4903	45 	E 
	ld d,e			;4904	53 	S 
	jr nz,$+84		;4905	20 52 	  R 
	ld b,l			;4907	45 	E 
	ld d,(hl)			;4908	56 	V 
	jr nz,$+1		;4909	20 ff 	  . 
	ld l,0ffh		;490b	2e ff 	. . 
	ld a,(bc)			;490d	0a 	. 
	rst 38h			;490e	ff 	. 
	djnz $+5		;490f	10 03 	. . 
	djnz $+12		;4911	10 0a 	. . 
	ld d,b			;4913	50 	P 
	ld c,a			;4914	4f 	O 
	ld d,d			;4915	52 	R 
	ld d,h			;4916	54 	T 
	jr nz,$+68		;4917	20 42 	  B 
	rst 38h			;4919	ff 	. 
	djnz $+5		;491a	10 03 	. . 
	ld c,00ah		;491c	0e 0a 	. . 
	ld d,b			;491e	50 	P 
	ld c,a			;491f	4f 	O 
	ld d,d			;4920	52 	R 
	ld d,h			;4921	54 	T 
	jr nz,$+67		;4922	20 41 	  A 
	rst 38h			;4924	ff 	. 
	djnz $+32		;4925	10 1e 	. . 
	rla			;4927	17 	. 
	ld b,h			;4928	44 	D 
	ld c,c			;4929	49 	I 
	ld d,e			;492a	53 	S 
	ld c,e			;492b	4b 	K 
	jr nz,$+78		;492c	20 4c 	  L 
	ld c,a			;492e	4f 	O 
	ld b,c			;492f	41 	A 
	ld b,h			;4930	44 	D 
	rst 38h			;4931	ff 	. 
	djnz $+2		;4932	10 00 	. . 
	rlca			;4934	07 	. 
	ld d,b			;4935	50 	P 
	ld b,c			;4936	41 	A 
	ld d,d			;4937	52 	R 
	ld b,c			;4938	41 	A 
	ld c,h			;4939	4c 	L 
	ld c,h			;493a	4c 	L 
	ld b,l			;493b	45 	E 
	ld c,h			;493c	4c 	L 
	jr nz,$+82		;493d	20 50 	  P 
	ld c,a			;493f	4f 	O 
	ld d,d			;4940	52 	R 
	ld d,h			;4941	54 	T 
	jr nz,$+81		;4942	20 4f 	  O 
	ld c,e			;4944	4b 	K 
	add hl,de			;4945	19 	. 
	add hl,de			;4946	19 	. 
	rst 38h			;4947	ff 	. 
	djnz $+12		;4948	10 0a 	. . 
	rla			;494a	17 	. 
	ld d,e			;494b	53 	S 
	ld b,l			;494c	45 	E 
	ld c,h			;494d	4c 	L 
	ld b,l			;494e	45 	E 
	ld b,e			;494f	43 	C 
	ld d,h			;4950	54 	T 
	jr nz,$+78		;4951	20 4c 	  L 
	ld c,a			;4953	4f 	O 
	ld b,c			;4954	41 	A 
	ld b,h			;4955	44 	D 
	jr nz,$+85		;4956	20 53 	  S 
	ld c,a			;4958	4f 	O 
	ld d,l			;4959	55 	U 
	ld d,d			;495a	52 	R 
	ld b,e			;495b	43 	C 
	ld b,l			;495c	45 	E 
	jr nz,$+64		;495d	20 3e 	  > 
	jr nz,$+34		;495f	20 20 	    
	inc d			;4961	14 	. 
	ld b,h			;4962	44 	D 
	dec d			;4963	15 	. 
	ld c,c			;4964	49 	I 
	ld d,e			;4965	53 	S 
	ld c,e			;4966	4b 	K 
	jr nz,$+34		;4967	20 20 	    
	inc d			;4969	14 	. 
	ld c,b			;496a	48 	H 
	dec d			;496b	15 	. 
	ld c,a			;496c	4f 	O 
	ld d,e			;496d	53 	S 
	ld d,h			;496e	54 	T 
	jr nz,$+34		;496f	20 20 	    
	inc d			;4971	14 	. 
	ld d,d			;4972	52 	R 
	dec d			;4973	15 	. 
	ld c,a			;4974	4f 	O 
	ld c,l			;4975	4d 	M 
	rst 38h			;4976	ff 	. 
	djnz $+5		;4977	10 03 	. . 
	rla			;4979	17 	. 
	ld d,e			;497a	53 	S 
	ld b,l			;497b	45 	E 
	ld c,h			;497c	4c 	L 
	ld b,l			;497d	45 	E 
	ld b,e			;497e	43 	C 
	ld d,h			;497f	54 	T 
	jr nz,$+72		;4980	20 46 	  F 
	ld c,c			;4982	49 	I 
	ld c,h			;4983	4c 	L 
	ld b,l			;4984	45 	E 
	jr nz,$+80		;4985	20 4e 	  N 
	ld c,a			;4987	4f 	O 
	ld l,020h		;4988	2e 20 	.   
	ld e,a			;498a	5f 	_ 
	jr nz,$+1		;498b	20 ff 	  . 
	djnz $+5		;498d	10 03 	. . 
	rla			;498f	17 	. 
	ld c,h			;4990	4c 	L 
	ld c,a			;4991	4f 	O 
	ld b,c			;4992	41 	A 
	ld b,h			;4993	44 	D 
	ld c,c			;4994	49 	I 
	ld c,(hl)			;4995	4e 	N 
	ld b,a			;4996	47 	G 
	jr nz,$+72		;4997	20 46 	  F 
	ld c,c			;4999	49 	I 
	ld c,h			;499a	4c 	L 
	ld b,l			;499b	45 	E 
	jr nz,$+1		;499c	20 ff 	  . 
	djnz $+5		;499e	10 03 	. . 
	rla			;49a0	17 	. 
	ld c,(hl)			;49a1	4e 	N 
	ld c,a			;49a2	4f 	O 
	jr nz,$+84		;49a3	20 52 	  R 
	ld b,l			;49a5	45 	E 
	ld d,b			;49a6	50 	P 
	ld c,h			;49a7	4c 	L 
	ld e,c			;49a8	59 	Y 
	rst 38h			;49a9	ff 	. 
	jr nz,$+68		;49aa	20 42 	  B 
	ld c,h			;49ac	4c 	L 
	ld c,a			;49ad	4f 	O 
	ld b,e			;49ae	43 	C 
	ld c,e			;49af	4b 	K 
	jr nz,$+1		;49b0	20 ff 	  . 
	djnz $+5		;49b2	10 03 	. . 
	rla			;49b4	17 	. 
	ld c,b			;49b5	48 	H 
	ld c,a			;49b6	4f 	O 
	ld d,e			;49b7	53 	S 
	ld d,h			;49b8	54 	T 
	jr nz,$+80		;49b9	20 4e 	  N 
	ld c,a			;49bb	4f 	O 
	ld d,h			;49bc	54 	T 
	jr nz,$+69		;49bd	20 43 	  C 
	ld c,a			;49bf	4f 	O 
	ld c,(hl)			;49c0	4e 	N 
	ld c,(hl)			;49c1	4e 	N 
	ld b,l			;49c2	45 	E 
	ld b,e			;49c3	43 	C 
	ld d,h			;49c4	54 	T 
	ld b,l			;49c5	45 	E 
	ld b,h			;49c6	44 	D 
	rst 38h			;49c7	ff 	. 
	jr nz,$+84		;49c8	20 52 	  R 
	ld d,l			;49ca	55 	U 
	ld c,(hl)			;49cb	4e 	N 
	ld c,(hl)			;49cc	4e 	N 
	ld c,c			;49cd	49 	I 
	ld c,(hl)			;49ce	4e 	N 
	ld b,a			;49cf	47 	G 
	rst 38h			;49d0	ff 	. 
	ld a,(bc)			;49d1	0a 	. 
	ld b,e			;49d2	43 	C 
	ld c,b			;49d3	48 	H 
	ld b,c			;49d4	41 	A 
	ld d,d			;49d5	52 	R 
	ld b,c			;49d6	41 	A 
	ld b,e			;49d7	43 	C 
	ld d,h			;49d8	54 	T 
	ld b,l			;49d9	45 	E 
	ld d,d			;49da	52 	R 
	jr nz,$+84		;49db	20 52 	  R 
	ld b,c			;49dd	41 	A 
	ld c,l			;49de	4d 	M 
	rst 38h			;49df	ff 	. 
	ld a,(bc)			;49e0	0a 	. 
	ld b,l			;49e1	45 	E 
	ld e,b			;49e2	58 	X 
	ld d,h			;49e3	54 	T 
	jr nz,$+77		;49e4	20 4b 	  K 
	ld b,d			;49e6	42 	B 
	ld b,h			;49e7	44 	D 
	jr nz,$+78		;49e8	20 4c 	  L 
	ld c,a			;49ea	4f 	O 
	ld c,a			;49eb	4f 	O 
	ld d,b			;49ec	50 	P 
	ld b,d			;49ed	42 	B 
	ld b,c			;49ee	41 	A 
	ld b,e			;49ef	43 	C 
	ld c,e			;49f0	4b 	K 
	rst 38h			;49f1	ff 	. 
	djnz $+2		;49f2	10 00 	. . 
	rla			;49f4	17 	. 
	dec bc			;49f5	0b 	. 
	rst 38h			;49f6	ff 	. 
	djnz $+32		;49f7	10 1e 	. . 
	rla			;49f9	17 	. 
	ld c,b			;49fa	48 	H 
	ld c,a			;49fb	4f 	O 
	ld d,e			;49fc	53 	S 
	ld d,h			;49fd	54 	T 
	jr nz,$+78		;49fe	20 4c 	  L 
	ld c,a			;4a00	4f 	O 
	ld b,c			;4a01	41 	A 
	ld b,h			;4a02	44 	D 
	rst 38h			;4a03	ff 	. 
	ld a,(bc)			;4a04	0a 	. 
	ld d,e			;4a05	53 	S 
	ld b,l			;4a06	45 	E 
	ld d,d			;4a07	52 	R 
	ld c,c			;4a08	49 	I 
	ld b,c			;4a09	41 	A 
	ld c,h			;4a0a	4c 	L 
	jr nz,$+82		;4a0b	20 50 	  P 
	ld c,a			;4a0d	4f 	O 
	ld d,d			;4a0e	52 	R 
	ld d,h			;4a0f	54 	T 
	jr nz,$+86		;4a10	20 54 	  T 
	ld b,l			;4a12	45 	E 
	ld d,e			;4a13	53 	S 
	ld d,h			;4a14	54 	T 
	jr nz,$+85		;4a15	20 53 	  S 
	ld d,a			;4a17	57 	W 
	ld c,c			;4a18	49 	I 
	ld d,h			;4a19	54 	T 
	ld b,e			;4a1a	43 	C 
	ld c,b			;4a1b	48 	H 
	jr nz,$+71		;4a1c	20 45 	  E 
	ld c,(hl)			;4a1e	4e 	N 
	ld b,c			;4a1f	41 	A 
	ld b,d			;4a20	42 	B 
	ld c,h			;4a21	4c 	L 
	ld b,l			;4a22	45 	E 
	ld b,h			;4a23	44 	D 
	rst 38h			;4a24	ff 	. 
	call 00042h		;4a25	cd 42 00 	. B . 
	ld a,(MDACT)		;4a28	3a fe e0 	: . . 
	and 007h		;4a2b	e6 07 	. . 
	cp 001h		;4a2d	fe 01 	. . 
	jp nz,04a39h		;4a2f	c2 39 4a 	. 9 J 
	ld ix,00030h		;4a32	dd 21 30 00 	. ! 0 . 
	jp 04ad9h		;4a36	c3 d9 4a 	. . J 
	ld ix,04a40h		;4a39	dd 21 40 4a 	. ! @ J 
	jp 04ad9h		;4a3d	c3 d9 4a 	. . J 
	ld a,008h		;4a40	3e 08 	> . 
	out (BANKSELECT),a		;4a42	d3 70 	. p 
	call 03e17h		;4a44	cd 17 3e 	. . > 
	ld a,(MBYTE1)		;4a47	3a 40 e0 	: @ . 
	bit 2,a		;4a4a	cb 57 	. W 
	jr z,$+72		;4a4c	28 46 	( F 
	xor a			;4a4e	af 	. 
	ld (0cffdh),a		;4a4f	32 fd cf 	2 . . 
	ld c,004h		;4a52	0e 04 	. . 
	ld b,010h		;4a54	06 10 	. . 
	ld de,047f6h		;4a56	11 f6 47 	. . G 
	call 0001eh		;4a59	cd 1e 00 	. . . 
	ei			;4a5c	fb 	. 
	ld hl,04948h		;4a5d	21 48 49 	! H I 
	call 04cbah		;4a60	cd ba 4c 	. . L 
	call 04f72h		;4a63	cd 72 4f 	. r O 
	jr c,$+26		;4a66	38 18 	8 . 
	ld hl,0cffdh		;4a68	21 fd cf 	! . . 
	ld a,(hl)			;4a6b	7e 	~ 
	ld (hl),000h		;4a6c	36 00 	6 . 
	cp 063h		;4a6e	fe 63 	. c 
	jr z,$+84		;4a70	28 52 	( R 
	cp 073h		;4a72	fe 73 	. s 
	jp z,04bdch		;4a74	ca dc 4b 	. . K 
	cp 093h		;4a77	fe 93 	. . 
	jr z,$+31		;4a79	28 1d 	( . 
	call 0007eh		;4a7b	cd 7e 00 	. ~ . 
	jr $-27		;4a7e	18 e3 	. . 
	cp 064h		;4a80	fe 64 	. d 
	jr z,$+66		;4a82	28 40 	( @ 
	cp 072h		;4a84	fe 72 	. r 
	jr z,$+18		;4a86	28 10 	( . 
	cp 068h		;4a88	fe 68 	. h 
	jp z,04bdch		;4a8a	ca dc 4b 	. . K 
	cp 0e3h		;4a8d	fe e3 	. . 
	jr nz,$-44		;4a8f	20 d2 	  . 
	ld a,(MBYTE1)		;4a91	3a 40 e0 	: @ . 
	bit 3,a		;4a94	cb 5f 	. _ 
	jr nz,$+39		;4a96	20 25 	  % 
	ld a,(MBYTE6)		;4a98	3a 45 e0 	: E . 
	bit 3,a		;4a9b	cb 5f 	. _ 
	call z,04fe7h		;4a9d	cc e7 4f 	. . O 
	jp z,00030h		;4aa0	ca 30 00 	. 0 . 
	in a,(026h)		;4aa3	db 26 	. & 
	and 040h		;4aa5	e6 40 	. @ 
	jp z,00072h		;4aa7	ca 72 00 	. r . 
	ld a,(08000h)		;4aaa	3a 00 80 	: . . 
	cp 0c3h		;4aad	fe c3 	. . 
	jp nz,00072h		;4aaf	c2 72 00 	. r . 
	ld b,004h		;4ab2	06 04 	. . 
	call 04fe7h		;4ab4	cd e7 4f 	. . O 
	call 04b0ch		;4ab7	cd 0c 4b 	. . K 
	jp 08000h		;4aba	c3 00 80 	. . . 
	ld a,(MBYTE2)		;4abd	3a 41 e0 	: A . 
	bit 0,a		;4ac0	cb 47 	. G 
	jr z,$+20		;4ac2	28 12 	( . 
	ld a,(TBYTE2)		;4ac4	3a 61 e0 	: a . 
	bit 0,a		;4ac7	cb 47 	. G 
	jp z,00072h		;4ac9	ca 72 00 	. r . 
	ld ix,00000h		;4acc	dd 21 00 00 	. ! . . 
	ld iy,00072h		;4ad0	fd 21 72 00 	. ! r . 
	jr $+66		;4ad4	18 40 	. @ 
	jp 04bdch		;4ad6	c3 dc 4b 	. . K 
	ld a,(MBYTE2)		;4ad9	3a 41 e0 	: A . 
	and 002h		;4adc	e6 02 	. . 
	jr nz,$+4		;4ade	20 02 	  . 
	jp (ix)		;4ae0	dd e9 	. . 
	ld a,(TBYTE2)		;4ae2	3a 61 e0 	: a . 
	and 004h		;4ae5	e6 04 	. . 
	jr nz,$+4		;4ae7	20 02 	  . 
	jp (ix)		;4ae9	dd e9 	. . 
	ld a,028h		;4aeb	3e 28 	> ( 
	out (BANKSELECT),a		;4aed	d3 70 	. p 
	ld hl,08000h		;4aef	21 00 80 	! . . 
	ld a,(hl)			;4af2	7e 	~ 
	cp 0c3h		;4af3	fe c3 	. . 
	jp nz,00072h		;4af5	c2 72 00 	. r . 
	jp (hl)			;4af8	e9 	. 
	ld a,(LIGHTS)		;4af9	3a ce e0 	: . . 
	and 0feh		;4afc	e6 fe 	. . 
	ld (LIGHTS),a		;4afe	32 ce e0 	2 . . 
	cpl			;4b01	2f 	/ 
	out (050h),a		;4b02	d3 50 	. P 
	ret			;4b04	c9 	. 
	ld a,(LIGHTS)		;4b05	3a ce e0 	: . . 
	or 001h		;4b08	f6 01 	. . 
	jr $-12		;4b0a	18 f2 	. . 
	ld a,(0e0fch)		;4b0c	3a fc e0 	: . . 
	and 0f8h		;4b0f	e6 f8 	. . 
	or b			;4b11	b0 	. 
	ld (0e0fch),a		;4b12	32 fc e0 	2 . . 
	ret			;4b15	c9 	. 
	di			;4b16	f3 	. 
	ld a,014h		;4b17	3e 14 	> . 
	ld (0d90bh),a		;4b19	32 0b d9 	2 . . 
	ld hl,005a0h		;4b1c	21 a0 05 	! . . 
	push hl			;4b1f	e5 	. 
	call 04bc8h		;4b20	cd c8 4b 	. . K 
	in a,(0afh)		;4b23	db af 	. . 
	pop hl			;4b25	e1 	. 
	xor 040h		;4b26	ee 40 	. @ 
	jr z,$+10		;4b28	28 08 	( . 
	dec hl			;4b2a	2b 	+ 
	ld a,h			;4b2b	7c 	| 
	or l			;4b2c	b5 	. 
	jr nz,$-14		;4b2d	20 f0 	  . 
	jp 04bb2h		;4b2f	c3 b2 4b 	. . K 
	ld b,040h		;4b32	06 40 	. @ 
	ld a,00eh		;4b34	3e 0e 	> . 
	out (0afh),a		;4b36	d3 af 	. . 
	dec b			;4b38	05 	. 
	jr z,$+114		;4b39	28 70 	( p 
	call 04bc8h		;4b3b	cd c8 4b 	. . K 
	in a,(0afh)		;4b3e	db af 	. . 
	xor 048h		;4b40	ee 48 	. H 
	jr nz,$-10		;4b42	20 f4 	  . 
	ld a,0f1h		;4b44	3e f1 	> . 
	out (0afh),a		;4b46	d3 af 	. . 
	ld b,040h		;4b48	06 40 	. @ 
	dec b			;4b4a	05 	. 
	jr z,$+96		;4b4b	28 5e 	( ^ 
	call 04bc8h		;4b4d	cd c8 4b 	. . K 
	in a,(0afh)		;4b50	db af 	. . 
	xor 04ah		;4b52	ee 4a 	. J 
	jr nz,$-10		;4b54	20 f4 	  . 
	call 04af9h		;4b56	cd f9 4a 	. . J 
	in a,(0aeh)		;4b59	db ae 	. . 
	nop			;4b5b	00 	. 
	nop			;4b5c	00 	. 
	ld l,a			;4b5d	6f 	o 
	in a,(0aeh)		;4b5e	db ae 	. . 
	ld h,a			;4b60	67 	g 
	push hl			;4b61	e5 	. 
	ex de,hl			;4b62	eb 	. 
	exx			;4b63	d9 	. 
	pop hl			;4b64	e1 	. 
	exx			;4b65	d9 	. 
	in a,(0aeh)		;4b66	db ae 	. . 
	nop			;4b68	00 	. 
	nop			;4b69	00 	. 
	ld c,a			;4b6a	4f 	O 
	in a,(0aeh)		;4b6b	db ae 	. . 
	ld b,a			;4b6d	47 	G 
	ld hl,00000h		;4b6e	21 00 00 	! . . 
	in a,(0aeh)		;4b71	db ae 	. . 
	call 03d64h		;4b73	cd 64 3d 	. d = 
	xor h			;4b76	ac 	. 
	rlca			;4b77	07 	. 
	ld h,a			;4b78	67 	g 
	call 03d72h		;4b79	cd 72 3d 	. r = 
	xor l			;4b7c	ad 	. 
	rrca			;4b7d	0f 	. 
	ld l,a			;4b7e	6f 	o 
	inc de			;4b7f	13 	. 
	dec bc			;4b80	0b 	. 
	ld a,b			;4b81	78 	x 
	or c			;4b82	b1 	. 
	jr nz,$-18		;4b83	20 ec 	  . 
	in a,(0aeh)		;4b85	db ae 	. . 
	xor l			;4b87	ad 	. 
	jr nz,$+35		;4b88	20 21 	  ! 
	in a,(0aeh)		;4b8a	db ae 	. . 
	xor h			;4b8c	ac 	. 
	jr nz,$+30		;4b8d	20 1c 	  . 
	ld b,002h		;4b8f	06 02 	. . 
	call 04b0ch		;4b91	cd 0c 4b 	. . K 
	call 04fe7h		;4b94	cd e7 4f 	. . O 
	ld c,002h		;4b97	0e 02 	. . 
	push ix		;4b99	dd e5 	. . 
	pop hl			;4b9b	e1 	. 
	ld a,h			;4b9c	7c 	| 
	or l			;4b9d	b5 	. 
	jr z,$+6		;4b9e	28 04 	( . 
	exx			;4ba0	d9 	. 
	jp 03d9dh		;4ba1	c3 9d 3d 	. . = 
	exx			;4ba4	d9 	. 
	ld c,002h		;4ba5	0e 02 	. . 
	di			;4ba7	f3 	. 
	jp 03d8ch		;4ba8	c3 8c 3d 	. . = 
	ld hl,0d90bh		;4bab	21 0b d9 	! . . 
	dec (hl)			;4bae	35 	5 
	jp nz,04b1ch		;4baf	c2 1c 4b 	. . K 
	call 04b05h		;4bb2	cd 05 4b 	. . K 
	ld hl,049f2h		;4bb5	21 f2 49 	! . I 
	call 00063h		;4bb8	cd 63 00 	. c . 
	ld hl,04925h		;4bbb	21 25 49 	! % I 
	call 0470dh		;4bbe	cd 0d 47 	. . G 
	call 04fe7h		;4bc1	cd e7 4f 	. . O 
	ei			;4bc4	fb 	. 
	jp 03d94h		;4bc5	c3 94 3d 	. . = 
	ld hl,01000h		;4bc8	21 00 10 	! . . 
	dec hl			;4bcb	2b 	+ 
	ld a,h			;4bcc	7c 	| 
	or l			;4bcd	b5 	. 
	jr nz,$-3		;4bce	20 fb 	  . 
	ret			;4bd0	c9 	. 
	call z,00000h		;4bd1	cc 00 00 	. . . 
	adc a,l			;4bd4	8d 	. 
	sub b			;4bd5	90 	. 
	add a,h			;4bd6	84 	. 
	sub l			;4bd7	95 	. 
	nop			;4bd8	00 	. 
	nop			;4bd9	00 	. 
	nop			;4bda	00 	. 
	nop			;4bdb	00 	. 
	ld ix,00000h		;4bdc	dd 21 00 00 	. ! . . 
	ld iy,00072h		;4be0	fd 21 72 00 	. ! r . 
	di			;4be4	f3 	. 
	ld (0d912h),sp		;4be5	ed 73 12 d9 	. s . . 
	ld (0d918h),ix		;4be9	dd 22 18 d9 	. " . . 
	call 00003h		;4bed	cd 03 00 	. . . 
	call 00009h		;4bf0	cd 09 00 	. . . 
	ld b,010h		;4bf3	06 10 	. . 
	call 0001bh		;4bf5	cd 1b 00 	. . . 
	ld a,(MBYTE3)		;4bf8	3a 42 e0 	: B . 
	ld (0d91ah),a		;4bfb	32 1a d9 	2 . . 
	ld a,001h		;4bfe	3e 01 	> . 
	ld (MBYTE3),a		;4c00	32 42 e0 	2 B . 
	call 00012h		;4c03	cd 12 00 	. . . 
	ei			;4c06	fb 	. 
	ld a,(DFILE)		;4c07	3a 56 e0 	: V . 
	and 00fh		;4c0a	e6 0f 	. . 
	rlca			;4c0c	07 	. 
	rlca			;4c0d	07 	. 
	rlca			;4c0e	07 	. 
	rlca			;4c0f	07 	. 
	ld b,a			;4c10	47 	G 
	ld a,(0e057h)		;4c11	3a 57 e0 	: W . 
	and 00fh		;4c14	e6 0f 	. . 
	or b			;4c16	b0 	. 
	ld (FILEN),a		;4c17	32 fd e0 	2 . . 
	ld a,(MBYTE1)		;4c1a	3a 40 e0 	: @ . 
	bit 2,a		;4c1d	cb 57 	. W 
	jr z,$+8		;4c1f	28 06 	( . 
	call 04f85h		;4c21	cd 85 4f 	. . O 
	call 00042h		;4c24	cd 42 00 	. B . 
	ld b,014h		;4c27	06 14 	. . 
	ld de,0ffffh		;4c29	11 ff ff 	. . . 
	ld a,(MBYTE4)		;4c2c	3a 43 e0 	: C . 
	and 008h		;4c2f	e6 08 	. . 
	jr nz,$+27		;4c31	20 19 	  . 
	call 04f31h		;4c33	cd 31 4f 	. 1 O 
	and 080h		;4c36	e6 80 	. . 
	jr nz,$+20		;4c38	20 12 	  . 
	dec de			;4c3a	1b 	. 
	ld a,d			;4c3b	7a 	z 
	or e			;4c3c	b3 	. 
	jr nz,$-17		;4c3d	20 ed 	  . 
	push bc			;4c3f	c5 	. 
	ld hl,049b2h		;4c40	21 b2 49 	! . I 
	call 04cbah		;4c43	cd ba 4c 	. . L 
	pop bc			;4c46	c1 	. 
	djnz $-30		;4c47	10 e0 	. . 
	jp 04cc5h		;4c49	c3 c5 4c 	. . L 
	call 04f31h		;4c4c	cd 31 4f 	. 1 O 
	and 020h		;4c4f	e6 20 	.   
	rlca			;4c51	07 	. 
	rlca			;4c52	07 	. 
	ld c,a			;4c53	4f 	O 
	ld a,(LIGHTS)		;4c54	3a ce e0 	: . . 
	or c			;4c57	b1 	. 
	call 04afeh		;4c58	cd fe 4a 	. . J 
	ld a,(FILEN)		;4c5b	3a fd e0 	: . . 
	ld c,a			;4c5e	4f 	O 
	call 04c78h		;4c5f	cd 78 4c 	. x L 
	ld a,(0d91ah)		;4c62	3a 1a d9 	: . . 
	ld (MBYTE3),a		;4c65	32 42 e0 	2 B . 
	ld b,001h		;4c68	06 01 	. . 
	call 04b0ch		;4c6a	cd 0c 4b 	. . K 
	ld hl,(0d914h)		;4c6d	2a 14 d9 	* . . 
	ld ix,(0d918h)		;4c70	dd 2a 18 d9 	. * . . 
	exx			;4c74	d9 	. 
	jp 04b94h		;4c75	c3 94 4b 	. . K 
	push bc			;4c78	c5 	. 
	ld hl,04bd1h		;4c79	21 d1 4b 	! . K 
	ld de,0d91dh		;4c7c	11 1d d9 	. . . 
	ld bc,0000ah		;4c7f	01 0a 00 	. . . 
	ldir		;4c82	ed b0 	. . 
	pop bc			;4c84	c1 	. 
	ld a,c			;4c85	79 	y 
	ld (0d902h),a		;4c86	32 02 d9 	2 . . 
	ld hl,019c8h		;4c89	21 c8 19 	! . . 
	ld (0d907h),hl		;4c8c	22 07 d9 	" . . 
	ld a,00ah		;4c8f	3e 0a 	> . 
	ld (0d909h),a		;4c91	32 09 d9 	2 . . 
	ld ix,04c9fh		;4c94	dd 21 9f 4c 	. ! . L 
	call 04ecbh		;4c98	cd cb 4e 	. . N 
	cp 0afh		;4c9b	fe af 	. . 
	jr nz,$-5		;4c9d	20 f9 	  . 
	ld a,002h		;4c9f	3e 02 	> . 
	ld (0d90bh),a		;4ca1	32 0b d9 	2 . . 
	ld ix,04cebh		;4ca4	dd 21 eb 4c 	. ! . L 
	jr $+70		;4ca8	18 44 	. D 
	call 04b05h		;4caa	cd 05 4b 	. . K 
	ld a,(0d90bh)		;4cad	3a 0b d9 	: . . 
	or a			;4cb0	b7 	. 
	jr z,$+20		;4cb1	28 12 	( . 
	dec a			;4cb3	3d 	= 
	ld (0d90bh),a		;4cb4	32 0b d9 	2 . . 
	ld hl,0499eh		;4cb7	21 9e 49 	! . I 
	push hl			;4cba	e5 	. 
	ld hl,049f2h		;4cbb	21 f2 49 	! . I 
	call 00063h		;4cbe	cd 63 00 	. c . 
	pop hl			;4cc1	e1 	. 
	jp 00063h		;4cc2	c3 63 00 	. c . 
	ld hl,049f2h		;4cc5	21 f2 49 	! . I 
	call 00063h		;4cc8	cd 63 00 	. c . 
	ld hl,049f7h		;4ccb	21 f7 49 	! . I 
	call 0470dh		;4cce	cd 0d 47 	. . G 
	ld a,(0d91ah)		;4cd1	3a 1a d9 	: . . 
	ld (MBYTE3),a		;4cd4	32 42 e0 	2 B . 
	call 00012h		;4cd7	cd 12 00 	. . . 
	call 04b05h		;4cda	cd 05 4b 	. . K 
	ld sp,(0d912h)		;4cdd	ed 7b 12 d9 	. { . . 
	call 04fe7h		;4ce1	cd e7 4f 	. . O 
	ld a,007h		;4ce4	3e 07 	> . 
	out (0c8h),a		;4ce6	d3 c8 	. . 
	jp 03d94h		;4ce8	c3 94 3d 	. . = 
	call 04caah		;4ceb	cd aa 4c 	. . L 
	call 04e9ch		;4cee	cd 9c 4e 	. . N 
	jr nc,$-44		;4cf1	30 d2 	0 . 
	ld hl,0498dh		;4cf3	21 8d 49 	! . I 
	call 04cbah		;4cf6	cd ba 4c 	. . L 
	ld a,(0d902h)		;4cf9	3a 02 d9 	: . . 
	call 04716h		;4cfc	cd 16 47 	. . G 
	xor a			;4cff	af 	. 
	ld (0d916h),a		;4d00	32 16 d9 	2 . . 
	ld (0d911h),a		;4d03	32 11 d9 	2 . . 
	ld (0d900h),a		;4d06	32 00 d9 	2 . . 
	ld (0d901h),a		;4d09	32 01 d9 	2 . . 
	ld (0d903h),a		;4d0c	32 03 d9 	2 . . 
	ld a,(0d915h)		;4d0f	3a 15 d9 	: . . 
	ld (0d904h),a		;4d12	32 04 d9 	2 . . 
	ld a,(0d914h)		;4d15	3a 14 d9 	: . . 
	ld (0d905h),a		;4d18	32 05 d9 	2 . . 
	ld a,078h		;4d1b	3e 78 	> x 
	ld (0d909h),a		;4d1d	32 09 d9 	2 . . 
	call 04ecbh		;4d20	cd cb 4e 	. . N 
	cp 090h		;4d23	fe 90 	. . 
	jr nz,$-5		;4d25	20 f9 	  . 
	call 04ecbh		;4d27	cd cb 4e 	. . N 
	ld a,(0d90ch)		;4d2a	3a 0c d9 	: . . 
	cp 082h		;4d2d	fe 82 	. . 
	jr nz,$-12		;4d2f	20 f2 	  . 
	call 04af9h		;4d31	cd f9 4a 	. . J 
	ld a,001h		;4d34	3e 01 	> . 
	ld (0d906h),a		;4d36	32 06 d9 	2 . . 
	xor a			;4d39	af 	. 
	ld (0d90dh),a		;4d3a	32 0d d9 	2 . . 
	ld (0d90eh),a		;4d3d	32 0e d9 	2 . . 
	ld (0d910h),a		;4d40	32 10 d9 	2 . . 
	ld (0d90ah),a		;4d43	32 0a d9 	2 . . 
	ld hl,0498dh		;4d46	21 8d 49 	! . I 
	call 04cbah		;4d49	cd ba 4c 	. . L 
	ld a,(0d902h)		;4d4c	3a 02 d9 	: . . 
	call 04716h		;4d4f	cd 16 47 	. . G 
	ld hl,049aah		;4d52	21 aa 49 	! . I 
	call 00063h		;4d55	cd 63 00 	. c . 
	ld a,(0d901h)		;4d58	3a 01 d9 	: . . 
	call 04716h		;4d5b	cd 16 47 	. . G 
	ld hl,0d900h		;4d5e	21 00 d9 	! . . 
	ld b,006h		;4d61	06 06 	. . 
	ld e,002h		;4d63	1e 02 	. . 
	call 04ecbh		;4d65	cd cb 4e 	. . N 
	ld c,a			;4d68	4f 	O 
	cp 090h		;4d69	fe 90 	. . 
	jr z,$+36		;4d6b	28 22 	( " 
	ld a,e			;4d6d	7b 	{ 
	or a			;4d6e	b7 	. 
	jr nz,$+43		;4d6f	20 29 	  ) 
	ld a,(0d916h)		;4d71	3a 16 d9 	: . . 
	cp 000h		;4d74	fe 00 	. . 
	jr nz,$+10		;4d76	20 08 	  . 
	ld a,b			;4d78	78 	x 
	cp 004h		;4d79	fe 04 	. . 
	jr z,$+5		;4d7b	28 03 	( . 
	ld (hl),c			;4d7d	71 	q 
	jr $+6		;4d7e	18 04 	. . 
	ld a,(hl)			;4d80	7e 	~ 
	cp c			;4d81	b9 	. 
	jr nz,$+34		;4d82	20 20 	    
	push de			;4d84	d5 	. 
	call 04f3ah		;4d85	cd 3a 4f 	. : O 
	pop de			;4d88	d1 	. 
	dec b			;4d89	05 	. 
	jr z,$+61		;4d8a	28 3b 	( ; 
	inc hl			;4d8c	23 	# 
	jr $-40		;4d8d	18 d6 	. . 
	call 04ecbh		;4d8f	cd cb 4e 	. . N 
	ld c,a			;4d92	4f 	O 
	cp 090h		;4d93	fe 90 	. . 
	jr z,$-40		;4d95	28 d6 	( . 
	jp 04e05h		;4d97	c3 05 4e 	. . N 
	ld a,(hl)			;4d9a	7e 	~ 
	cp c			;4d9b	b9 	. 
	jr nz,$+5		;4d9c	20 03 	  . 
	dec e			;4d9e	1d 	. 
	jr $-27		;4d9f	18 e3 	. . 
	jp nc,04d20h		;4da1	d2 20 4d 	.   M 
	call 04b05h		;4da4	cd 05 4b 	. . K 
	ld hl,(0d900h)		;4da7	2a 00 d9 	* . . 
	ld (0d924h),hl		;4daa	22 24 d9 	" $ . 
	ld a,h			;4dad	7c 	| 
	cpl			;4dae	2f 	/ 
	ld h,a			;4daf	67 	g 
	ld a,l			;4db0	7d 	} 
	cpl			;4db1	2f 	/ 
	ld l,a			;4db2	6f 	o 
	ld (0d926h),hl		;4db3	22 26 d9 	" & . 
	ld hl,0d923h		;4db6	21 23 d9 	! # . 
	ld b,005h		;4db9	06 05 	. . 
	call 04f13h		;4dbb	cd 13 4f 	. . O 
	jp nc,04cc5h		;4dbe	d2 c5 4c 	. . L 
	inc hl			;4dc1	23 	# 
	djnz $-7		;4dc2	10 f7 	. . 
	jp 04d20h		;4dc4	c3 20 4d 	.   M 
	ld hl,(0d904h)		;4dc7	2a 04 d9 	* . . 
	ld a,h			;4dca	7c 	| 
	ld h,l			;4dcb	65 	e 
	ld l,a			;4dcc	6f 	o 
	xor a			;4dcd	af 	. 
	ld b,a			;4dce	47 	G 
	ld (0d90fh),a		;4dcf	32 0f d9 	2 . . 
	ld (0d906h),a		;4dd2	32 06 d9 	2 . . 
	call 04ecbh		;4dd5	cd cb 4e 	. . N 
	cp 090h		;4dd8	fe 90 	. . 
	jr nz,$+10		;4dda	20 08 	  . 
	call 04ecbh		;4ddc	cd cb 4e 	. . N 
	cp 090h		;4ddf	fe 90 	. . 
	jr nz,$+36		;4de1	20 22 	  " 
	inc b			;4de3	04 	. 
	ld a,b			;4de4	78 	x 
	cp 0f0h		;4de5	fe f0 	. . 
	jr nc,$-67		;4de7	30 bb 	0 . 
	ld a,(0d90ch)		;4de9	3a 0c d9 	: . . 
	ld c,a			;4dec	4f 	O 
	call 03d7eh		;4ded	cd 7e 3d 	. ~ = 
	ld a,(0d910h)		;4df0	3a 10 d9 	: . . 
	add a,c			;4df3	81 	. 
	ld (0d910h),a		;4df4	32 10 d9 	2 . . 
	call 04f3ah		;4df7	cd 3a 4f 	. : O 
	inc hl			;4dfa	23 	# 
	inc b			;4dfb	04 	. 
	ld a,(0d90fh)		;4dfc	3a 0f d9 	: . . 
	inc a			;4dff	3c 	< 
	ld (0d90fh),a		;4e00	32 0f d9 	2 . . 
	jr $-46		;4e03	18 d0 	. . 
	cp 017h		;4e05	fe 17 	. . 
	jr z,$+18		;4e07	28 10 	( . 
	cp 003h		;4e09	fe 03 	. . 
	jr z,$+9		;4e0b	28 07 	( . 
	cp 082h		;4e0d	fe 82 	. . 
	jp z,04d31h		;4e0f	ca 31 4d 	. 1 M 
	jr $-110		;4e12	18 90 	. . 
	ld a,001h		;4e14	3e 01 	> . 
	ld (0d90ah),a		;4e16	32 0a d9 	2 . . 
	call 04f3ah		;4e19	cd 3a 4f 	. : O 
	call 04ecbh		;4e1c	cd cb 4e 	. . N 
	ld hl,0d90dh		;4e1f	21 0d d9 	! . . 
	cp (hl)			;4e22	be 	. 
	jp nz,04da4h		;4e23	c2 a4 4d 	. . M 
	call 04ecbh		;4e26	cd cb 4e 	. . N 
	ld hl,0d90eh		;4e29	21 0e d9 	! . . 
	cp (hl)			;4e2c	be 	. 
	jp nz,04da4h		;4e2d	c2 a4 4d 	. . M 
	ld a,(0d906h)		;4e30	3a 06 d9 	: . . 
	or a			;4e33	b7 	. 
	jp nz,04da4h		;4e34	c2 a4 4d 	. . M 
	ld a,(0d916h)		;4e37	3a 16 d9 	: . . 
	or a			;4e3a	b7 	. 
	jr nz,$+16		;4e3b	20 0e 	  . 
	ld hl,(0d904h)		;4e3d	2a 04 d9 	* . . 
	ld a,h			;4e40	7c 	| 
	ld h,l			;4e41	65 	e 
	ld l,a			;4e42	6f 	o 
	ld (0d914h),hl		;4e43	22 14 d9 	" . . 
	ld a,001h		;4e46	3e 01 	> . 
	ld (0d916h),a		;4e48	32 16 d9 	2 . . 
	ld a,(0d90fh)		;4e4b	3a 0f d9 	: . . 
	ld hl,0d905h		;4e4e	21 05 d9 	! . . 
	add a,(hl)			;4e51	86 	. 
	ld (hl),a			;4e52	77 	w 
	jr nc,$+4		;4e53	30 02 	0 . 
	dec hl			;4e55	2b 	+ 
	inc (hl)			;4e56	34 	4 
	ld hl,0d901h		;4e57	21 01 d9 	! . . 
	inc (hl)			;4e5a	34 	4 
	dec hl			;4e5b	2b 	+ 
	jr nz,$+3		;4e5c	20 01 	  . 
	inc (hl)			;4e5e	34 	4 
	ld a,(0d910h)		;4e5f	3a 10 d9 	: . . 
	ld hl,0d911h		;4e62	21 11 d9 	! . . 
	add a,(hl)			;4e65	86 	. 
	ld (hl),a			;4e66	77 	w 
	ld a,(0d90ah)		;4e67	3a 0a d9 	: . . 
	or a			;4e6a	b7 	. 
	jp z,04d1bh		;4e6b	ca 1b 4d 	. . M 
	ld ix,04e97h		;4e6e	dd 21 97 4e 	. ! . N 
	ld a,002h		;4e72	3e 02 	> . 
	ld (0d90bh),a		;4e74	32 0b d9 	2 . . 
	ld hl,0d921h		;4e77	21 21 d9 	! ! . 
	ld b,002h		;4e7a	06 02 	. . 
	call 04f13h		;4e7c	cd 13 4f 	. . O 
	jp nc,04cc5h		;4e7f	d2 c5 4c 	. . L 
	inc hl			;4e82	23 	# 
	djnz $-7		;4e83	10 f7 	. . 
	ld a,078h		;4e85	3e 78 	> x 
	ld (0d909h),a		;4e87	32 09 d9 	2 . . 
	call 04ecbh		;4e8a	cd cb 4e 	. . N 
	cp 0afh		;4e8d	fe af 	. . 
	jr nz,$-5		;4e8f	20 f9 	  . 
	ld a,(0d911h)		;4e91	3a 11 d9 	: . . 
	ld c,a			;4e94	4f 	O 
	or a			;4e95	b7 	. 
	ret			;4e96	c9 	. 
	call 04caah		;4e97	cd aa 4c 	. . L 
	jr $-35		;4e9a	18 db 	. . 
	ld hl,0d91eh		;4e9c	21 1e d9 	! . . 
	ld a,(0d902h)		;4e9f	3a 02 d9 	: . . 
	ld c,a			;4ea2	4f 	O 
	rlca			;4ea3	07 	. 
	rlca			;4ea4	07 	. 
	rlca			;4ea5	07 	. 
	rlca			;4ea6	07 	. 
	call 04ebbh		;4ea7	cd bb 4e 	. . N 
	ld a,c			;4eaa	79 	y 
	call 04ebbh		;4eab	cd bb 4e 	. . N 
	ld hl,0d91dh		;4eae	21 1d d9 	! . . 
	ld b,004h		;4eb1	06 04 	. . 
	call 04f13h		;4eb3	cd 13 4f 	. . O 
	ret nc			;4eb6	d0 	. 
	inc hl			;4eb7	23 	# 
	djnz $-5		;4eb8	10 f9 	. . 
	ret			;4eba	c9 	. 
	and 00fh		;4ebb	e6 0f 	. . 
	add a,090h		;4ebd	c6 90 	. . 
	daa			;4ebf	27 	' 
	adc a,040h		;4ec0	ce 40 	. @ 
	daa			;4ec2	27 	' 
	jp pe,04ec8h		;4ec3	ea c8 4e 	. . N 
	xor 080h		;4ec6	ee 80 	. . 
	ld (hl),a			;4ec8	77 	w 
	inc hl			;4ec9	23 	# 
	ret			;4eca	c9 	. 
	push bc			;4ecb	c5 	. 
	push hl			;4ecc	e5 	. 
	ld hl,(0d907h)		;4ecd	2a 07 d9 	* . . 
	ld a,l			;4ed0	7d 	} 
	or h			;4ed1	b4 	. 
	dec hl			;4ed2	2b 	+ 
	ld (0d907h),hl		;4ed3	22 07 d9 	" . . 
	jr nz,$+26		;4ed6	20 18 	  . 
	ld hl,019c8h		;4ed8	21 c8 19 	! . . 
	ld (0d907h),hl		;4edb	22 07 d9 	" . . 
	ld hl,0d909h		;4ede	21 09 d9 	! . . 
	ld a,(hl)			;4ee1	7e 	~ 
	or a			;4ee2	b7 	. 
	jr z,$+13		;4ee3	28 0b 	( . 
	dec (hl)			;4ee5	35 	5 
	jr nz,$+10		;4ee6	20 08 	  . 
	pop hl			;4ee8	e1 	. 
	pop bc			;4ee9	c1 	. 
	ex (sp),ix		;4eea	dd e3 	. . 
	pop ix		;4eec	dd e1 	. . 
	jp (ix)		;4eee	dd e9 	. . 
	ld a,(MBYTE4)		;4ef0	3a 43 e0 	: C . 
	and 008h		;4ef3	e6 08 	. . 
	jr nz,$+10		;4ef5	20 08 	  . 
	call 04f31h		;4ef7	cd 31 4f 	. 1 O 
	bit 7,a		;4efa	cb 7f 	.  
	jp z,04cc5h		;4efc	ca c5 4c 	. . L 
	ld hl,(BFCNT)		;4eff	2a 83 e0 	* . . 
	ld a,l			;4f02	7d 	} 
	or h			;4f03	b4 	. 
	jr z,$-55		;4f04	28 c7 	( . 
	push de			;4f06	d5 	. 
	call 0003ch		;4f07	cd 3c 00 	. < . 
	pop de			;4f0a	d1 	. 
	ei			;4f0b	fb 	. 
	ld a,b			;4f0c	78 	x 
	ld (0d90ch),a		;4f0d	32 0c d9 	2 . . 
	pop hl			;4f10	e1 	. 
	pop bc			;4f11	c1 	. 
	ret			;4f12	c9 	. 
	push bc			;4f13	c5 	. 
	ld b,(hl)			;4f14	46 	F 
	call 000a2h		;4f15	cd a2 00 	. . . 
	pop bc			;4f18	c1 	. 
	ld de,007d0h		;4f19	11 d0 07 	. . . 
	dec de			;4f1c	1b 	. 
	ld a,d			;4f1d	7a 	z 
	or e			;4f1e	b3 	. 
	ret z			;4f1f	c8 	. 
	push bc			;4f20	c5 	. 
	push hl			;4f21	e5 	. 
	push de			;4f22	d5 	. 
	call 00084h		;4f23	cd 84 00 	. . . 
	pop de			;4f26	d1 	. 
	pop hl			;4f27	e1 	. 
	pop bc			;4f28	c1 	. 
	ld a,(TXCNT)		;4f29	3a 8e e0 	: . . 
	and a			;4f2c	a7 	. 
	jr nz,$-17		;4f2d	20 ed 	  . 
	scf			;4f2f	37 	7 
	ret			;4f30	c9 	. 
	ld a,(CDATAR)		;4f31	3a 81 e0 	: . . 
	add a,006h		;4f34	c6 06 	. . 
	ld c,a			;4f36	4f 	O 
	in a,(c)		;4f37	ed 78 	. x 
	ret			;4f39	c9 	. 
	ld a,(0d90dh)		;4f3a	3a 0d d9 	: . . 
	ld c,a			;4f3d	4f 	O 
	ld a,(0d90ch)		;4f3e	3a 0c d9 	: . . 
	xor c			;4f41	a9 	. 
	ld c,a			;4f42	4f 	O 
	rra			;4f43	1f 	. 
	and 07fh		;4f44	e6 7f 	.  
	xor c			;4f46	a9 	. 
	ld c,a			;4f47	4f 	O 
	rra			;4f48	1f 	. 
	rra			;4f49	1f 	. 
	xor c			;4f4a	a9 	. 
	ld d,a			;4f4b	57 	W 
	rra			;4f4c	1f 	. 
	rra			;4f4d	1f 	. 
	rra			;4f4e	1f 	. 
	rra			;4f4f	1f 	. 
	xor d			;4f50	aa 	. 
	and 003h		;4f51	e6 03 	. . 
	ld d,a			;4f53	57 	W 
	ld a,c			;4f54	79 	y 
	rlca			;4f55	07 	. 
	rlca			;4f56	07 	. 
	ld e,a			;4f57	5f 	_ 
	and 0fch		;4f58	e6 fc 	. . 
	or d			;4f5a	b2 	. 
	ld d,a			;4f5b	57 	W 
	ld a,e			;4f5c	7b 	{ 
	rlca			;4f5d	07 	. 
	and 006h		;4f5e	e6 06 	. . 
	ld e,a			;4f60	5f 	_ 
	ld a,d			;4f61	7a 	z 
	rra			;4f62	1f 	. 
	ld a,e			;4f63	7b 	{ 
	rra			;4f64	1f 	. 
	ld c,a			;4f65	4f 	O 
	ld a,(0d90eh)		;4f66	3a 0e d9 	: . . 
	xor c			;4f69	a9 	. 
	ld (0d90dh),a		;4f6a	32 0d d9 	2 . . 
	ld a,d			;4f6d	7a 	z 
	ld (0d90eh),a		;4f6e	32 0e d9 	2 . . 
	ret			;4f71	c9 	. 
	xor a			;4f72	af 	. 
	ld a,(KBCNT)		;4f73	3a 89 e0 	: . . 
	and a			;4f76	a7 	. 
	ret z			;4f77	c8 	. 
	call 0006fh		;4f78	cd 6f 00 	. o . 
	bit 7,b		;4f7b	cb 78 	. x 
	jr nz,$-11		;4f7d	20 f3 	  . 
	call 0006ch		;4f7f	cd 6c 00 	. l . 
	ld b,a			;4f82	47 	G 
	scf			;4f83	37 	7 
	ret			;4f84	c9 	. 
	xor a			;4f85	af 	. 
	ld (0d91dh),a		;4f86	32 1d d9 	2 . . 
	ld hl,04977h		;4f89	21 77 49 	! w I 
	call 04cbah		;4f8c	cd ba 4c 	. . L 
	ld d,002h		;4f8f	16 02 	. . 
	push de			;4f91	d5 	. 
	call 04f72h		;4f92	cd 72 4f 	. r O 
	pop de			;4f95	d1 	. 
	jr nc,$-5		;4f96	30 f9 	0 . 
	cp 0e3h		;4f98	fe e3 	. . 
	jr nz,$+18		;4f9a	20 10 	  . 
	ld a,d			;4f9c	7a 	z 
	cp 002h		;4f9d	fe 02 	. . 
	jr nz,$+6		;4f9f	20 04 	  . 
	ld a,(FILEN)		;4fa1	3a fd e0 	: . . 
	ret			;4fa4	c9 	. 
	ld a,(0d91dh)		;4fa5	3a 1d d9 	: . . 
	ld (FILEN),a		;4fa8	32 fd e0 	2 . . 
	ret			;4fab	c9 	. 
	cp 0e2h		;4fac	fe e2 	. . 
	jr nz,$+4		;4fae	20 02 	  . 
	jr $-43		;4fb0	18 d3 	. . 
	ld a,d			;4fb2	7a 	z 
	or a			;4fb3	b7 	. 
	jr z,$-4		;4fb4	28 fa 	( . 
	push bc			;4fb6	c5 	. 
	push de			;4fb7	d5 	. 
	ld hl,04977h		;4fb8	21 77 49 	! w I 
	call 04cbah		;4fbb	cd ba 4c 	. . L 
	pop de			;4fbe	d1 	. 
	pop bc			;4fbf	c1 	. 
	ld a,b			;4fc0	78 	x 
	sub 030h		;4fc1	d6 30 	. 0 
	jr c,$-19		;4fc3	38 eb 	8 . 
	cp 00ah		;4fc5	fe 0a 	. . 
	jr c,$+8		;4fc7	38 06 	8 . 
	sub 027h		;4fc9	d6 27 	. ' 
	cp 010h		;4fcb	fe 10 	. . 
	jr nc,$-29		;4fcd	30 e1 	0 . 
	ld e,a			;4fcf	5f 	_ 
	ld a,(0d91dh)		;4fd0	3a 1d d9 	: . . 
	rlca			;4fd3	07 	. 
	rlca			;4fd4	07 	. 
	rlca			;4fd5	07 	. 
	rlca			;4fd6	07 	. 
	or e			;4fd7	b3 	. 
	cp 040h		;4fd8	fe 40 	. @ 
	jr nc,$-42		;4fda	30 d4 	0 . 
	ld (0d91dh),a		;4fdc	32 1d d9 	2 . . 
	dec d			;4fdf	15 	. 
	push de			;4fe0	d5 	. 
	call 04716h		;4fe1	cd 16 47 	. . G 
	pop de			;4fe4	d1 	. 
	jr $-84		;4fe5	18 aa 	. . 
	ld a,(0d91bh)		;4fe7	3a 1b d9 	: . . 
	ld (MBYTE5),a		;4fea	32 44 e0 	2 D . 
	ld a,(0d91ch)		;4fed	3a 1c d9 	: . . 
	ld (OBYTE2),a		;4ff0	32 47 e0 	2 G . 
	ret			;4ff3	c9 	. 
	nop			;4ff4	00 	. 
	nop			;4ff5	00 	. 
	nop			;4ff6	00 	. 
	nop			;4ff7	00 	. 
	nop			;4ff8	00 	. 
	nop			;4ff9	00 	. 
	nop			;4ffa	00 	. 
	nop			;4ffb	00 	. 
	nop			;4ffc	00 	. 
	nop			;4ffd	00 	. 
	nop			;4ffe	00 	. 
	ld a,(hl)			;4fff	7e 	~ 
