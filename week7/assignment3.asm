#Laboratory Exercise 7, Home Assignment 3
.text
	li $t0 ,10
	li $t1, 20
push:    
      addi    $sp,$sp,-8         		  #adjust the stack pointer
      sw      $t0,4($sp)            	  #push $t0 to stack
      sw      $t1,0($sp)            	  #push $t1 to stack
work:    
      nop     
      nop     
      nop     
pop:    
      lw      $s0,0($sp)              	#pop from stack to $s0
      lw      $s1,4($sp)              	#pop from stack to $s1
      addi    $sp,    $sp,    8           #adjust the stack pointer