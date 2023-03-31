			AREA	myCode,	CODE, READONLY
			EXPORT  __main
			ENTRY
			
__main
			LDR	 	R0,	=0xE000ED88
			LDR	 	R1,	[R0]
			ORR	 	R1,	R1, #(0XF<<20)
			STR	 	R1,	[R0]
			ADRL 	R1,	ConstantTable
			VLDR.F	S2, [R1, #20]	; pi
			VLDR.F	S3, [R1, #12]	; 4
			VMUL.F  S3, S2,S3		; pi*4
			
STOP		B	 	STOP
			
; IEEE-754 FLOATING POINT CONVERTOR				
ConstantTable
			DCD		0x3F800000	; 1.0
			DCD		0x40000000	; 2.0
			DCD		0x80000000	; -0.0
			DCD		0x41200000	; 10.0
			DCD		0x42C80000	; 100.0
			DCD		0x40490FDA	; pi
			DCD		0x402DF854	; e
				
			END