#Laboratory 8, Assignment 1
.data
	arr: 		.space 100	#initialize the array
	Message:	.asciiz "Nhap vao so n: "
	Message1:	.asciiz "\nNhap vao so m: "
	Message2:	.asciiz "\nNhap vao so M: "
	Message3:	.asciiz "\nPhan tu lon nhat la: "
	Message4:	.asciiz	"\nTong trong doan tu m den M la: "
.text
	li $v0, 51		#input the integer n from the keyboard
	la $a0, Message
	syscall
	move $s0, $a0		#s0 = n (length of the given array)
	
	jal inputArray		#go to input array function
	
	jal findMax
	
	li $v0, 4		#print Phan tu lon nhat la:  onto the screen
	la $a0, Message3
	syscall
	
	li $v0 ,1		#print max onto the screen
 	move $a0, $s3
 	syscall 
 	
	li $v0, 51		#input the integer m from the keyboard
	la $a0, Message1
	syscall
	move $s1, $a0		#s1 = m
	
	li $v0, 51		#input the integer M from the keyboard
	la $a0, Message2
	syscall
	move $s2, $a0		#s2 = M
	
	jal findSum

	li $v0, 4		#print Tong trong doan tu m den M la: onto the screen
	la $a0, Message4
	syscall
	
	li $v0 ,1		#print sum onto the screen
 	move $a0, $s4
 	syscall 	

	j exit
#--------------------------------------------------------
# inputArrary() = function to input an array from the keyboard
# param[in] 	= (base address of the array)
# param[out] 	= (base address of the array)
#
#
inputArray:
	addi $t1, $zero, 0	#index i = 0
	
input:
	beq $t1, $s0, exitinputArray	#while(i != n)
	li $v0, 5			#input integer from the keyboard
	syscall			
	
	sw $v0, arr($t0)		#value of arr[i] = value of the integer inputed from the keyboard
	addi $t0, $t0, 4		#go to the next element in array
	addi $t1, $t1, 1		#i++
	
	j input
	
exitinputArray:
	jr $ra			#return to main function
#--------------------------------------------------------

#--------------------------------------------------------
#
# findMax() = a function to find max value from a given array
# param[in] = base address of a given array
# param[in] = $s0 length of the given array
# param[out] = $s3 maximum element in the given array

findMax:
	xor $s3, $zero, $zero		#int max = 0
	xor $t0, $zero, $zero		#reset the array pointer 
	xor $t1, $zero, $zero		#index i = 0
startfindMax:
	beq $t1, $s0, endfindMax	#for(int i = 0; i < n; i++)
	lw  $t2, arr($t0)		#t2 = arr[i]
	
	slt $t4, $s3, $t2		# t4 = (max < arr[i])? 1 : 0
	beq $t4, $zero, noChange	# if t4 = 0, then max >= arr[i], then no change in max
	move $s3, $t2
	
noChange:
	addi $t0, $t0, 4		#go to the next element in array
	addi $t1, $t1, 1		#i++;
	j startfindMax
endfindMax:
	jr	$ra		#return to main function
#--------------------------------------------------------

#--------------------------------------------------------
# findSum() = a fuction to find sum from the range m and M with m and M are typed from the keyboard
# param[in] = base address of the given array
# param[in] = $s0 length of given array
# param[in] = $s1 = m
# param[in] = $s2 = M
# param[out] = $s4 = sum 

findSum:
	xor $s4, $zero, $zero		#int sum = 0
	xor $t0, $zero, $zero		#reset the array pointer 
	add $t1, $zero, $s1		#index i = m
	sll $t5, $t1, 2
	add $t0, $t0, $t5

startfindSum:
	bgt $t1, $s2, exitfindSum	#for(int i = n; i <= M; i++)
	lw  $t2, arr($t0)		#t2 = arr[i]
	
	add $s4, $s4, $t2		#sum += arr[i]
		
	addi $t0, $t0, 4		#go to the next element in array
	addi $t1, $t1, 1		#i++;
	j startfindSum
exitfindSum:
	jr	$ra		#return to the main function

#--------------------------------------------------------


exit:
	li $v0, 10		#exit the program
	syscall