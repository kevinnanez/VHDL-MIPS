add $t0, $t0, $zero		# i = 0
addi $t1, $zero, 10		# N = 10
addi $t2, $zero, 0		# First memory address
sup:
	sw $t0, 0($t2)		# Store i in the first memory address
	addi $t2, $t2, 4	# Go to the next memory address
	addi $t0, $t0, 1	# i++
	bne $t0, $t1, sup	# if i < N go to sup and start the loop again. Otherwise, exit

exit: j exit
