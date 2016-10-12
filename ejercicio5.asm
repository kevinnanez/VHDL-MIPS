# i = 0
add $t0, $t0, $zero
# N = 10
addi $s0, $zero, 10
# Where to store the result!

# First memory address
addi $t2, $zero, 0
# Result
addi $s1, $zero, 0
sum:
	lw $t3, 0($t2)

	addi $t2, $t2, 4
	addi $t0, $t0, 1
	bne $t0, $t1, sum

exit: j exit
