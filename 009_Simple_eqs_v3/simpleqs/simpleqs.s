; P = Q + S + R
; Q=5 S=4 R=3
			
Vals	SPACE	4
		DCD		5	;Q
		DCD		4	;S
		DCD		3	;R
		ALIGN
			
		AREA EqsCode, CODE, READONLY
		ENTRY
		EXPORT __main

__main
		ADRL	R4, Vals
		LDR		R1, [R4, #Q]
		LDR		R1, [R4, #S]
		LDR		R1, [R4, #R]
		
		ADD		R0, R1, R2
		ADD		R0, R0, R3
		
		STR		R0, [R4,#P]
		
STOP	B		STOP
		END
			
P		EQU		0
Q		EQU		4
S		EQU		8
R		EQU		12
	
		AREA EqsData, DATA, READONLY

		