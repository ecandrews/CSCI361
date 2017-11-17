	.globl binary_search
binary_search:
	// sorted array, midpoint value, goal value
	// i think sorted is reg x0 or x1, midpoint is reg w2, and goal value is reg w1

	sub x0, x0, #1

	br	X30
