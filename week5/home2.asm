 
#Laboratory Exercise 5, Home Assignment 2 
.data 
x: .space 1000                     # destination string x, empty 
y: .asciiz "Hello"                 # source string y 
newline: .asciiz "\n"
 
.text
main:
	#print x before the strcpy function
	li $v0, 4
 	la  $a0, x			
 	syscall
 	
 	jal strcpy			#Call the strcpy function 
 	
 	#print newline for better formatting
	li $v0, 4
	la $a0, newline
	syscall
 	
 	#print x after the strcpy function
 	li $v0, 4
 	la  $a0, x	
 	syscall
	
	#Exit program
	li $v0, 10
	syscall
	

strcpy: 
 	add $s0,$zero,$zero         	#s0 = i=0 
 	la $a1, y
 		
L1: 
	
	add $t1,$s0,$a1             	#t1 = s0 + a1 = i + y[0] 
                                   	#   = address of y[i] 
 	lb $t2,0($t1)              	#t2 = value at t1 = y[i] 
 	add $t3,$s0,$a0             	#t3 = s0 + a0 = i + x[0]  
                                    	#   = address of x[i] 
 	sb $t2,0($t3)              	#x[i]= t2 = y[i] 
 	beq $t2,$zero,end_of_strcpy 	#if y[i]==0, exit 
 	nop 
 	addi $s0,$s0,1               	#s0=s0 + 1 <-> i=i+1 
 	j L1                      	#next character 
 	nop 
end_of_strcpy: 
	sb $zero, 0($t3)             	# Null-terminate the destination string x
	jr $ra				# Retur to jal
