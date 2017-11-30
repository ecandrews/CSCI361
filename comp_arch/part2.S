	.globl binary_search
binary_search:
	// X0 is sorted array
	// X1 is array length
	// X2 is key value

	MOV X11, #0 					// X11 is start
	MOV X12, #14 					// X12 is end
	SUB X13, X11, X12				// calculate difference between start and end
	CMP X13, #15 					// compare difference to length of array, which is 15
	BGE .start_while				// if greater than or equal to, then start is less than end
									// so branch to while loop
.start_while: 						// start of the while loop
	SUB X20, X11, X12				// calculate difference between start and end
	CMP X20, #0						// compare diff to zero
	BGT .not_found					// if result is greater than zero, value was not found, so branch to not_found
	B .get_mid						// otherwise branch to get_mid to calculate midpoint
	MOV X18, #8 					// offset by 8
	MUL X18, X15, X18 				// multiply midpoint by 8
	LDR X17, [X0, X18]				// load value at midpoint and store in register X17
	SUB X19, X17, X2 				// calculate difference between midpoint and key
	CMP X19, #0 					// compare diff to zero
	BEQ .exit 						// if equal, branch to exit
	CMP X19, X2						// otherwise compare diff to key
	BLT .key_less_than_midpoint		// branch if less than
	BGE .key_greater_than_midpoint	// branch if greater than
	B .start_while					// branch to return to the start of the while loop and begin again

.not_found:							// if value is not found in array
	MOV X21, #-1					// store -1 in register X21
	MOV X0, X21						// store -1 in the register to be returned
	br X30							// done

.get_mid: 							// calculate midpoint
	ADD X14, X11, X12 				// add start and end
	MOV X16, #2						// store 2 in register X16
	SDIV X15, X14, X16 				// divide sum by 2
									// X15 is midpoint

.key_less_than_midpoint:			// key is less than midpoint
	SUB X12, X15, #1				// subtract 1 from midpoint and set result to be new end value

.key_greater_than_midpoint:			// key is greater than midpoint
	ADD X11, X15, #1				// add 1 to midpoint and set result to be new start value

.exit:								// exit program
	MOV X0, X2						// store key value in register to be returned
	br X30							// done
