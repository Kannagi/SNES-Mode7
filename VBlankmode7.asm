





	
.MACRO Set_Mode7_line

		
		
		;M7B
		lda MODE7S+(\1*2)
		sta M7A
		
		lda MODE7S+(\1*2) + 1
		sta M7A
		
		lda MEM_TEMP+2
		sta M7B
				
		ldx MPYM
		stx MODE7B+(3*(\1+$60))+1
		
		;M7C
		lda MEM_TEMP+4
		sta M7B
				
		ldx MPYM
		stx MODE7C+(3*(\1+$60))+1		

		;M7A
		lda MEM_TEMP+3
		sta M7B
			
				
		ldx MPYM
		stx MODE7A+(3*(\1+$60))+1

		;M7D	
		stx MODE7D+(3*(\1+$60))+1		


.ENDM
	

.MACRO Set_Mode7_line_bloc


	Set_Mode7_line $00+\1
	Set_Mode7_line $01+\1
	Set_Mode7_line $02+\1
	Set_Mode7_line $03+\1
	Set_Mode7_line $04+\1
	Set_Mode7_line $05+\1
	Set_Mode7_line $06+\1
	Set_Mode7_line $07+\1
	Set_Mode7_line $08+\1
	
	Set_Mode7_line $09+\1
	Set_Mode7_line $0A+\1
	Set_Mode7_line $0B+\1
	Set_Mode7_line $0C+\1
	Set_Mode7_line $0D+\1
	Set_Mode7_line $0E+\1
	Set_Mode7_line $0F+\1

.ENDM
	


R1mode7:

	Set_Mode7_line_bloc $00
	Set_Mode7_line_bloc $10
	Set_Mode7_line_bloc $20
	Set_Mode7_line_bloc $30

	rtl
	
	
R2mode7:

	Set_Mode7_line_bloc $40
	Set_Mode7_line_bloc $50
	Set_Mode7_line_bloc $60
	Set_Mode7_line_bloc $70
	
	rtl

	
	


	



