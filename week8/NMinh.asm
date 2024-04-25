.data
    space: .asciiz " "
    array: .word 8, -1, 5, 3, -1, 10, 6
    length: .word 7  # Length of the array
.text
main:
	la $a0, array  # Load the address of the array into $a0
    	lw $s0, length  # Load the length of the array into $a1
    	li $t0,0	#i=0\
    	li $s2,-1
    	li $t1, 0
    	
    	outer_loop:
    		bge $t0,$s0,end_outer_loop
    		beq $t2, $s2, end_inner_loop
    		add $t1, $zero, $zero
    		inner_loop:
    			bge $t1,$s0,end_inner_loop
    		    	sll $t3,$t0,2
    			add $t4, $t3, $a0 
    			lw $t2,0($t4)			#a[i]
    			
    			sll $t5,$t1,2
    			add $t6, $t5, $a0 
    			lw $t7,0($t6)		#a[j]
    			
    			beq $t7, $s2, skip_j
    			beq $t2, $s2, skip_j


        		bgt $t2,$t7,swap
			j skip_j
			
		swap:
			sw $t2,0($t6)		
			sw $t7,0($t4)
		skip_j:
        		addi $t1, $t1, 1    # j++
        		j inner_loop
    		
		end_inner_loop:
    		addi $t0, $t0, 1    # i++
    		j outer_loop

	end_outer_loop:

print:
    la $a3, array  # Load the address of the array into $a0
    lw $a1, length  # Load the length of the array into $a1

    # Loop to print each element of the array
    loop:
        lw $t0, 0($a3)  # Load the current element into $t0

        # Print the current element
        li $v0, 1
        move $a0, $t0
        syscall

        # Print a space
        li $v0, 4
        la $a0, space
        syscall

        addiu $a3, $a3, 4  # Move to the next element
        addiu $a1, $a1, -1  # Decrement the length
        bgtz $a1, loop  # If length > 0, repeat the loop

    # Exit the program
    li $v0, 10
    syscall

