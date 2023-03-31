			AREA		jumpTable,	CODE,	READONLY
			EXPORT		__main		
			ENTRY

num			EQU			2


__main
			MOV		R0,	#0
			MOV		R1, #3
			MOV		R2, #2
		
			BL		arithfunc
STOP		B		STOP
		
		
arithfunc
			CMP		R0, #num
			MOVHS	PC,LR		; return
			ADRL	R3, JumpTable
			LDR		PC, [R3,R0, LSL #2]

JumpTable
			DCD		DoAdd
			DCD		DoSubb
		
DoAdd		
			ADD R0,R1,R2
			BX	LR
DoSubb
			SUB R0,R1,R2
			BX LR
			
			END