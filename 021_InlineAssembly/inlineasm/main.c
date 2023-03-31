		// ASM fonksiyon oldugu için bu formatta
	__inline int getSum(int a, int b)	
	{
		int sum;
		__asm{
				ADD sum, a, b
					}
		return sum;
	}
	// z = x + y ;
	int z;
	int main(void)
	{
			int x = 1;
			int y = 2;	
	while(1)
		{
			z = getSum(x,y);
		}
		
	}
	