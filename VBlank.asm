
	
VBlank:
	lda s_mode7+_m7px
	sta BG1H0FS
	lda s_mode7+_m7px + 1
	sta BG1H0FS
	
	
	lda s_mode7+_m7py + 0
	sta BG1V0FS
	lda s_mode7+_m7py + 1
	sta BG1V0FS
	
	lda s_mode7+_m7an
	sta BG2H0FS
	lda s_mode7+_m7an + 1
	sta BG2H0FS
	
	lda #$0F
	sta BG2V0FS
	lda #0
	sta BG2V0FS
	
	
	
	jsr Port_DMA_OAM
	
	
	
	ldx s_mode7+_m7an
		
	lda sincos.l + $80,X
	sta MEM_TEMP+2
	
	lda sincos.l + $40,X
	sta MEM_TEMP+3
	
	lda sincos.l + $00,X
	sta MEM_TEMP+4
	
	lda s_mode7+_m7frm
	ina
	and #$01
	sta s_mode7+_m7frm
	
	cmp #0
	bne +
		jsl R1mode7
		bra ++
	+:
	cmp #1
	bne +
		jsl R2mode7
		bra ++
	+:
	
	++:
	
	
	SNES_DMAX $02
    
	SNES_DMA0_BADD $1B
	SNES_DMA1_BADD $1E
	
	SNES_DMA2_BADD $1C
	SNES_DMA3_BADD $1D
	

	SNES_HDMA_ADD MODE7A,$7E,  0,0 ,0,0,   0
	SNES_HDMA_ADD MODE7D,$7E,  0,0 ,0,0,   1
	
	SNES_HDMA_ADD MODE7B,$7E,  0,0 ,0,0,   2
	SNES_HDMA_ADD MODE7C,$7E,  0,0 ,0,0,   3
	
	SNES_HDMAEN $0F
	
	
	
	lda s_mode7+_m7x
	sta M7X
	
	lda s_mode7+_m7x+1
	sta M7X
	
	lda s_mode7+_m7y
	sta M7Y
	
	lda s_mode7+_m7y+1
	sta M7Y
	
	
	
	SNES_BGMODE $31
	SNES_TM $12
	
	
	ldy #0
	sty MEM_VBLANK+1
    -:
		iny
		
		lda	$4212
		and #$80		
	bne -
	sty MEM_VBLANK+1

	

	jsr Tri_joypad
	
	
    rti
    
	.include "VBlankmode7.asm"
    
    

IRQ:
Timer:
	
	phb
	pha
	phx
	phy
	
	
	lda $4211
	SNES_BGMODE $07
	SNES_TM $11

	ply
	plx
	pla
	plb
	
	rti


Port_DMA_OAM:

	ldx #$0000	
	stx OAMADDL

	SNES_DMA0 $00
	SNES_DMA0_BADD $04
	
    
	lda #$7E
	ldx #MEM_OAML
	ldy #$220
	
	sta DMA_BANK
	stx DMA_ADDL
	sty DMA_SIZEL
	
    SNES_MDMAEN $01

	rts
	
