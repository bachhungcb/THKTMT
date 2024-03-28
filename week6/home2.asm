    #Laboratory Exercise 6, Assignment 2
.data   
A:          .word   -6, 93, 54, 10, 79, 58, 71, 32
Aend:       .word   
message:    .asciiz ","
sorted:	     .asciiz "\nSorted array:\t"
unsorted:   .asciiz "Unsorted array:\t"
newline:    .asciiz "\n"

.text   
main:       
    la      $a0,        A                                   #$a0 = Address(A[0])
    la      $a1,        Aend
    addi    $a1,        $a1,        -4                      #$a1 = Address(A[n-1])
    sub	    $s6, $a1, $a0				      #$s6 is length of array, because $a0 is A[0], and $a1 is A[n-1]
    srl	    $s6, $s6, 2					      #then array length = (address of A[n-1] - address of A[0]) / 4	
    
    li      $v0,        4                                   #Print "Unsorted array:"
    la      $a0,        unsorted
    syscall
    la      $a0,        A                                   #$a0 = Address(A[0])	
printUnsorted:
    add     $s0,        $zero,      $s0                     #index i
    slt     $s1,        $s0,        $s6                     #s1 is length of array A
    bgt     $s0,        $s6,        gotosorted              #for(i = 0; i <= length; i++)
    add     $s3,        $s0,        $s0                     # $s3 = i+i
    add     $s3,        $s3,        $s3                     # $s3 = 4*i
    add     $s4,        $s3,        $a0                     #load the address of A[i] in to $s4
    lw      $s5,        0($s4)                              #$s5 = A[i]

    li      $v0,        1                                   #Print the unsorted array on the Run I/O
    move    $a0,        $s5
    syscall 
	
    beq     $s0, $s6, skip1				      #If it is the last element in array, don't print "," on the screen		
    li      $v0,        4                                   #Print an "," between an element for better readability
    la      $a0,        message
    syscall
skip1:     
    addi    $s0,        $s0,        1
    la      $a0,        A                                   #$a0 = Address(A[0])
    j printUnsorted
gotosorted:     	 	 	 	
    j       sort                                            #sort
after_sort:
    li      $v0,        4                                   #Print an "Sorted Array:"
    la      $a0,        sorted
    syscall
    
    la      $a0,        A                                   #$a0 = Address(A[0])
    la      $a1,        Aend				      #reinitialize the value of register for below code	
    add     $s0, $zero, $zero
    add     $s3, $zero, $zero
    add     $s4, $zero, $zero
    add     $s5, $zero, $zero				 
printSorted:	
    add     $s0,        $zero,      $s0                     #index i
    slt     $s1,        $s0,        $s6                     #s1 is length of array A
    bgt     $s0,        $s6,        exit                    #for(i = 0; i <= length; i++)
    add     $s3,        $s0,        $s0                     # $s3 = i+i
    add     $s3,        $s3,        $s3                     # $s3 = 4*i
    add     $s4,        $s3,        $a0                     #load the address of A[i] in to $s4
    lw      $s5,        0($s4)                              #$s5 = A[i]

    li      $v0,        1                                   #Print the sorted array on the Run I/O
    move    $a0,        $s5
    syscall 
	
    beq $s0, $s6, skip	
    li      $v0,        4                                   #Print an "," between an element for better readability
    la      $a0,        message
    syscall 
	
skip:
    addi    $s0,        $s0,        1
    la      $a0,        A                                   #$a0 = Address(A[0])
    j       printSorted
exit:       
    li      $v0,        10                                  #exit
    syscall 
end_main:   
    #--------------------------------------------------------------
    #procedure sort (ascending selection sort using pointer)
    #register usage in sort program
    #$a0 pointer to the first element in unsorted part
    #$a1 pointer to the last element in unsorted part
    #$t0 temporary place for value of last element
    #$v0 pointer to max element in unsorted part
    #$v1 value of max element in unsorted part
    #--------------------------------------------------------------
sort:
    la 		$a0, A       
    beq     $a0,        $a1,        done                    #single element list is sorted
    j       max                                             #call the max procedure
after_max:  
    lw      $t0,        0($a1)                              #load last element into $t0
    sw      $t0,        0($v0)                              #copy last element to max location
    sw      $v1,        0($a1)                              #copy max value to last element
    addi    $a1,        $a1,        -4                      #decrement pointer to last element
    
    
    li $v0,4
    la $a0, newline
    syscall
    jal     printarray
    	
    j       sort                                            #repeat sort for smaller list
done:       
    j       after_sort

    #------------------------------------------------------------------------
    #Procedure max
    #function: fax the value and address of max element in the list
    #$a0 pointer to first element
    #$a1 pointer to last element
    #------------------------------------------------------------------------
max:        
    addi    $v0,        $a0,        0                       #init max pointer to first element
    lw      $v1,        0($v0)                              #init max value to first value
    addi    $t0,        $a0,        0                       #init next pointer to first
loop:       
    beq     $t0,        $a1,        ret                     #if next=last, return
    addi    $t0,        $t0,        4                       #advance to next element
    lw      $t1,        0($t0)                              #load next element into $t1
    slt     $t2,        $t1,        $v1                     #(next)<(max) ?
    bne     $t2,        $zero,      loop                    #if (next)<(max), repeat
    addi    $v0,        $t0,        0                       #next element is new max element
    addi    $v1,        $t1,        0                       #next value is new max value
    

    j       loop                                            #change completed; now repeat
ret:        
    j       after_max
    
    
printarray:
	la $t0, A		#address of A[0]
	add $t8, $zero, $zero 	#k = 0
	add $t2, $t2, $zero	#initialize for printing array
	add $t3, $t3, $zero	#initialize for printing array	
	add $t4, $t4, $zero	#initialize for printing array
loopprint:
	bgt $t8, $s6, exitprint	#if k >= n  then exit or for (k = 0; k < n; k++)
	add $t2, $t8, $t8	#t2 = k+k
	add $t2, $t2, $t2	#t2 = 4*k
	add $t3, $t2, $t0	#t3 = address of A[k]
	lw  $t4, 0($t3)		#t4 = A[k]
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, message
	syscall 
	
	addi $t8, $t8, 1
	j loopprint
exitprint:	
	jr $ra    
