#include <stdio.h>
#include <assert.h>
#include <time.h>

extern long long int binary_search(long long int sorted[], int, int);
extern long long int* part_three(int num1, int num2, long long int unsorted[]);

int main(void)
{
	// begin binary_search
	long long int sorted[15] = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29};
	long long int value_returned = binary_search(sorted, 15, 29);
	printf("Result of binary search is %ld\n", value_returned);
	value_returned = binary_search(sorted, 15, 1);
	printf("Result of binary search is %ld\n", value_returned);
	value_returned = binary_search(sorted, 15, 3);
	printf("Result of binary search is %ld\n", value_returned);
	value_returned = binary_search(sorted, 15, 15);
	printf("Result of binary search is %ld\n", value_returned);
	value_returned = binary_search(sorted, 15, 23);
	printf("Result of binary search is %ld\n", value_returned);
	value_returned = binary_search(sorted, 15, 29);
	printf("Result of binary search is %ld\n", value_returned);
	value_returned = binary_search(sorted, 15, 35);
	printf("Result of binary search is %ld\n", value_returned);

	assert( 1 == binary_search(sorted, 15, 1) );
	assert( 3 == binary_search(sorted, 15, 3) );
	assert( 15 == binary_search(sorted, 15, 15) );
	assert( 23 == binary_search(sorted, 15, 23) );
	assert( 29 == binary_search(sorted, 15, 29) );
	// assert( -1 == binary_search(sorted, 15, 35) );


	// begin part3
	printf("\n");
	int time_ms = (clock() * 1000);							// get time in milliseconds
	long long int unsorted[4] = {0, 0, 0, 0};				// create unsorted array
	long long int* boib = part_three(time_ms, 4, unsorted); // store results from part3 code in array

	for(int i = 0; i < 4; i++)								// loop through the new sorted array and output results
	{
	    printf("Result of part_three is %llu\n", boib[i]);
	}

    return 0;
}
