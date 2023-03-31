; P = Q + R + S
; Q=2 R=4 S=5
Q		EQU		2
R		EQU		4
S		EQU		5
	
		AREA Simple_Eqs, CODE, READONLY
		ENTRY
		EXPORT __main
__main
		MOV		R1, #Q
		MOV		R2, #R
		MOV		R3, #S
	
		ADD 	R0, R1, R2	; P = Q + R
		ADD 	R0, R0, R3	; P = P + S

STOP	B		STOP
		END