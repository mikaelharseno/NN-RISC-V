.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue
    add t0, x0, a1 # t0 is the element counter. will be 0 when it stops
    add t1, x0, x0
    add t2, x0, a0 

loop_start:
    beq t0, x0, loop_end
    lw t1, 0(t2)
    bge t1, x0, loop_continue
    sw x0, 0(t2)
    
loop_continue:
    addi t0, t0, -1
    addi t1, t1, 1
    addi t2, t2, 4
	jal x0, loop_start

loop_end:
    # Epilogue
	ret