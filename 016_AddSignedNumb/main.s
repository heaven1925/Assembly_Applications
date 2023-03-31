			AREA	 myCode, CODE, READONLY
			ENTRY
			EXPORT 	 __main
__main
			LDR		R0, =SIGN_DATA
			MOV		R3,	#9
			MOV		R2, #0
		
LOOP		LDRSB	R1, [R0]
			ADD		R2,	R2,	R1
			ADD		R0, R1, #1 ; Byte size oldugu için
			SUBS	R3, R3, #1
			BNE		LOOP

STOP		B		STOP

SIGN_DATA   DCB	    13,-10,9,14,-18,-9,12,-19,16
			ALIGN	

			END
			
