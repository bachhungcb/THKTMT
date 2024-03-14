#Laboratory Exercise 4, Assignment 4

.text
	li $s0, 0x80000000  
	li $s1, 0XFFFFFFFE  
	
	xor 	$t0, $s0, $s1 		#check if $s0 and $s1 have the same sign, $t0 >= 0 if yes, $t0 < 0 if no
	bltz 	$t0, exit   		#If $s1 and $s2 doesnt have the same sign, exit			
	
	addu 	$s3, $s2, $s1 		#$s3 = $s2 + $s1
	
	xor 	$t1, $s3, $s1		#check if $s1 and $s3 have the same sign, $t1 >= 0 if yes, $t1 < 0 if no
	bltz 	$t1, exit		#if $s1 and $s3 doesnt have the same sign, overflow occur
	addi	$t2, $t2, 1		
exit: