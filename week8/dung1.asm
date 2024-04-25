.data
prompt:     .asciiz "Write your ticket number: "
lucky:      .asciiz "Lucky"
not_lucky:  .asciiz "Not Lucky"
buffer:     .space 1000 

.text
main:
    # Print prompt
    la $a0, prompt
    li $v0, 4
    syscall

    # Read ticket number
    li $v0, 8
    la $a0, buffer
    li $a1, 1000
    syscall
    
    move $s0, $a0 
    
    addi $t8,$t8,0		#index i = 0
    
loop:                     
    add 	$t0, $s0, $t8     
    lb 		$t1, 0($t0)        
    beq 	$t1, $zero, end_loop  	
    addi 	$t8, $t8, 1      
    j loop                
end_loop:   
    addi $t8, $t8, -1
    srl $t8, $t8, 1
    move $t9,$t8
    addi $t2, $t2, 0
    li $t5, 0 # sum of first half
    li $t6, 0 # sum of second half   
    addi $t7,$t7,0
    
check_lucky:
    beq $t2,$t8,check_result
    add $t3,$s0,$t9  #kí tự đầu
    add $t4,$s0,$t2  #kí tự cuối
    lb $s1,0($t3)  #load kí tự ở $t3  
    lb $s2,0($t4)  #load kí tự ở $t4
    add $t5,$t5,$s1 #cộng tổng kí tự nửa đầu
    add $t6,$t6,$s2 #cộng tổng kí tự nửa sau 
    addi $t9,$t9,1
    addi $t2,$t2,1
    j check_lucky
        
                                
check_result:
    beq $t5, $t6, print_lucky
    j print_not_lucky

print_lucky:
    la $a0, lucky
    li $v0, 4
    syscall
    j exit

print_not_lucky:
    la $a0, not_lucky
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall