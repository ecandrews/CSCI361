	.globl binary_search
binary_search:
	// sorted array, midpoint value, goal value
	// sorted is reg x0, length is reg x1, and goal value is reg x2

	MOV X11, #0 	// X11 is the start
	MOV X12, #14 	// X12 is the end

	SUB X13, X11, X12

	CNMP X13, #15 	// if negative, start <= end
	BGE .start_while

.start_while: 	// start of the while loop

	SUB X20, X11, X12
	CMP X20, #0
	BGT .not_found

	B .get_mid
	MOV X18, #8 	// offset by 64
	MUL X18, X15, X18 	// multiply midpoint by 64
	LDR X17, [X0, X18]

	SUB X19, X17, X2 	// if key==inputArr[mid]
	CMP X19, #0 	// compare diff
	BEQ .exit 	// if equal than or greater to, proceed to exit method

	CMP X19, X2
	BLT .key_less_than_midpoint
	BGE .key_greater_than_midpoint

	B .start_while

.not_found:
	MOV X21, #-1
	MOV X0, X21
	B .exit

.get_mid: 	// calculate midpoint
	ADD X14, X11, X12 	// add start and end
	MOV X16, #2
	SDIV X15, X14, X16 	// X15 is the midpoint, after dividing sum by 2

.key_less_than_midpoint:
	SUB X12, X15, #1

.key_greater_than_midpoint:
	ADD X11, X15, #1

.exit:
	MOV X0, X2
	br X30
