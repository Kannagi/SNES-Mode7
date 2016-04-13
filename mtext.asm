



.MACRO compute_all_digit_for_16_bit_A
; input[register A in 16bits] to be displayed at position _screen(x,y)
; [/!\ WARNING/!\]
;     [1] register A must be in 16bits mode
;     [2] "lda" must be the last instruction before this macro is used

	stz MEM_TEMP + 6
	cmp #0
	bpl +	
		; si A est positif tout il est bon
		; sinon, on inverse son signe
		; [todo] garder le signe pour plus tard
		dea
		eor #$ffff
		
		pha
		lda #1
		sta MEM_TEMP + 6
		pla
	+:
	
	compute_digit_for_base 10000
	stx MEM_TEMP
	compute_digit_for_base  1000
	stx MEM_TEMP + 1
	compute_digit_for_base   100
	stx MEM_TEMP + 2
	compute_digit_for_base    10
	stx MEM_TEMP + 3
	sta MEM_TEMP + 4
.ENDM


.MACRO compute_digit_for_base ARGS _base
	; [input] registre A sur 16 bits qui contient le nombre dans la bonne tranche par rapport à _base
	;     Autrement dit, _base <= A < (10 * _base)
	; [output]
	;     [X] le registre X contient le chiffre pour la _base
	;     [A] contient le reste (module _base) ==> donc 0 <= A < _base
	;
	; _base vaut une puissance non nul de 10
	; On détermine les chiffres les uns après les autres depuis le plus grand avec _base = 10000
	; Puis ainsi de suite avec _base = 1000, _base = 100 et enfin _base = 10
	; Les uns, après les autres, on obtient alors les 5 chiffres qui compose le nombre sur 16 bits.
 	
 	.IF _base != 10000
 	cmp #5 * _base
	bmi +
		ldx #5
		sec
		sbc #5 * _base
		bra ++
	+:
 		ldx #0
	++:
	.ELSE
	ldx #0
	.ENDIF
	
 	-:
	cmp #_base
	bmi +
		inx
		sec
		sbc #_base
		bra -
	+:
	
	
.ENDM


.MACRO compute_digit_for_base8 ARGS _base
	; [input] registre A sur 16 bits qui contient le nombre dans la bonne tranche par rapport à _base
	;     Autrement dit, _base <= A < (10 * _base)
	; [output]
	;     [X] le registre X contient le chiffre pour la _base
	;     [A] contient le reste (module _base) ==> donc 0 <= A < _base
	;
	; _base vaut une puissance non nul de 10
	; On détermine les chiffres les uns après les autres depuis le plus grand avec _base = 10000
	; Puis ainsi de suite avec _base = 1000, _base = 100 et enfin _base = 10
	; Les uns, après les autres, on obtient alors les 5 chiffres qui compose le nombre sur 16 bits.
 	
 	.IF _base != 100
 	cmp #5*_base
	bmi +
		ldx #5
		sec
		sbc #5*_base
		bra ++
	+:
 		ldx #0
	++:
	.ELSE
		ldx #0
	.ENDIF
	
 	-:
	cmp #_base
	bmi +
		inx
		sec
		sbc #_base
		bra -
	+:
	
	
.ENDM

