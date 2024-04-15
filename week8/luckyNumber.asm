.data
	arr: 	.space 100
	message:	.asciiz "\nNhap vao 1 so: "
	trueM:	.asciiz	"true"
	falseM:	.asciiz "false"
	errorM: .asciiz "Chi duoc nhap so!"
	errorDai: .asciiz "Vui long nhap vao so be hon 1 ty"
	
.text
main:
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 8		#input given string
	la $a0, arr
	li $a1, 100
	syscall
		
	jal	strlen	#t0 = length
	nop
	bge	$t0, 13, errorDai
	
	jal	isLuckyNumber	#t1 = 1 if it is luckyNumber else t1 = 0
	nop
	
#print the result on the screen

	beq	$t1, $zero, falseP
	li	$v0, 4
	la	$a0, trueM
	syscall
	j 	exit
falseP:
	li	$v0, 4
	la	$a0, falseM
	syscall
	j exit		#end of program
	

#-----------------------------------------------------------	
# strlen() 	= find length of a given string
# param[in] 	= $a0 (address of given string) 
# param[out]	= $t0 (length of given string)
#
#	
strlen:
	la	$a0, arr		#a0 = address(arr[0])
	xor	$v0, $zero, $zero	#v0 = length = 0
	xor 	$t0, $zero, $zero	#t0 = i = 0
checkchar:
	add 	$t1, $a0, $t0		#t1 = address(arr[0] + i)
	lb	$t2, 0($t1)		#t2 = arr[i]
	beq	$t2, $zero, endOfstrlen #is null char?
	addi	$v0, $v0, 1		#length += length
	addi 	$t0, $t0, 1		# i++
	j 	checkchar
endOfstrlen:
	move $t0, $v0			#return the length of string
	addi, $t0 ,$t0, -1		#Need -1 because of '\0' 
	
	jr	$ra 

#-----------------------------------------------------------	

#-----------------------------------------------------------	
# isLuckyNumber() 	= 	a function to find if the given number is lucky number or not
#				return 1 if yes and 0 otherwise
#
# param[in]	=	$a0 address of given number
# param[in]	=	$t0 length of given number
# param[out]	=	$t1 result of the function
#

isLuckyNumber:
	la	$a0, arr			#load address of arr[0]
	srl 	$s0, $t0, 1			#int left = length / 2
	addi	$s0, $s0, -1			#int left(s0) = length / 2 - 1
	srl	$s1, $t0, 1			#int right(s1) = length / 2
	
	xor 	$s2, $zero, $zero		#int leftSum(s2) = 0
	xor 	$s3, $zero, $zero		#int rightSum(s3) = 0
loop:	
	blt	$s0, $zero, endloop		#while (left >= 0)
	
	add	$t1, $a0, $s0			#t1 = address of arr[left]
	lb	$t2, 0($t1)			#t2 = arr[left]
	addi 	$t2, $t2, -48			#t2 = arr[left] - 48
	bge	$t2, 10, errorMessage
	add	$s2, $s2, $t2			#leftSum(s2) = leftSum + arr[left]
	addi	$s0, $s0, -1			#left--;
	
	add	$t3, $a0, $s1			#t3 = address of arr[right]
	lb	$t4, 0($t3)			#t4 = arr[right]
	addi	$t4, $t4, -48			#t4 = arr[right] - 48
	bge	$t4, 10, errorMessage
	add	$s3, $s3, $t4			#rightSum(s3) = rightSum + arr[right]
	addi	$s1, $s1, 1			#right++;

	j	loop
endloop:
	seq	$t5, $s2, $s3			#if rightSum = leftSum then t5 = 1 else t5 = 0		
	beq	$t5, $zero, return0		#if rightSum != leftSum go to return 0
	addi	$t1, $zero, 1			#else rightSum == leftSum, given number is lucky number then, return 1
	j	endOfluckyNumber
return0:		
	addi	$t1, $zero, 0
endOfluckyNumber:
	jr	$ra				#return to main function

#-----------------------------------------------------------	

errorMessage:
	li $v0, 4
	la $a0, errorM
	syscall
	
	j main
	
errordai:
	li $v0, 4
	la $a0, errorDai
	syscall
	
	j main
	
exit:
	li $v0, 10
	syscall


