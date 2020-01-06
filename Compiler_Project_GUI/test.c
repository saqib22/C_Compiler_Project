#include "stdio.h"
#define 10

//comment
void main()
{
	int a,b;
	a = 10;
	b = 3;

	if(a == b)
		a = 0;
	else
		b = 0;

	while( a >= b){
		a = b;
	}


	switch(a)
	{
		case 0: s=1+4;
		break;
		case 1:
		{
			a=b;
			switch(b+2)
			{
				case 2: d=b+c;
				break;
				case 3: ;
				case 4: c=r;
				break;
			}
		} 
		case 2: s=2;
		break;
		case 3: s=3;
		break;
		case 4: s=7;
		case 5: s=9;
		break;
		default : p=q;
		break;
	}

}
