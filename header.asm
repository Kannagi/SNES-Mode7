.MEMORYMAP
	SLOTSIZE $8000 ; The slot is $8000 bytes in size. More details on slots later.
	DEFAULTSLOT 0 ; There's only 1 slot in SNES, there are more in other consoles.
	SLOT 0 $8000 ; Defines Slot 0's starting address.
.ENDME




.ROMBANKSIZE $8000
.ROMBANKS 16

; R/BANK ko
; 9/16  512
; A/32  1024
; B/64  2048
; C/128 4096
; D/256 8192

.SNESHEADER
	ID    "SNES"
	NAME  "Test Demo Mode 7     "
	;     "123456789012345678901"
	LOROM
	SLOWROM
	CARTRIDGETYPE $00
	ROMSIZE $09 ;size rom 09-0d
	SRAMSIZE $00
	COUNTRY $01 ;0 = japan , 1 = US , 2 = Europe
	LICENSEECODE $01
	VERSION 00
.ENDSNES

;65816
.SNESNATIVEVECTOR
	COP    $0000
	BRK    $0000
	ABORT  $0000
	NMI    VBlank
	UNUSED Main
	IRQ    Timer
.ENDNATIVEVECTOR

;6502
.SNESEMUVECTOR
	COP    $0000
	UNUSED $0000
	ABORT  $0000
	NMI    VBlank
	RESET  Main
	IRQBRK Timer
.ENDEMUVECTOR



