#Laboratory Exercise 4, Assignment 3

.text
	li $s1 ,20  # $s1 = 10
	li $s2 ,20  # $s2 = 20
	slt $t0, $s1, $s2 #$t0 = ($s1 < $s2)? 1 : 0
	beq $t0, $zero, L1 #if($s1 >= $s2) go to L1, else go to next line
	j Exit
L1:
	addi $t1, $zero, 1
Exit:
