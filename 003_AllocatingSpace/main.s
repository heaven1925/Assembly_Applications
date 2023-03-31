
			AREA myCode, CODE, READONLY
			ENTRY
			EXPORT __main
__main
			LDR R0, =A
			MOV R1, #55
			STR	R1,	[R0]
			
			LDR R0, =D
			MOV R1, #44
			STR	R1,	[R0]
			
			LDR R0, =C
			MOV R1, #33
			STR	R1,	[R0]
			
STOP		B	STOP

			AREA	myData, DATA , READWRITE
			; Allocate 4 Byte in memory
A			SPACE	4
D			SPACE	4
C			SPACE	4
	
			END