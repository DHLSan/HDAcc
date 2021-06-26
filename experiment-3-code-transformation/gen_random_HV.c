#include <math.h>

#include <algorithm>
int matrix[];


int randperm(int* matrix, int size)
{
	int std[];
    std[] = random_shuffle(matrix, matrix + size);
	return std[];
}

int gen_random_HV(D){
	int randomindex;
	int randomHV;
	if D mod 2;
		printf("dimesion is odd");
	else
	randomindex = randperm(D);
	
	randomHV(randomindex(1:D/2)) =1;
	randomHV(randomIndex(D/2+1:D)) = 0;
	
	return randomHV;
	
}