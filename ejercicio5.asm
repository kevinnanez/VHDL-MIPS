add $t0, $t0, $zero		# i = 0
addi $t1, $zero, 10		# N = 10
addi $t3, $zero, 0		# Aux
addi $t4, $zero, 0		# Result
addi $t2, $zero, 0		# First memory address


sup:
	sw $t0, 0($t2)		# Store i in the first memory address
	addi $t2, $t2, 4	# Go to the next memory address
	addi $t0, $t0, 1	# i++
	beq $t0, $t1, next	# if i = N go to next
	j sup
	
next:
	add $t0, $zero, 0	# i = 0
	add $t2, $zero, 0	# First memory address again
sum:
	lw $t3, 0($t2)		# Load the 
	addi $t2, $t2, 4	# mem ++
	addi $t0, $t0, 1	# i ++
	add $t4, $t4, $t3	# Result
	beq $t0, $t1, last
	j sum
	
last:	
	sw $t4, 0($t2)
exit: j exit
