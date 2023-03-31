			AREA	simpleStack,	CODE,	READONLY
			ENTRY
			EXPORT	__main
				
__main	
			LDR		R3, =0xDEADBEEF
			LDR		R4,	=0XBABEFACE
			PUSH	{R3}	;R13(SP) = FC - 4
			PUSH	{R4}	;R13(SP) = FC - 4 = F8
			POP		{R5}	;R13(SP) = F8 + 4 = FC
			POP		{R6}	;R13(SP) = FC + 4

STOP		B		STOP
			ALIGN
			END