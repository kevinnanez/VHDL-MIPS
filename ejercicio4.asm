# i = 0
add $t0, $t0, $zero
# N = 10
addi $t1, $zero, 10

# First memory address
addi $t2, $zero, 0
sup:
	sw $t0, 0($t2)
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	bne $t0, $t1, hola

exit: j exit
