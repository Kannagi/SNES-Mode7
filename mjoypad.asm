
.MACRO joypad_event
	lda \3	; read joypad
	bit #\1
	bne +
		stz MEM_STDCTRL + \2
		bra ++
	+:
		lda MEM_STDCTRL + \2
		cmp #$00
		bne +
			lda #01
			sta MEM_STDCTRL + \2
			bra ++
		+:
		
		lda #02
		sta MEM_STDCTRL + \2
	++:
.ENDM

.DEFINE	_A			$00
.DEFINE	_B			$01
.DEFINE	_Y			$02
.DEFINE	_X			$03

.DEFINE	_L			$04
.DEFINE	_R			$05

.DEFINE	_START		$06
.DEFINE	_SELECT		$07

.DEFINE	_RIGHT		$08
.DEFINE	_LEFT		$09
.DEFINE	_DOWN		$0A
.DEFINE	_UP 		$0B

.DEFINE	_J1C 		$0C
.DEFINE	_J2C 		$1C

.DEFINE	_J1 		$00
.DEFINE	_J2 		$10









