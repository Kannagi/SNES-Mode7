
Tri_joypad:
	
	
	joypad_event $80 $00 STDCONTROL1L ; A
	joypad_event $40 $03 STDCONTROL1L ; X
	joypad_event $20 $04 STDCONTROL1L ; L
	joypad_event $10 $05 STDCONTROL1L ; R
	
	joypad_event $10 $06 STDCONTROL1H ; START
	joypad_event $20 $07 STDCONTROL1H ; SELECT
	joypad_event $40 $02 STDCONTROL1H ; Y
	joypad_event $80 $01 STDCONTROL1H ; B
	
	joypad_event $01 $08 STDCONTROL1H ; RIGHT
	joypad_event $02 $09 STDCONTROL1H ; LEFT
	joypad_event $04 $0A STDCONTROL1H ; DOWN
	joypad_event $08 $0B STDCONTROL1H ; UP
	
	lda JOYSER0
	sta MEM_STDCTRL+_J1C
	
	lda JOYSER1
	sta MEM_STDCTRL+_J2C
	
	rts
	
