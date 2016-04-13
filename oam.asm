
	
.MACRO Clear_OAM4

	sta MEM_OAML + $01 + (\1*$10)
	sta MEM_OAML + $05 + (\1*$10)
	sta MEM_OAML + $09 + (\1*$10)
	sta MEM_OAML + $0D + (\1*$10)
	
	
.ENDM

Clear_OAM:

	
	

	;Clear OAM
	stz MEM_OAMH +$00
	stz MEM_OAMH +$01
	stz MEM_OAMH +$02
	stz MEM_OAMH +$03
	stz MEM_OAMH +$04
	stz MEM_OAMH +$05
	stz MEM_OAMH +$06
	stz MEM_OAMH +$07
	stz MEM_OAMH +$08
	stz MEM_OAMH +$09
	stz MEM_OAMH +$0A
	stz MEM_OAMH +$0B
	stz MEM_OAMH +$0C
	stz MEM_OAMH +$0D
	stz MEM_OAMH +$0E
	stz MEM_OAMH +$0F
	
	stz MEM_OAMH +$10
	stz MEM_OAMH +$11
	stz MEM_OAMH +$12
	stz MEM_OAMH +$13
	stz MEM_OAMH +$14
	stz MEM_OAMH +$15
	stz MEM_OAMH +$16
	stz MEM_OAMH +$17
	stz MEM_OAMH +$18
	stz MEM_OAMH +$19
	stz MEM_OAMH +$1A
	stz MEM_OAMH +$1B
	stz MEM_OAMH +$1C
	stz MEM_OAMH +$1D
	stz MEM_OAMH +$1E
	stz MEM_OAMH +$1F
	
	lda #-32
	
	Clear_OAM4 $00
	Clear_OAM4 $01
	Clear_OAM4 $02
	Clear_OAM4 $03
	Clear_OAM4 $04
	Clear_OAM4 $05
	Clear_OAM4 $06
	Clear_OAM4 $07
	Clear_OAM4 $08
	Clear_OAM4 $09
	Clear_OAM4 $0A
	Clear_OAM4 $0B
	Clear_OAM4 $0C
	Clear_OAM4 $0D
	Clear_OAM4 $0E
	Clear_OAM4 $0F
	
	Clear_OAM4 $10
	Clear_OAM4 $11
	Clear_OAM4 $12
	Clear_OAM4 $13
	Clear_OAM4 $14
	Clear_OAM4 $15
	Clear_OAM4 $16
	Clear_OAM4 $17
	Clear_OAM4 $18
	Clear_OAM4 $19
	Clear_OAM4 $1A
	Clear_OAM4 $1B
	Clear_OAM4 $1C
	Clear_OAM4 $1D
	Clear_OAM4 $1E
	Clear_OAM4 $1F
	
	rtl
	


	
	

Set_OAM:

	
	;Y
	rep #$20
	lda MEM_OAM+_sprsz
	and #$FE
	clc
	adc MEM_OAM+_spry
	sta MEM_OAM+_sprtmp1
	sep #$20
	
	lda MEM_OAM+_sprtmp1+1
	cmp #$00
	beq +
		iny
		iny
		iny
		iny
		rtl
	+:
	
	;X right
	lda MEM_OAM+_sprx+1
	cmp #$01
	bmi +
		iny
		iny
		iny
		iny
		rtl
	+:
	
	;X left
	rep #$20
	lda MEM_OAM+_sprsz
	and #$FE
	clc
	adc MEM_OAM+_sprx
	sta MEM_OAM+_sprtmp1
	sta MEM_OAM+_sprtmp2
	sep #$20
		
	lda MEM_OAM+_sprtmp1+1
	cmp #$0
	bpl +
		iny
		iny
		iny
		iny
		rtl
	+:

	rep #$20
	tya
	phy
	
	sta MEM_OAM+_sprtmp1
	
	lsr
	lsr
	lsr
	lsr
	
	tay
	sep #$20
	
	lda MEM_OAM+_sprtmp1
	and #$0F
	cmp #$00
	bne +
		lda #$01
		bra ++
	+:
	cmp #$04
	bne +
		lda #$04
		bra ++
	+:
	cmp #$08
	bne +
		lda #$10
		bra ++
	+:
	cmp #$0C
	bne +
		lda #$40
		bra ++
	+:
	++:
	sta MEM_OAM+_sprtmp1
	asl
	sta MEM_OAM+_sprtmp1+1
	
	lda MEM_OAM+_sprsz
	bit #1
	beq +
		lda MEM_OAMH,y
		ora MEM_OAM+_sprtmp1+1
		sta MEM_OAMH,y
	+:
	
	lda MEM_OAM+_sprtmp2+1
	cmp #$1
	beq +
	;clipping
	lda MEM_OAM+_sprsz
	and #$FE
	clc
	adc MEM_OAM+_sprx
	bcc +
		lda MEM_OAMH,y
		ora MEM_OAM+_sprtmp1
		sta MEM_OAMH,y
	+:
	
	ply
	;--------
	
	lda MEM_OAM+_sprx
	sta MEM_OAML,y
	iny
	
	lda MEM_OAM+_spry
	sta MEM_OAML,y
	iny
	
	lda MEM_OAM+_sprtile
	sta MEM_OAML,y
	iny
	
	lda MEM_OAM+_sprext
	sta MEM_OAML,y
	iny
	
	rtl
	
