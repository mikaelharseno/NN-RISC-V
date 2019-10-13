.globl matmul, dot

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:
    # Error if mismatched dimensions
    bne a2, a4, mismatched_dimensions

	addi sp, sp, -48
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw s7, 28(sp)
    sw s8, 32(sp)
    sw s9, 36(sp)
    sw s10, 40(sp)
    sw ra, 44(sp)
	
    # Prologue
    add s0, x0, a0 # pointer to current row
    add s1, x0, a3 # pointer to current column
    add s2, x0, a2 # number of elements to be multiplied
    add s3, x0, a1 # stride of A (as increment to matrix mult)
    add s4, x0, a5 # stride of B (as input to dot)
    add s5, x0, a6 # pointer to output matrix
    add s6, x0, a6 # pointer to current element in the output matrix
    add s7, x0, a0 # pointer to the start of m0
    add s8, x0, a3 # pointer to the start of m1
    add s9, x0, a1 # counter of outer loop
    add s10, x0, a5 # counter of inner loop


outer_loop_start:
	beq s9, x0, outer_loop_end
	add s10, x0, s4
    
inner_loop_start:
	beq s10, x0, inner_loop_end
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
    
    # call func
    mv a0, s0
    mv a1, s1
    add a2, x0, s2
    addi a3, x0, 1
    add a4, x0, s4
    jal ra dot
    sw a0, 0(s6)
    
    addi s1, s1, 4 # increment pointer of B to next column vector
    addi s6, s6, 4 # increment pointer to output matrix C
    addi s10, s10, -1 # decrement inner loop counter
    
    jal x0, inner_loop_start
    
inner_loop_end:
	# add to get to the next row
    add s0, s0, s2
    add s0, s0, s2
    add s0, s0, s2
    add s0, s0, s2
    
    # reset such that the column vector starts back from the first one
    add s1, x0, s8
    
    # decrement outer loop counter
    addi s9, s9, -1
    
    jal x0, outer_loop_start

outer_loop_end:

    # Epilogue
    
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw s7, 28(sp)
    lw s8, 32(sp)
    lw s9, 36(sp)
    lw s10, 40(sp)
    lw ra, 44(sp)
    addi sp, sp, 48
    
    ret


mismatched_dimensions:
    li a1 2
    jal exit2
