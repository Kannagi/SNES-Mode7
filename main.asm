.include "header.asm"
.include "snes.asm"
.include "mjoypad.asm"
.include "mtext.asm"
.include "macro.asm"
.include "variable.asm"

.bank 0 slot 0
.org 0


Main:
	sei
	clc
	xce
	
	rep #$10	;16 bit xy
	sep #$20	; 8 bit a
	
	
	
	SNES_INIT
	Clear_RAM
	
	;INITIAL SETTINGS
	SNES_INIDISP $8F ; FORCED BLANK , brigtness 15
	
	;object
	SNES_OBJSEL $03 ; 8x8 , $6000 address
	
	;background
	SNES_BGMODE $07 ;  Mode 7
	
	SNES_BG2SC $58 ; address data BG2 $5800
	
	SNES_BGNBA $44 $00; address BG1,2,3,4 (2,1 / 4,3)
	
	
	
	;general init
	SNES_SETINI $00 ;$40 ext BG
	SNES_TM $11 ; obj & bg 1 enable
	
	
	;FORCED BLANK
	
	
	;Load bg 1
	SNES_VMAINC $00
	SNES_VMADD $0000
	
	SNES_DMA0 $00
	SNES_DMA0_BADD $18
	SNES_DMA0_ADD Map $4000
	
	SNES_MDMAEN $01
	
	SNES_VMAINC $80
	SNES_VMADD $0000
	
	SNES_DMA0 $00
	SNES_DMA0_BADD $19
	SNES_DMA0_ADD Tiles $4000
	
	SNES_MDMAEN $01  
	
	
	;Load Object
	
	
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	SNES_VMADD $6200
	SNES_DMA0_ADD Font3 $400	
	
	SNES_MDMAEN $01
	
	
	
	; Load Palette
	SNES_CGADD $00
	
	SNES_DMA0 $00
	SNES_DMA0_BADD $22
	SNES_DMA0_ADD pallette_mode7 $0100
	SNES_MDMAEN $01
	
	;font 3
	SNES_CGADD $80
	
	SNES_DMA0 $00
	SNES_DMA0_BADD $22
	SNES_DMA0_ADD pallette_fontdgt $0020
	SNES_MDMAEN $01
	
	;palette sky
	SNES_CGADD $70
	SNES_DMA0_ADD pallette_sky $0020
	SNES_MDMAEN $01
	
	
	
	
	;Load bg 2
	SNES_DMAX $01
	SNES_DMAX_BADD $18
	
	SNES_VMADD $4000
	
	SNES_DMA0_ADD sky $1800
	
	SNES_MDMAEN $01
	
	
	;Load BG2 tile
	SNES_VMADD $5800
	
	SNES_DMA0_ADD skytile $200
	
	SNES_MDMAEN $01
	
	
	
	
	SNES_M7SEL $00
	SNES_M7 $100,$00,$00,$100,$80,$80
	
	;--------------------------
	
	jsl Init_HDMA_M7
	
	;------------------------------
	ldx #0
	stx s_mode7+_m7an
	
	ldx #$80
	stx s_mode7+_m7x
	
	ldx #$100
	stx s_mode7+_m7y
	
	;------------------------------
	
	SNES_BGMODE $31
	SNES_INIDISP $0F ;  brigtness 15
	SNES_NMITIMEN $B1; Enable NMI,IRQ H/V , enable joypad
	wai
	cli
	
	ldy #$100
	sty HTIMEL
	
	
	ldy #$60
	sty VTIMEL
	
	lda #1
	sta MEM_VBLANK+2
	
	Gameloop:	
		jsl Clear_OAM
		jsl Debug_M7
		
		jsl add_HDMA_M7
		lda MEM_STDCTRL + _L	
		cmp #2
		bne +
			rep #$20
			inc fakezoom
			sep #$20
		+:
		
		lda MEM_STDCTRL + _R	
		cmp #2
		bne +
			rep #$20
			dec fakezoom
			sep #$20
		+:
		
		
		
		lda MEM_STDCTRL+_LEFT
		cmp #2
		bne +
			dec s_mode7+_m7an
		+:
		
		lda MEM_STDCTRL+_RIGHT
		cmp #2
		bne +
			inc s_mode7+_m7an
		+:
		
		lda MEM_STDCTRL+_UP
		cmp #2
		bne +
			ldx #0
			stx MEM_TEMPFUNC
			
			jsl Move_Mode7
		
		+:
		
		lda MEM_STDCTRL+_DOWN
		cmp #2
		bne +
			ldx #1
			stx MEM_TEMPFUNC
			
			jsl Move_Mode7
		+:
		
		wai
	

	jmp Gameloop
	

	.include "oam.asm"
	.include "joypad.asm"
	.include "VBlank.asm"
	
.bank 1 slot 0
.org 0
	.include "mode7.asm"


.bank 2 slot 0
.org 0
	
sincos:
	.include "DATA/sincos.asm"

sincos2:
	.include "DATA/dsincos.asm"
	
sky:
	.include "DATA/sky.asm"
	
skytile:


	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	
	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	.dw $1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02,$1C02
	
	.dw $1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04
	.dw $1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04,$1C04

	.dw $1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06
	.dw $1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06,$1C06

	.dw $1C60,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08
	.dw $1C60,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08,$1C08

	.dw $1C80,$1C82,$1C84,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C2E
	.dw $1C80,$1C82,$1C84,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C0A,$1C2E

	.dw $1CA0,$1CA2,$1CA4,$1CA6,$1CA8,$1CAA,$1CAC,$1CAE,$1C40,$1C42,$1C44,$1C46,$1C48,$1C4A,$1C4C,$1C4E
	.dw $1CA0,$1CA2,$1CA4,$1CA6,$1CA8,$1CAA,$1CAC,$1CAE,$1C40,$1C42,$1C44,$1C46,$1C48,$1C4A,$1C4C,$1C4E

	
Font3:
	.include "DATA/fontdgt.asm"


	
.bank 3 slot 0
.org 0


Map:
	.incbin "DATA/map7"
Tiles:
	.include "DATA/mode7.asm"
	
.bank 4 slot 0
.org 0

zoom7:
	.incbin "DATA/m7.bin"
