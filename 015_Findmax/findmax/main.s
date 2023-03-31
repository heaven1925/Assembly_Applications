COUNT		RN		R0
MAX			RN		R1
POINTER		RN		R2
NEXT		RN		R3

			AREA	myData, DATA, READONLY
MYDATA		DCD 	10, 11, 12, 13, 14, 15

			AREA	myCode, CODE, READONLY
			ENTRY
			EXPORT __main
__main
			MOV		COUNT,  #6
			MOV		MAX,	#0
			LDR		POINTER, =MYDATA
			
			
AGAIN		LDR		NEXT,	[POINTER]	; adresteki degeri NEXT yaz
			CMP		MAX,	NEXT		; NEXT ile MAX karsilastir
			BHS		CTNU			    ; Eger kücükse dallan
			MOV		MAX, NEXT	; --> En büyük bulundu..
			
CTNU		ADD		POINTER, POINTER, #4	; Sonraki adres
			SUBS	COUNT, COUNT, #1		; Count 1 azalt
			BNE		AGAIN					; Süreci tekrarla

STOP		B		STOP
			END
