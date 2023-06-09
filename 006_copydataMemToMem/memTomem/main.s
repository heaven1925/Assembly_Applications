RAM1_ADDR		EQU		0x20010000
RAM2_ADDR		EQU		0x20010100

					AREA	myCode, CODE,READONLY
					ENTRY
					EXPORT	__main

__main
					BL		FILL
					BL		COPY
					
Stop				B		 Stop
								
FILL		   		LDR		R1,= RAM1_ADDR
					MOV		R0,#10
					LDR		R2,=0xDEADBEEF
					
L1					STR		R2,[R1]
					ADD		R1,R1,#4
					SUBS	R0,R0,#1
					BNE		L1
					BX		LR
					
COPY				LDR		R1,=RAM1_ADDR
					LDR		R2,=RAM2_ADDR
					MOV		R0,#10

L2					LDR 	R3,[R1]
					STR		R3,[R2]
					ADD		R1,R1,#4
					ADD		R2,R2,#4
					SUBS	R0,R0,#1
					BNE		L2
					BX		LR
										
					END