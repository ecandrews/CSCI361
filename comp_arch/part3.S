	.globl part_three
part_three:
	// random number generator to populate an array, then sort
	MOV X3, #2	// n
	MOV X4, #2 	// n multiplier
	MOV X5, #0 	// n iterator
	MOV X6, #7 	// g
	MOV X7, #7 	// g multiplier
	MOV X8, #0 	// g iterator
	MOV X12, #8 	// offset
	B .make_n

.make_n:
	MUL X3, X4, X3
	ADD X5, X5, #1
	CMP X5, #31
	BEQ .make_g
	B .make_n
	
.make_g:
	MUL X6, X7, X6
	ADD X8, X8, #1
	CMP X8, #7
	BEQ .fill_array
	B .make_g
	
.fill_array:
    // X3 is n
	// X6 is g
	// X0 is time
	// X1 is array length
	// X2 is array itself
	SUB X1, X1, #1 	// subtract one from array length
	SUB X3, X3, #1 	// make n prime
	MOV X9, #0 	// make iterator X9
	MOV X14, #0 	// iterator for sort
	B .generate_num
	
.generate_num:
	MUL X10, X6, X0 	// g * time
	CMP X10, X3			//if (g * time) <= n
	BLE .store_num		//store num
	B .mod				//otherwise (g*time) mod n

.mod:
	SUB X10, X10, X3	//subtract n from (g*time)
	CMP X10, X3			//if (g * time) <= n
	BLE .store_num		//store the num
	B .mod				//otherwise repeat
	
.store_num:
	MUL X13, X9, X12 	// X13 is offset
	STR X10, [X2, X13]
	CMP X9, X1
	BEQ .sort_start
	MOV X0, X10
	ADD X9, X9, #1 	// add one to iterator
	B .generate_num	
	
.sort_start:
	MOV X5, #-1 	//make outerIter
	MOV X8, #0 		//make innerIter
	MOV X3, #0 		//make min variable
	MOV X4, #0 		//make minIndex variable
	ADD X1, X1, #1  // add one to array length
	B .outer_loop

.outer_loop:
	ADD X5, X5, #1		//iterate outerIter
	CMP X5, X1			//if outerIter == array.length
	BEQ .done			//finish
						//otherwise
	MOV X8, X5			//set innerIter to outterIter
	MUL X13, X5, X12	//get offset
	LDR X3, [X2, X13] 	//set min to array value at outer loop index
	MOV X4, X5			//set minIndex to outerIter
	B .inner_loop

.inner_loop:
	ADD X8, X8, #1		//iterate innerIter
	CMP X8, X1			//if innerIterr == array.length
	BEQ .outer_loop2	//go to outer_loop2
						//otherwise
	MUL X13, X8, X12	//get offset
	LDR X6, [X2, X13]	//get value at array[innerIter]
	CMP X6, X3			//if (array[j] < min )
	BLT .new_min		//set new min
						//otherwise
	B .inner_loop		//loop

.outer_loop2:

	MUL X13, X5, X12	//get offset for outerIter
	LDR X6, [X2, X13]	//get value at array[outerIter]
	MUL X13, X4, X12	//get offset for minIndex
	STR X6, [X2, X13]	//store val at array[outerIter] in array[minIndex]
	MUL X13, X5, X12	//get offset for outerIter
	STR X3, [X2, X13]	//store val at array[outerIter] to min
	B .outer_loop

.new_min:
	MOV X3, X6			//set min to newly found min
	MOV X4, X8			//set min index to innerIter
	B .inner_loop		//resume inner_loop

.done:
	MOV X0, X2
	br X30
