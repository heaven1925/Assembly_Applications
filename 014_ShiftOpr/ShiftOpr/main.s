
		AREA  simpleShift, CODE, READONLY
		ENTRY
		EXPORT __main
__main
		MOV		R0, #0x04
		LSL		R1, R0, #1
		ROR		R2, R0, #1
		ORR 	R3, R0, R0, LSL #1
STOP	B		STOP
		END