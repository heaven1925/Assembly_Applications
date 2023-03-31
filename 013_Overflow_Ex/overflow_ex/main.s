
		AREA		myCode,	CODE,	READONLY
		ENTRY
		EXPORT		__main
__main
		LDR		R1,	=0x10000000
		LDR		R2,	=0x20000000
		LDR		R3,	=0x30000000
		LDR		R4,	=0x40000000
		LDR		R5,	=0x41000000
		
		MOV		R8, #0	; for saving lower word
		MOV		R9, #0	; for acc carries
		
		ADDS	R8,R8,R1 ; R8=R8+R1
		ADC		R9,R9,#0 ; R9=R9+0+CARRY
		
		ADDS	R8,R8,R2 ; R8=R8+R2
		ADC		R9,R9,#0 ; R9=R9+0+CARRY
		
		ADDS	R8,R8,R3 ; R8=R8+R3
		ADC		R9,R9,#0 ; R9=R9+0+CARRY
		
		ADDS	R8,R8,R4 ; R8=R8+R4
		ADC		R9,R9,#0 ; R9=R9+0+CARRY
		
STOP	B		STOP
		END