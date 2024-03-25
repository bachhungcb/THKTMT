.data
 message1: .asciiz "The sum of "
 message2: .asciiz " and "
 message3: .asciiz " is " 
 
 .text
 	li $v0, 4
 	addi $s0, $zero, 5 		#$s0 = 5
 	addi $s1, $zero, 4		#$s1 = 4
 	add $s3, $s1, $s0		#$s3 = $s1 + $s0
 	
 	la $a0, message1		#print "The sum of" on the screen 
 	syscall
 	
 	li $v0, 1			#print $s0 on the screen 
 	move $a0, $s0
 	syscall
 	
 	li $v0, 4			#print "and" on the screen 
 	la $a0, message2
 	syscall
 	
 	li $v0, 1			#print $s1 on the screen 
 	move $a0, $s1
 	syscall
 	
 	li $v0, 4			#print "is" on the screen 
 	la $a0, message3
 	syscall
 	
 	li $v0, 1			#print result on the screen 
 	move $a0, $s3
 	syscall
 	