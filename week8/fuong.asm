    # write a program that check if an number is prime or not within m and n entered from keyboard
    #---------------------------------------------------------
    # An easy ALGORITHM
    #for (int j = m: j<= n;j++{
    # for (int i= 1; i <= j; i++) {
    #   if (number % i == 0) count++;
    # }
    # if (count != 2 ) print j;
    #}
    #---------------------------------------------------------
.data   
command:    .asciiz "Enter m and n: "
space:      .asciiz " "
.text   
main:       
    li      $v0,        4
    la      $a0,        command
    syscall 
    #enter m:
    li      $v0,        5
    syscall 
    move    $t0,        $v0                         #store m in $t0
    #enter n:
    li      $v0,        5
    syscall 
    move    $t1,        $v0                         #store n in $t1
    move    $s0,        $t0                         # Initialize m to j, $s0 = j
    #function to loop m to n
OUTER_LOOP: 
    bgt     $s0,        $t1,        EXIT            #if j > n then exit the program
    move    $t6,        $s0                         #move j to $t6 for check function
IS_PRIME:   
    li      $t3,        0                           # create count variable $t3 = count
    li      $t2,        1                           # initialize 1 to i :	$t2 = i
IS_PRIME_LOOP:
    div     $t6,        $t2                         #j div i
    mfhi    $t5                                     # store the ramainder into $t3
    beq     $t5,        $zero,          INCREASE_COUNT  #if remainder = 0 then count ++
    j       INCREASE_I

INCREASE_COUNT:
    addi    $t3,        $t3,        1
INCREASE_I: 
    addi    $t2,        $t2,        1               #increase i by 1
    slt     $t4,        $t6,        $t2             # check if i > number, store boolean value in $t4
    beq     $t4,        $zero,          IS_PRIME_LOOP
    # loop end
    beq     $t3,        2,          YES
    j       NO

YES:        
    li      $v0,        1		#print $s0 onto the screen
    move      $a0,        $s0
    syscall 
    
    addi    $s0,        $s0,        1               #increase j by 1
    li      $v0,        4
    la      $a0,        space
    syscall 
    
    j       OUTER_LOOP

NO:         
    addi    $s0,        $s0,        1               #increase j by 1
    j       OUTER_LOOP

EXIT:       
	li $v0 , 10
	syscall