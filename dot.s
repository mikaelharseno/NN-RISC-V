.globl dot

.text
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
dot:
    # Prologue
    add t0, x0, a0 # pointer to v0
    add t1, x0, a1 # pointer to v1
    add t2, x0, a2 # length of both, counter to 0
    add t3, x0, a3 # stride of v0
    add t4, x0, a4 # stride of v1
    add t5, x0, x0 # temporary result of dot
    add t6, x0, x0 # temporary result of mult

loop_start:
    beq t2, x0, loop_end
    lw t6, 0(t0)
    lw a5, 0(t1)
    mul t6, t6, a5
    add t5, t5, t6
    
    addi t2, t2, -1
    add t0, t0, t3
    add t0, t0, t3
    add t0, t0, t3
    add t0, t0, t3
    add t1, t1, t4
    add t1, t1, t4
    add t1, t1, t4
    add t1, t1, t4
	jal x0, loop_start

loop_end:
    # Epilogue
    add a0, x0, t5
	ret