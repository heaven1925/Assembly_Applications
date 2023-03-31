			AREA		cmplxStack,	CODE,	READONLY
			ENTRY
			EXPORT		__main
				
__main

			LDR			R4, =0xBABEFACE
			LDR			R5, =0xDEEDBEEF
			LDR			R6, =0xC0DEF0DE
			LDR			R7, =0xFADEFEED
			
			STMDB		SP! , {R4-R7, LR}
			LDMIA		SP! , {R4-R7, PC}
			
STOP		B			STOP
			ALIGN
			END