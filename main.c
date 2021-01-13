#include "stdio.h"

#define F 5
#define R 2
#define RM_MAX 15

extern void asm_func(int* arg1, int* arg2, int* arg3, int* arg4);
extern void initialise_monitor_handles(void);

int main(void)
{
	initialise_monitor_handles();
	int i,j;
	int building[F][R] = {{10,10},{10,10},{10,10}}; // patient distribution in the building by last week
	int discharge[F][R] = {{2,1},{4,3},{0,5}};	// discharged patient numbers in the building for this week
	int send_in[7] = {8,7,6,5,4,3,2};	// new patient numbers need to allocated in the building for this week
	int result[F][R] = {{F,R},{RM_MAX,0},{0,0}}; // Empty array to store the resulted patient distribution in asm_func()

	// function used to generate the resulted patient distribution by this week and store it into result[][]
	asm_func((int*)building, (int*)discharge, (int*)send_in, (int*)result);

	// refresh building[][] and print out
	printf("Resulted patient distribution by this week: \n");
	for (i=0; i<F; i++)
	{
		for (j=0; j<R; j++)
		{
			building[i][j] = result[i][j];
			printf("%d\t", building[i][j]);
		}
	printf("\n");
	}

}
