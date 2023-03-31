// 1 Enable CLK access to port of the pin  , AHB1ENR
// 2 Set Pin mode
// 3 Set Output 		GPIOD 12,13,14,15

#include "stm32f7xx.h"                  // Device header

#define		LED1						(1U << 12)	// SET
#define		LED2						(1U << 13)
#define		LED3						(1U << 14)
#define		LED4						(1U << 15)

#define		LED1_BIT				(1U << 24)	// MODER
#define		LED2_BIT				(1U << 26)
#define		LED3_BIT				(1U << 28)
#define		LED4_BIT				(1U << 30) 

#define		GPIOD_CLK		(1U << 3)			// AHB1ENR[3] GPIOD

int main()
{
	
	RCC->AHB1ENR |= GPIOD_CLK ;
	GPIOD->MODER |= (LED1_BIT | LED2_BIT | LED3_BIT | LED4_BIT);
	
	while(1)
	{
		GPIOD->ODR |= (LED1 | LED2 | LED3 | LED4);
	}
}


