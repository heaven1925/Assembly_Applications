RCC_BASE			EQU 		0x40023800
RCC_AHB1ENR			EQU			0x40023800 + 0x30	
GPIOD_BASE			EQU			0x40020C00
GPIOD_MODER			EQU			0x40020C00
GPIOD_ODR			EQU			0x40020C00 + 0x14	
	
GPIODEN				EQU			( 1 << 3 )
MODER_15			EQU			( 1 << 30 )
MODER_14			EQU			( 1 << 28 )
MODER_13			EQU			( 1 << 26 )
MODER_12			EQU			( 1 << 24 )
	
LED_1				EQU			( 1 << 12 )
LED_2				EQU			( 1 << 13 )
LED_3				EQU			( 1 << 14 )
LED_4				EQU			( 1 << 15 )
	
DELAY				EQU			0x000F
ONESEC				EQU			5333333
HSEC				EQU			266667
FSEC				EQU			106667
	
					AREA		|.text| , CODE, READONLY, ALIGN =2
					THUMB
					EXPORT		__main
__main
					BL		GPIOD_Init
					
GPIOD_Init
					LDR		R0, =RCC_AHB1ENR	; R0 CLK PERIPH REG
					LDR		R1, [R0]			; LOAD into R1
					ORR		R1,	GPIODEN			; GPIOD_EN to R1
					STR		R1, [R0]			; store new form
					
					LDR		R0, =GPIOD_MODER	; LOAD MODER
					LDR		R1, =(MODER_15|MODER_14|MODER_13|MODER_12)
					STR		R1, [R0]	
					MOV		R1, #0
					
					LDR		R2, =GPIOD_ODR		; Output data register

Blink				
					MOVW	R1, #LED_1
					STR		R1, [R2]
					LDR		R3, =ONESEC
					BL		Delay
					
					MOVW	R1, #LED_2
					STR		R1, [R2]
					LDR		R3, =HSEC
					BL		Delay
					
					MOVW	R1, #LED_3
					STR		R1, [R2]
					LDR		R3, =HSEC
					BL		Delay
					
					MOVW	R1, #LED_4
					STR		R1, [R2]
					LDR		R3, =FSEC
					BL		Delay
					
					B		Blink		; loop
					
Delay
					SUBS	R3,R3,#1
					BNE		Delay
					BX		LR			; return
					
					ALIGN
					END
					
					
					
					
					
					