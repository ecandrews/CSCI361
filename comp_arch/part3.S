	.globl part_three
part_three:
	// random number generator to populate an array, then s o r t	
	MOV X3, #2	// n is here
	MOV X4, #2 	// n multiplier
	MOV X5, #0 	// n iterator
	MOV X6, #7 	// g is here
	MOV X7, #7 	// g multiplier
	MOV X8, #0 	// g iterator
	MOV X12, #64 	// offset
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
	MOV X11, X10 MOD X3 	// g * time mod n, X11 RN
	B .store_num
	
.store_num:
	MUL X13, X9, X12 	// X13 is offset
	STR X11, [X13, X2]
	CMP X9, X1
	BEQ .done
	MOV X0, X11
	ADD X9, X9, #1 	// add one to iterator
	B .generate_num	
	
.done:
	MOV X30, X2 
	br X30