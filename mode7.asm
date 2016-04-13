

	
    
Debug_M7:

	;OAM ADD
	ldx #0
	stx MEM_TEMPFUNC+2
	
	
	;fake zoom
	ldx fakezoom
	stx MEM_TEMPFUNC
	
	set_position 210,160
	jsl Draw_digit
	
	
	; time VBLANK
	ldx MEM_VBLANK+1 
	stx MEM_TEMPFUNC
	
	set_position 210,170
	jsl Draw_digit
	
	
	
	
	rtl
	
Draw_digit:


	

	rep #$20
	
	lda MEM_TEMPFUNC
	compute_digit_for_base 10000
	stx MEM_TEMP+12
	compute_digit_for_base 1000
	stx MEM_TEMP+4
	compute_digit_for_base 100
	stx MEM_TEMP+6
	compute_digit_for_base 10
	stx MEM_TEMP + 8
	sta MEM_TEMP + 10
	
	sep #$20
	
	ldy MEM_TEMPFUNC+2
	
	lda #$30
	clc
	adc MEM_TEMP+12
	sta MEM_OAM+_sprtile
	jsl Draw_OAM
	
	lda #$30
	clc
	adc MEM_TEMP+4
	sta MEM_OAM+_sprtile
	jsl Draw_OAM
	
	
	lda #$30
	clc
	adc MEM_TEMP+6
	sta MEM_OAM+_sprtile
	jsl Draw_OAM
	
	lda #$30
	clc
	adc MEM_TEMP+8
	sta MEM_OAM+_sprtile
	jsl Draw_OAM
	
	lda #$30
	clc
	adc MEM_TEMP+10
	sta MEM_OAM+_sprtile
	jsl Draw_OAM
	
	rep #$20
	
	lda MEM_TEMPFUNC+2
	clc
	adc #8*5
	sta MEM_TEMPFUNC+2
	
	sep #$20
	
	
	rtl
	
	
Draw_OAM:
	
	lda #$30
	sta MEM_OAM+_sprext
	
	lda #$8
	sta MEM_OAM+_sprsz
	
	jsl Set_OAM
	
	rep #$20
	lda MEM_OAM+_sprx
	clc
	adc #$9
	sta MEM_OAM+_sprx
	sep #$20


	rtl
	
Init_HDMA_M7:

	ldx #$00
	ldy #$00
	-:

		lda #1
		sta MODE7A,x
		sta MODE7D,x
		sta MODE7B,x
		sta MODE7C,x
		inx
		
		rep #$20
			
		lda #$100
		sta MODE7A,x
		sta MODE7D,x
		
		lda #$0
		sta MODE7B,x
		sta MODE7C,x
		inx
		inx
		
		sep #$20
		
		iny
		cpy #$F0
	bne -
	lda #0
	sta MODE7A,x
	sta MODE7D,x
	sta MODE7B,x
	sta MODE7C,x
	
	ldx #3*$60
	inx
	ldy #$00
	-:

		rep #$20
		
		phx
		tyx
		lda zoom7.l,x
		asl
		sta MODE7S,x
		lsr
		plx
		
		sta MODE7A,x
		sta MODE7D,x
		
		sep #$20
		
		inx
		inx
		inx
		
		iny
		iny
		cpy #$80*2
	bne -
	
	lda #0
	sta MODE7A,x
	sta MODE7D,x
	sta MODE7B,x
	sta MODE7C,x
	
	
	rtl


add_HDMA_M7:

	
	ldx #3*$60
	inx
	ldy #$00
	-:

		rep #$20
		
		phx
		tyx
		lda zoom7.l,x
		
		
		asl
		clc
		adc fakezoom
		sta MODE7S,x
		plx
		
		
		
		sep #$20
		
		inx
		inx
		inx
		
		iny
		iny
		cpy #$80*2
	bne -
	
	lda #0
	sta MODE7A,x
	sta MODE7D,x
	sta MODE7B,x
	sta MODE7C,x
	
	
	rtl
	

	
	
Move_Mode7:

	rep #$20
	lda s_mode7+_m7an
	asl
	tax
	sep #$20
	
	rep #$20
	lda sincos2.l+$00,x
	sta s_mode7+_m7vx
	
	lda sincos2.l+$80,x
	sta s_mode7+_m7vy
	sep #$20
	
	;------------------------
	
	rep #$20
	lda s_mode7+_m7py+2
	and #$FF
	clc
	adc s_mode7+_m7vy
	sta MEM_TEMP
	
	sep #$20
	
	
	lda MEM_TEMP
	sta s_mode7+_m7py+2
	
	rep #$20
	
	lda MEM_TEMP
	lsr
	lsr
	lsr
	lsr
	
	lsr
	lsr
	lsr
	lsr
	

	
	cmp #$10
	bmi ++
		ora #$FF00
		
	++:
	sta MEM_TEMP
	
	lda MEM_TEMPFUNC
	cmp #0
	bne +
		lda s_mode7+_m7py
		sec
		sbc MEM_TEMP
		and #$3FF
		cmp #$300
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7py
		
		lda s_mode7+_m7y
		sec
		sbc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7y
		
		bra ++
	+:
		lda s_mode7+_m7py
		clc
		adc MEM_TEMP
		and #$3FF
		cmp #$300
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7py
		
		lda s_mode7+_m7y
		clc
		adc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7y
	++:
	
	sep #$20
	
	;------------------------
	rep #$20
	lda s_mode7+_m7px+2
	and #$FF
	clc
	adc s_mode7+_m7vx
	sta MEM_TEMP
	
	sep #$20
	
	
	lda MEM_TEMP
	sta s_mode7+_m7px+2
	
	rep #$20
	
	lda MEM_TEMP
	lsr
	lsr
	lsr
	lsr
	
	lsr
	lsr
	lsr
	lsr
	

	
	cmp #$10
	bmi ++
		ora #$FF00
	++:
	sta MEM_TEMP
	
	
	lda MEM_TEMPFUNC
	cmp #0
	bne +
		lda s_mode7+_m7px
		clc
		adc MEM_TEMP
		and #$3FF
		cmp #$380
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7px
		
		lda s_mode7+_m7x
		clc
		adc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7x
		bra ++
	+:
		lda s_mode7+_m7px
		sec
		sbc MEM_TEMP
		and #$3FF
		cmp #$380
		bmi +++
			sec
			sbc #$400
		+++:
		sta s_mode7+_m7px
		
		lda s_mode7+_m7x
		sec
		sbc MEM_TEMP
		and #$3FF
		sta s_mode7+_m7x
	++:
	
	sep #$20
	;------------------------
	rtl
	



