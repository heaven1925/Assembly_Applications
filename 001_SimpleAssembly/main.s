; This is simple project

	AREA SimpleProject, CODE, READONLY
	ENTRY
	EXPORT __main						; main'e baska sayfalardan erisilsin
		
__main
		MOV 	R5, #0x1234 
		MOV 	R3, #0x1234
		ADD 	R6, R5, R3
	
STOP 	B 		STOP
		END
