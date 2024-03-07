.data
arr: 	.word	1, 3, 5, -66, 2, 4, 77, -120, 10, 2, 130
i:	.word	0
n:	.word	11
step:	.word	1

.text
	la   $s5, i
	lw   $s1, 0($s5)		#i
	
	la   $s2, arr		#Load array
	
	la   $s5, n
	lw   $s3, 0($s5)		#n
	
	la   $s5, step
	lw   $s4, 0($s5)		#step
	addi $s6, $zero, 0	#max
	
loop: 	add $t1,$s1,$s1 #t1=2*s1
	add $t1,$t1,$t1 #t1=4*s1
	add $t1,$t1,$s2 #t1 store the address of A[i]
	lw  $t0,0($t1)  #load value of A[i] in $t0
	slt $t2, $t0, $zero #A[i] < 0 ? 1 : 0
	beq $t2, $zero, continue #if A[i] > 0 then go to continue.
	sub $t0, $zero, $t0 #find the absolute value of A[i]
continue:
	slt $t3, $s6, $t0 # t3 =  max < A[i] ? 1 : 0
	beq $t3, $zero, find
	move $s6, $t0 #max = A[i]
find:	
	add $s1,$s1,$s4 #i=i+step
	bne $s1,$s3,loop #if i != n , go to loop
