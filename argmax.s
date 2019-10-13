.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:

    # Prologue
    add t0, x0, x0 # counter, starting from 0
    add t1, x0, x0 # temporary content
    add t2, a0, x0 # currentaddress
    sw t3, 0(t2) # get the first element as current max
    add t4, t0, x0 # put the index of the current largest element, which in this case is 0
    add t5, a1, x0 # the maximum value

loop_start:
	beq t0, t5, loop_end
    lw t1, 0(t2)
    bge t3, t1, loop_continue
    add t3, t1, x0 # copy the value of t1 into t3
    add t4, t0, x0 # copy the index number of the maximum into t4

loop_continue:
	addi t0, t0, 1
    addi t2, t2, 4

loop_end:
	add a0, t4, x0

    # Epilogue


    ret