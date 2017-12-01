	.globl part_three
part_three:
	// assembly language to psuedo-randomly generate numbers to populate an array that is initialized to all zero values
	// array is then sorted using selection sort
	MOV X3, #2				// n
	MOV X4, #2 				// n multiplier
	MOV X5, #0 				// n iterator
	MOV X6, #7 				// g
	MOV X7, #7 				// g multiplier
	MOV X8, #0 				// g iterator
	MOV X12, #8 			// offset
	B .make_n				// branch to make_n

.make_n:					// calculate the n value to be used in the RNG
	MUL X3, X4, X3			// multiply n by its multiplier
	ADD X5, X5, #1			// increase iterator by one
	CMP X5, #31				// compare iterator to 31
	BEQ .make_g				// if result is equal, n calculation is done, branch to make_g
	B .make_n				// otherwise branch back to beginning of make_n
	
.make_g:					// calculate the g value to be used in the RNG
	MUL X6, X7, X6			// multiply g by its multiplier
	ADD X8, X8, #1			// increase iterator by 1
	CMP X8, #7				// compare iterator to 7
	BEQ .fill_array			// if result is equal, g caluclation is done, branch to fill_array
	B .make_g				// otherwise branch back to beginning of make_g
	
.fill_array:
	SUB X1, X1, #1 			// subtract one from array length
	SUB X3, X3, #1 			// make n prime
	MOV X9, #0 				// make iterator X9
	MOV X14, #0 			// make iterator for sort
	B .generate_num			// branch to generate_num to begin generating random numbers for array
	
.generate_num:				// generate random number to be stored in array
	MUL X10, X6, X0 		// multiply g by seed in milliseconds
	CMP X10, X3				// compare result to n
	BLE .store_num			// if result is less than or equal to, branch to store_num to store value in array
	B .mod					// otherwise branch to mod

.mod:						// perform modulus operation
	SUB X10, X10, X3		// subtract n from (g * time)
	CMP X10, X3				// compare result to n
	BLE .store_num			// if result is less than or equal to, branch to store_num
	B .mod					// otherwise branch to mod and repeat
	
.store_num:					// store random number in array
	MUL X13, X9, X12 		// multiply iterator by offset and store in register X13
	STR X10, [X2, X13]		// store random number in array at index of result
	CMP X9, X1				// compare iterator to array length
	BEQ .sort_start			// if equal, array is full, branch to sort_start method to sort array
	MOV X0, X10				// otherwise set random number to be new seed
	ADD X9, X9, #1 			// increase iterator by one
	B .generate_num			// branch to generate_num and repeat using new seed
	
.sort_start:				// begin sorting array
	MOV X5, #-1 			// make outer iterator
	MOV X8, #0 				// make inner iterator
	MOV X3, #0 				// make min variable
	MOV X4, #0 				// make minIndex variable
	ADD X1, X1, #1  		// add one to array length
	B .outer_loop			// branch to outer loop

.outer_loop:				// begin outer loop
	ADD X5, X5, #1			// increase outer iterator
	CMP X5, X1				// compare iterator to array length
	BEQ .done				// if equal, array is sorted, branch to done
	MOV X8, X5				// otherwise set inner iterator to outer iterator
	MUL X13, X5, X12		// multiply iterator by offset
	LDR X3, [X2, X13] 		// load value at result index in array into min value register
	MOV X4, X5				// set minIndex to outerIter
	B .inner_loop			// branch to inner loop

.inner_loop:
	ADD X8, X8, #1			// increase inner iterator
	CMP X8, X1				// compare inner iterator to array length
	BEQ .outer_loop2		// if equal, branch to outer_loop2
	MUL X13, X8, X12		// multiply iterator by offset
	LDR X6, [X2, X13]		// load value at result index of array
	CMP X6, X3				// compare result to current min
	BLT .new_min			// if result is less than min, branch to new_min
	B .inner_loop			// otherwise, branch to inner_loop

.outer_loop2:				// begin outer loop 2
	MUL X13, X5, X12		// multiply outer iterator by offset
	LDR X6, [X2, X13]		// load value at result index of array
	MUL X13, X4, X12		// get offset for minIndex
	STR X6, [X2, X13]		// store val at array[outerIter] in array[minIndex]
	MUL X13, X5, X12		// get offset for outer iterator
	STR X3, [X2, X13]		// store val at array[outerIter] to min
	B .outer_loop			// branch back to outer_loop

.new_min:
	MOV X3, X6				// set current min to newly found min
	MOV X4, X8				// set min index to innerIter
	B .inner_loop			// branch back to resume inner_loop

.done:						// array has been sorted
	MOV X0, X2				// store sorted array in register to be returned
	br X30					// exit
