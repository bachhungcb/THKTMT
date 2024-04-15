.data
	arr:	.space 100
	num1:	.asciiz "mot "
	num2:	.asciiz "hai "
	num3:	.asciiz "ba "
	num4:	.asciiz "bon "
	num5:	.asciiz "nam "
	num6:	.asciiz "sau "
	num7:	.asciiz "bay "
	num8:	.asciiz "tam "
	num9:	.asciiz "chin "
	numbers:	.word	num1, num2, num3, num4, num5, num6, num7, num8, num9

	
	unit1: 		.asciiz ""
	unit2:		.asciiz "muoi "
	unit3:		.asciiz "tram "
	units:		.word	unit1, unit2, unit3

	
	level1:		.asciiz ""
	level2:		.asciiz "nghin " 
	level3:		.asciiz "trieu "
	levels:		.word	level1,level2,level3
	
	Message:	.asciiz "Nhap vao mot so: "
	

	
.text

	li $v0, 4	#print Nhap vao mot so:  onto the screen
	la $a0, Message
	syscall

	li $v0, 8	#input the number into the array
	la $a0, arr
	li $a1, 100
	syscall

	jal strlen	#call the strlen function
	nop
	
	jal numToText
	nop
	
	j exit
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
# numToText() = a function converts given number into Vietnamese text
# param[in] = (base address of given number)
# param[in] = (base address of numbers array)
# param[in] = (base address of unit array)
# param[in] = (base address of level array)
# param[in] = $s0 (index 1)
# param[in] = $t0 (length of given number)
# output = Vietnamese text of given number

numToText:
	xor $s0, $zero, $zero		#int i = 0
	xor $t1, $zero, $zero		#pointer to element in array
	add $s6, $zero, 3		#s6 = 3 for division later in the program
	addi $t5, $t0, -1		#t5 = length - 1 for comparision later in the program
	
startnumToText:
	beq $s0, $t0, exitnumToText	#for(i; i < length; i++)
	
	lb $t8, arr($t1)		#t8 = arr[i]
	addi $t8, $t8, -49		#(arr[i] - 48) - 1
	move $t7, $t8			#t7 = $t8
	sll  $t8, $t8, 2
	bge  $t7, $zero, printNumber

doneprintNumber:
	sub, $t2, $t0, $s0		#t2 = length - i
	addi, $t2, $t2, -1		#t2 = length - i - 1
	
	div $t2, $s6			#$t2 / 3 was stored in lo, $t2 % 3 was stored in hi
	
	mfhi	$t3			#t3 = $t2 % 3
	sll $t3, $t3, 2
	mflo	$t4			#t4 = $t2 /3
	sll $t4, $t4, 2

	beq $s0, $t5,	noChange	#if i!= length - 1
	beq $t3, $zero, printLevel	#&& t3 == 0

	j  printUnit
	
noChange:
	nop
	addi $t1, $t1, 1		#t1++
	addi $s0, $s0, 1		#i++
	j startnumToText
	
exitnumToText:
	jr $ra

printLevel:
	li $v0, 4
	lw $a0, levels($t4)
	syscall
	j noChange
	
printUnit:
	li $v0, 4
	lw $a0, units($t3)
	syscall
	
	j	noChange

printNumber:
	li $v0, 4
	lw $a0, numbers($t8)		#number[(arr[i] - 48) - 1]
	syscall
	
	j doneprintNumber
	
#-----------------------------------------------------------	

exit:
	li $v0, 10
	syscall
