
RCC_BASE			EQU		0x40023800
RCC_AHB1ENR_OFFSET	EQU		0x30
RCC_AHB1ENR			EQU		RCC_BASE + RCC_AHB1ENR_OFFSET
	
GPIOA_BASE 			EQU		0x40020000
	
GPIO_MODER_OFFSET	EQU		0x00
GPIOA_MODER			EQU		GPIOA_BASE + GPIO_MODER_OFFSET
	
GPIO_ODR_OFFSET		EQU		0x14
GPIOA_ODR			EQU		GPIOA_BASE + GPIO_ODR_OFFSET

GPIOA_BSRR_OFFSET	EQU		0x18
GPIOA_BSRR			EQU		GPIOA_BASE + GPIOA_BSRR_OFFSET
GPIOA5_SET			EQU		1 << 5
GPIOA5_RESET		EQU		1 << 21

GPIOA_EN			EQU		1 << 0 
GPIOA5_MODER		EQU		1 << 10 
GPIOA5_ODR			EQU		1 << 5 
	
LED_ON				EQU		GPIOA5_ODR
LED_OFF				EQU		0 << 5 

ONESEC				EQU		5333333
	
					AREA	|.text|, CODE, READONLY, ALIGN=2
					THUMB
					ENTRY
					EXPORT	__main						
__main				
					BL		GPIOA_Init
												
GPIOA_Init			; RCC->AHB1ENR |= GPIOA_EN 
					LDR 	R0, =RCC_AHB1ENR
					LDR		R1,	[R0]
					ORR		R1, #GPIOA_EN
					STR		R1, [R0]
					; GPIOA->MODER |= GPIOA5_MODER
					LDR 	R0,	=GPIOA_MODER
					LDR		R1,	[R0]
					ORR		R1,	#GPIOA5_MODER
					STR		R1, [R0]
					; Hold GPIOAODR FOR BLINK
					LDR		R2, =GPIOA_BSRR
										
BLINK				; Blink Sub-Routine
					MOV R1 , #GPIOA5_SET
					STR	R1, [R2]
					LDR	R3, =ONESEC
					BL	DELAY
					
					MOV R1 , #GPIOA5_RESET
					STR	R1, [R2]
					LDR	R3, =ONESEC
					BL	DELAY					
					B	BLINK

DELAY				; Delay Sub-Routine
					SUBS	R3,R3, #1
					BNE		DELAY
					BX		LR
					
					ALIGN
					END
							
					
					
					
					