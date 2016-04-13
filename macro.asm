

.MACRO Clear_RAM
    
    ldx #$0
	ldy #0
	-:
		sty 0,x
		inx
		inx
		cpx #$2000
	bne -
	
	
.ENDM




.MACRO set_draw_OAM

	lda #\1
	sta MEM_OAM+_sprtile
	
	lda #\2
	sta MEM_OAM+_sprext
	
	lda #\3
	sta MEM_OAM+_sprsz
	
	jsl Set_OAM
	
	
.ENDM

.MACRO set_position

	rep #$20
	
	lda #\1
	sta MEM_OAM+_sprx
	
	lda #\2
	sta MEM_OAM+_spry
	
	sep #$20
	
	
.ENDM

.MACRO set_position_add

	rep #$20
	
	lda MEM_OAM+_sprx
	clc
	adc #\1
	sta MEM_OAM+_sprx
	
	lda MEM_OAM+_spry
	clc
	adc #\2
	sta MEM_OAM+_spry
	
	sep #$20
	
	
.ENDM

