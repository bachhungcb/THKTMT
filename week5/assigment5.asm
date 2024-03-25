    #Laboratory week 5, Assigment 5

.data   
Message:    .asciiz "Nhap vao xau ky tu: "
Message1:   .asciiz "\nDo dai cua xau la: "
string:     .space  100

.text   
    li      $v0,                4                                   # Print string prompt
    la      $a0,                Message
    syscall 

    li      $v0,                8                                   # Read string input
    la      $a0,                string
    li      $a1,                21                                  # Maximum length of string
    syscall 

    # Check if the input string exceeds the maximum length
    la      $t0,                string                              # $t0 holds the address of string[0]
    li      $t1,                0                                   # length = 0

count_length_loop:
    lb      $t2,                0($t0)                              #t2 = value at t0 = string[i]
    beqz    $t2,                input_end                           # if string[i] == '\0' then exit
    addi    $t0,                $t0,        1                       # Move to next character
    addi    $t1,                $t1,        1                       # length += length
    b       count_length_loop                                       # Continue loop
input_end:  
    bge     $t1,                21,         exit                    # Branch if length exceeds 20
    # Reset $t0 to point to the beginning of the string
    la      $t0,                string
    li      $s0,                0                                   # Initialize $s0 (i = 0)


reversed_string_loop:
    add     $s0,                $zero,      $s0                     #$s0 = i = 0
    sub     $s1,                $t1,        $s0                     #s1 = length - i
    add     $t3,                $s1,        $t0                     # t3 = s1 + t0 = (length - i) + string[0]
    #	       = address of string[length - i]
    lb      $t4,                0($t3)                              # t4 = value at t3 = string[length - i]

    li      $v0,                11
    move    $a0,                $t4
    syscall 

    addi    $s0,                $s0,        1                       # i++
    ble     $s0,                $t1,        reversed_string_loop    #for(int i = 0; i < length; i++)


exit:       
    li      $v0,                4                                   # Print string prompt
    la      $a0,                Message1
    syscall 

    li      $v0,                1                                   # Print string prompt
    move    $a0,                $t1
    syscall 

    # Exit the program
    li      $v0,                10                                  # Exit syscall
    syscall 
