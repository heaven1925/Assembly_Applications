	
		AREA	myCode,	CODE, READONLY
		ENTRY
		EXPORT	__main
__main
		LDR		R0, =0xFFFFFFFF
		LDR		R1, =0x0000000F
		
		MOV		R2, #0x35
		MOV		R3,	#0x21
		
		ADDS	R5,R1,R0
		ADC		R6,R2,R3	; R6=R2+R3+CarryBit
		
STOP	B		STOP
		END