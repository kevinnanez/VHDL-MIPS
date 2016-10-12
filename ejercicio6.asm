
addi $t0, $zero, 2	# t0 = 2
addi $t1, $zero, 3	# t1 = 3
addi $t3, $zero, 0	# Aux
mul $t3, $t0, $t1	# Multiplicate t0 and t1
sw $t3, 0($0)		# Save the result in the first memory address
exit: j exit
