#Laboratory Exercise 7, Home Assignment 5
.data
Message:		.asciiz 		"Largest: "
Message1:	.asciiz		"Smallest: "
newline:		.asciiz		"\n"
tab:		.asciiz		","

.text
	li $s0, 1		#Load integer in to registers
	li $s1, 2
	li $s2, -3
	li $s3, -4
	li $s4, 5
	li $s5, -6
	li $s6, 7
	li $s7, 8
	li $t0, 0		#t0 is index of max
	li $t1, 0		#t1 is max
	li $t2, 0		#t2 is index of min
	li $t3, 0		#t3 is min 
	jal findMax
	nop
	jal findMin
	nop
printResult:
	li $v0, 4
	la $a0, Message
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, tab
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	li $v0, 4
	la $a0, Message1
	syscall
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, tab
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
endmain:
	li $v0, 10
	syscall
	
#-------------------------------------------------------
#findMax
# param[in]: $s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7: 8 element of an array
# return $t0: index of max
#	$t1: the largest value
#	
#
#-------------------------------------------------------
findMax:
	add	$t1, $s0, $zero		#largest so far
	sub	$v0, $s1, $t1		#compute $s1 - $t1
	bltz	$v0, L1			#if s1 - t1 < 0 then no change 
	nop
	addi	$t0, $zero, 1		#update index of largest
	add	$t1, $s1, $zero		#update largest
L1:
	sub	$v0, $s2, $t1		#compute $s2 - $t1
	bltz	$v0, L2			#if s2 - t1 < 0 then no change 
	nop
	addi	$t0, $zero, 2		#update index of largest
	add	$t1, $s2, $zero		#update largest
L2:
	sub	$v0, $s3, $t1
	bltz	$v0, L3
	nop
	addi	$t0, $zero, 3		#update index of largest
	add	$t1, $s3, $zero		#update largest
L3:
	sub	$v0, $s4, $t1
	bltz	$v0, L4
	nop
	addi	$t0, $zero, 4		#update index of largest
	add	$t1, $s3, $zero		#update largest
L4:
	sub	$v0, $s5, $t1
	bltz	$v0, L5
	nop
	addi	$t0, $zero, 5		#update index of largest
	add	$t1, $s3, $zero		#update largest
L5:
	sub	$v0, $s6, $t1
	bltz	$v0, L6
	nop
	addi	$t0, $zero, 6		#update index of largest
	add	$t1, $s3, $zero		#update largest
L6:
	sub	$v0, $s7, $t1
	bltz	$v0, doneMax
	nop
	addi	$t0, $zero, 7		#update index of largest
	add	$t1, $s7, $zero		#update largest
doneMax:
	jr $ra			#return
	
findMin:
	add	$t2, $s0, $zero		#largest so far
	sub	$v0, $s1, $t3		#compute $s1 - $t1
	bgtz	$v0, M1			#if s1 - t1 < 0 then no change 
	nop
	addi	$t2, $zero, 1		#update index of largest
	add	$t3, $s1, $zero		#update largest
M1:
	sub	$v0, $s2, $t3		#compute $s2 - $t1
	bgtz	$v0, M2			#if s2 - t1 < 0 then no change 
	nop
	addi	$t2, $zero, 2		#update index of largest
	add	$t3, $s2, $zero		#update largest
M2:
	sub	$v0, $s3, $t3
	bgtz	$v0, M3
	nop
	addi	$t2, $zero, 3		#update index of largest
	add	$t3, $s3, $zero		#update largest
M3:
	sub	$v0, $s4, $t3
	bgtz	$v0, M4
	nop
	addi	$t2, $zero, 4		#update index of largest
	add	$t3, $s4, $zero		#update largest
M4:
	sub	$v0, $s5, $t3
	bgtz	$v0, M5
	nop
	addi	$t2, $zero, 5		#update index of largest
	add	$t3, $s5, $zero		#update largest
M5:
	sub	$v0, $s6, $t3
	bgtz	$v0, M6
	nop
	addi	$t2, $zero, 6		#update index of largest
	add	$t3, $s6, $zero		#update largest
M6:
	sub	$v0, $s7, $t3
	bgtz	$v0, doneMin
	nop
	addi	$t2, $zero, 7		#update index of largest
	add	$t3, $s7, $zero		#update largest
doneMin:
	jr $ra			#return
