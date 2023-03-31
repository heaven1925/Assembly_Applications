;////////////////////////////////////////////////////////////
RCC_BASE			EQU		0x40023800
	
RCC_AHB1ENR_OFFSET	EQU		0x30
RCC_AHB1ENR			EQU		RCC_BASE + RCC_AHB1ENR_OFFSET
GPIOA_EN			EQU		1 << 0 
;APB1ENR[17] = UART2
RCC_APB1ENR_OFFSET	EQU		0x40
RCC_APB1ENR			EQU		RCC_BASE + RCC_APB1ENR_OFFSET
UART2_EN			EQU		1 << 17

;////////////////////////////////////////////////////////////
GPIOA_BASE 			EQU		0x40020000
	
GPIO_MODER_OFFSET	EQU		0x00
GPIOA_MODER			EQU		GPIOA_BASE + GPIO_MODER_OFFSET
GPIOA5_MODER		EQU		1 << 10 

GPIO_ODR_OFFSET		EQU		0x14
GPIOA_ODR			EQU		GPIOA_BASE + GPIO_ODR_OFFSET
GPIOA5_ODR			EQU		1 << 5 

GPIOA_BSRR_OFFSET	EQU		0x18
GPIOA_BSRR			EQU		GPIOA_BASE + GPIOA_BSRR_OFFSET
GPIOA5_SET			EQU		1 << 5
GPIOA5_RESET		EQU		1 << 21
	
GPIOA_AFRL_OFFSET	EQU		0x0
GPIOA_AFRL			EQU		GPIOA_BASE + GPIOA_AFRL_OFFSET
; PA2 -> TX  , PA3 -> RX	
GPIOA_AF_Select		EQU		0x80		; = 0b 1000 0000	
AF7_Select			EQU		0x7000		; = 0b 0111 0000 0000 0000 Px2 

MODER5_OUT			EQU		1 << 10		; PA10 LED
;////////////////////////////////////////////////////////////
UART2_BASE			EQU		0x40004400
;//////////////// Control register 1
UART2_CR1_OFFSET	EQU		0x00
UART2_CR1			EQU		UART2_BASE	+ UART2_CR1_OFFSET
;//////////////// Control register 2
UART2_CR2_OFFSET	EQU		0x04
UART2_CR2			EQU		UART2_BASE	+ UART2_CR2_OFFSET
;//////////////// Control register 3
UART2_CR3_OFFSET	EQU		0x08
UART2_CR3			EQU		UART2_BASE	+ UART2_CR3_OFFSET
;//////////////// Baud rate register
UART2_BRR_OFFSET	EQU		0x0C
UART2_BRR			EQU		UART2_BASE	+ UART2_BRR_OFFSET
;//////////////// Interrupt and status register
UART2_ISR_OFFSET	EQU		0x1C
UART2_ISR			EQU		UART2_BASE	+ UART2_ISR_OFFSET
;//////////////// Receive data register
UART2_RDR_OFFSET	EQU		0x24
UART2_RDR			EQU		UART2_BASE	+ UART2_RDR_OFFSET
;////////////////	Transmit data register
UART2_TDR_OFFSET	EQU		0x28
UART2_TDR			EQU		UART2_BASE	+ UART2_TDR_OFFSET

BRR_Config			EQU		0x683  ;Baud Rate 16MHz
CR1_Config			EQU		0x4 ;Enable TX-RX 8 bit data 0b 1100
CR2_Config			EQU		0x0000 ; 1 stop bit
CR3_Config			EQU		0x0000 ; no flow control

UART2_CR1_EN		EQU		0x1		; ue

TXE_Flag			EQU		0x80	; ISR_TXE
RXE_Flag			EQU		0x20	; ISR_RXNE
;////////////////////////////////////////////////////////////	
CR					EQU		0x0D
LF					EQU		0x0A
BS					EQU		0x08
ESC					EQU		0x1B
SPA					EQU		0x20
DEL					EQU		0X7F
;////////////////////////////////////////////////////////////
ONESEC				EQU		5333333
;////////////////////////////////////////////////////////////
					AREA	|.text|, CODE, READONLY
					THUMB
					ENTRY
					EXPORT	__main
__main
					BL		IO_Init
LOOP					
					BL		UART_ReadChar
					BL		LED_Blink
					
					B		LOOP
					
					
					
IO_Init			; RCC->AHB1ENR |= GPIOA_EN
					LDR		R0, =RCC_AHB1ENR
					LDR		R1, [R0]
					ORR		R1, #GPIOA_EN
					STR		R1, [R0]
					; RCC->APB1ENR |= UART2_EN
					LDR		R0, =RCC_APB1ENR
					LDR		R1, [R0]
					ORR		R1, #UART2_EN
					STR		R1, [R0]
; SET UP ALT F 		; GPIOA->AFRL |= AF7_Select
					LDR		R0, =GPIOA_AFRL
					LDR		R1,	[R0]
					ORR		R1, #AF7_Select
					STR		R1, [R0]
;					; GPIOA->MODER |= GPIOA_ALT_Select
					LDR		R0, =GPIOA_MODER
					LDR		R1,[R0]
					ORR		R1, #GPIOA_AF_Select	; 0x20
					STR		R1, [R0]
					; GPIOA->MODER |= MODER5_OUT
					LDR 	R0, =GPIOA_MODER
					LDR		R1, [R0]
					ORR		R1, #MODER5_OUT
					STR		R1, [R0]
					
					; UART2->BRR = BRR_Config ; 9600
					LDR		R0, =UART2_BRR
					MOVW	R1,	#BRR_Config
					STR		R1, [R0]
					; UART2->CR1 = CR1_Config
					LDR		R0, =UART2_CR1
					MOV		R1, #CR1_Config
					STR		R1, [R0]
					; UART2->CR2 = CR2_Config
					LDR		R0, =UART2_CR2
					MOV		R1, #CR2_Config	
					STR		R1, [R0]
					; UART2->CR3 = CR3_Config
					LDR		R0, =UART2_CR3
					MOV		R1, #CR3_Config			
					STR		R1, [R0]
					; UART2->CR1 = TXE_EN
					LDR		R0, =UART2_CR1
					LDR		R1,[R0]
					ORR		R1,	#UART2_CR1_EN		; UE
					STR		R1, [R0]
					
					BX		LR

UART_ReadChar
					LDR		R1, =UART2_ISR
LOOP_2					
					LDR		R2, [R1]
					AND		R2, #RXE_Flag
					CMP		R2, #0x00
					BEQ		LOOP_2
					LDR		R3, =UART2_RDR
					LDR		R0, [R3]
					BX 		LR

UART_WriteChar
					LDR		R1, =UART2_ISR
LOOP_1					
					LDR		R2,	[R1]
					AND		R2, #TXE_Flag
					CMP		R2, #0x00
					BEQ		LOOP_1
					UXTB	R1,R0
					LDR		R2, =UART2_TDR
					STR		R1, [R2]
					BX		LR
					
Delay				
					SUBS	R3,R3, #1
					BNE		Delay
					BX		lr
					
					
LED_Blink								
					MOV		R3, R0
					CMP		R3, #0x0030	; KEY1 = 
					BEQ		BLINK
					BX		LR
BLINK
					
					MOVS	R0, #GPIOA5_SET
					LDR		R1, =GPIOA_BSRR
					STR		R0, [R1]
					
					LDR		R3, =ONESEC
					BL		Delay
					
					MOVS	R0, #GPIOA5_RESET
					LDR		R1, =GPIOA_BSRR
					STR		R0, [R1]
					
					LDR		R3, =ONESEC
					BL		Delay
					
					BL 		UART_ReadChar
					
					ALIGN
					END
