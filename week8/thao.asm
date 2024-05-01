.data
	Name: .space 100
	Temp: .space 100
	Space: .asciiz " "
	Message1: .asciiz "Hay nhap vao ten (duoi 100 ki tu): "
	Message2: .asciiz "\n Ten dao nguoc la: "
	
	
.text
	
	li $v0, 54                #input Name from the keyboard
	la $a0, Message1
	la $a1, Name
	la $a2, 100               #space = 100
	syscall 
	
	la $s0, Name     
	
	jal strlen		#s1 = strlen
	nop
	
	add $s0, $s0, $s1	#s0 = name[strlen]
	li $s2, 0		#s2 ='\0'
	sb $s2, 0($s0)		#name[strlen] = '\0'
	la $s0, Name		#s0 = name[0]
	
	jal printReversedName 
	
	
#------------------------------------------------
#print reversed Name


	li $v0, 10      #exit
	syscall 

#-----------------------------------------------
#print Reversed Name
	
printReversedName:
	 addi $t1, $t1, -1    #init lastSpaceIndex
			
	 addi $t0, $t0, 0     #find location of last space index, index i = 0

      #Find last space of the Name inputed from the keyboard
	Find_last_space: 
		lb $t2, Name($t0)              #load Name[i]
		beq $t2, $zero, end_Find_last_space  #for(int i=0; Name[i] != '\0'; i++)
		
		beq $t2, 32, update_last_space_index    #if Name[i] == ' '
		
		addi $t0, $t0, 1                         #i=i+1
		j Find_last_space
		
	      update_last_space_index:
			move $t1, $t0        # update lastSpaceIndex = i
    			addi $t0, $t0, 1     #i=i+1
    			j Find_last_space
		
	end_Find_last_space: 
	
	
     #copy name to temp
     la $t3, Temp           # $t3 = address of temp
     add $t0, $zero, $zero
     
     strcpy:
        beq $t0, $t1, end_strcpy #if i = LastSpaceIndex, exit
     	add $t4, $s0, $t0     #$t4 = $s0 + $t3 = Name[0] + i = address of Name[i]
     	lb $t5, 0($t4)        #$t5 = value at $t4 = Name[i]
     	add $t6, $t0, $t3     #$t6 = $t0 + $t3 = i + temp[0] = address of temp[i]
     	sb $t5, 0($t6)        #temp[i] = $t5 = Name[i]
     	addi $t0, $t0, 1        #i=i+1
     	j strcpy
     end_strcpy: 


    beq $t1, -1, print_original    #if(lastSpaceIndex != -1), else print original
    
    li $v0, 4
    la $a0, Message2
    syscall 
    
    la $a0, Name
    addi $t1, $t1, 1
    add $a0, $a0, $t1
   
    li $v0, 4
    syscall 
    
    li $v0, 4
    la $a0, Space
    syscall
    
    li $v0, 4
    la $a0, Temp
    syscall
    
    j end
    
print_original:
    li $v0, 4
    la $a0, Name
    syscall
    
    
end:
    jr $ra	
    
#-----------------------------------------------------------	
# strlen() 	= find length of a given string
# param[in] 	= $a0 (address of given string) 
# param[out]	= $s1 (length of given string)
#
#	
strlen:
	la	$a0, Name		#a0 = address(arr[0])
	xor	$v0, $zero, $zero	#v0 = length = 0
	xor 	$s1, $zero, $zero	#s1 = i = 0
checkchar:
	add 	$t1, $a0, $s1		#t1 = address(arr[0] + i)
	lb	$t2, 0($t1)		#t2 = arr[i]
	beq	$t2, $zero, endOfstrlen #is null char?
	addi	$v0, $v0, 1		#length += length
	addi 	$s1, $s1, 1		# i++
	j 	checkchar
endOfstrlen:
	move $s1, $v0			#return the length of string
	addi, $s1 ,$s1, -1		#Need -1 because of '\0' 

	jr	$ra 

#-----------------------------------------------------------	