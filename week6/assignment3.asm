    #Laboratory Exercise 6, Assignment 3
.data
A: 		.word 		8, -1, 5, 3, -1, 10, 6
Aend:		.word
unsorted:	.asciiz "Unsorted array: "
messsge:	.asciiz "Sorted array: "
message1: 	.asciiz ","
newline:	.asciiz "\n"

.text
	la $t0, A		#address of A[0]
	la $t1, Aend
	sub $s0, $t1, $t0
	srl $s0, $s0, 2		#length of A (n)
	add $s1, $s1, $zero 	#i = 0
	addi $s1, $s0, -1	#i = n - 1
	addi $s2, $zero, 0	#j = 0
	addi $t9, $t9, 0	#t9 = swap
	
	li $v0, 4
	la $a0, unsorted
	syscall
	
	jal printarray			#print unsorted array 
	
	li $v0, 4
	la $a0, newline			#print newline for better readability
	syscall
		 
loop1:
	ble $s1, $zero, exiti	#if i <= 0  then exit or for (i = n-1; i >=0; i--)
	addi $t9, $zero, 0	#swap = 0
loop2:	
	bge $s2, $s1, exitj	#for(j = 0; j < i; j++)
	addi $s3, $s2, 1	#j+1
	
	
L1:
	add $t5, $s2, $s2	#t5 = j+j
	add $t5, $t5, $t5	#t5 = 4*j
	add $t6, $t5, $t0	#t6 = address of A[j]
	lw  $t7, 0($t6)		#t7 = A[j]
	

	add $t2, $s3, $s3	#t2 = (j+1)+(j+1)
L2:
	add $t2, $t2, $t2	#t2 = 4*(j+1)
	add $t3, $t2, $t0	#t3 = address of A[j+1]
	lw  $t4, 0($t3)		#t4 = A[j+1]
	
        beq $t7, -1, L1
        beq $t4, -1, L3
	
	sgt $s3, $t4, $t7	#s3 = (A[j] > A[j+1])? 1 : 0
	bne $s3, $zero, exitif #if A[j] <= A[j+1] then don't swap


	sw $t7, 0($t3)		#swap A[j] and A[j+1] based on their address
	sw $t4, 0($t6)
	addi  $t9, $zero, 1	#swap = 1
	
exitif:		
	addi $s2, $s2, 1	#j = j+1
	j loop2
skip:
	addi $s2, $s2, 1
	j loop2
L3:
	addi $t2, $t2, 4
	j L2
exitj: 
	
	addi $s1, $s1, -1		# i--;
	add $s2, $zero, $zero		# j=0
	beq  $t9, $zero, dontprint	#if(swap ==0) then dont print array
	jal printarray			#print array after a step of bubble sort 
	
	li $v0, 4
	la $a0, newline			#print newline for better readability
	syscall 
dontprint:
	j loop1
exiti:
	
	li $v0, 4
	la $a0, messsge
	syscall
	
	la $t0, A		#address of A[0]
	add $s1, $zero, $zero 	#i = 0
	add $t2, $t2, $zero	#initialize for printing array
	add $t3, $t3, $zero	#initialize for printing array
	add $t4, $t4, $zero	#initialize for printing array
	
loop:
	bge $s1, $s0, end	#if i >= n  then exit or for (i = 0; i < n; i++)
	add $t2, $s1, $s1	#t2 = i+i
	add $t2, $t2, $t2	#t2 = 4*i
	add $t3, $t2, $t0	#t3 = address of A[i]
	lw  $t4, 0($t3)		#t4 = A[i]
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, message1
	syscall 
	
	addi $s1, $s1, 1
	j loop
end:
	li $v0, 10
	syscall

printarray:
	la $t0, A		#address of A[0]
	add $t8, $zero, $zero 	#k = 0
	add $t2, $t2, $zero	#initialize for printing array
	add $t3, $t3, $zero	#initialize for printing array	
	add $t4, $t4, $zero	#initialize for printing array
loopprint:
	bge $t8, $s0, exitprint	#if k >= n  then exit or for (k = 0; k < n; i++)
	add $t2, $t8, $t8	#t2 = k+k
	add $t2, $t2, $t2	#t2 = 4*k
	add $t3, $t2, $t0	#t3 = address of A[k]
	lw  $t4, 0($t3)		#t4 = A[k]
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, message1
	syscall 
	
	addi $t8, $t8, 1
	j loopprint
exitprint:	
	jr $ra			#after printing array, return to buble sort function
