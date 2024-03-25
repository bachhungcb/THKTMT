.data
    Message:    .asciiz "Nhap vao xau ky tu: "
    string:     .space  100
    reversed:   .space  100

.text
    # Print string prompt
    li $v0, 4
    la $a0, Message
    syscall

    # Read string input
    li $v0, 8
    la $a0, string
    li $a1, 20
    syscall

    # Check if the input string exceeds the maximum length
    la $t0, string          # $t0 holds the address of string[0]
    la $t6, reversed        # $t6 holds the address of reversed[0]
    li $t1, 0               # length = 0
    li $s0, 0               # i = 0
count_length_loop:
    lb $t2, 0($t0)          # t2 = value at t0 = string[i]
    beqz $t2, input_end     # if string[i] == '\0' then exit
    addi $t0, $t0, 1        # Move to next character
    addi $t1, $t1, 1        # length += 1
    j count_length_loop     # Continue loop
input_end:
    bge $t1, 20, exit       # Branch if length exceeds 20

    # Reverse the string
    la $t0, string          # Reset $t0 to point to the beginning of the string
    li $s0, 0               # Initialize $s0 (i = 0)
reversed_string_loop:
    sub $s1, $t1, $s0       # s1 = length - i
    add $t3, $s1, $t0       # t3 = s1 + t0 = (length - i) + string[0]
                            #       = address of string[length - i]
    lb $t4, 0($t3)          # t4 = value at t3 = string[length - i]

    add $t5, $s0, $t6       # t5 = s0 + t6 = i + reversed[0]
                            #             = address of reversed[i]
    sb $t4, 0($t5)

    addi $s0, $s0, 1        # i++
    bne $s0, $t1, reversed_string_loop # for(int i = 0; i < length; i++)

    # Print the reversed string
    li $v0, 4
    la $a0, reversed
    syscall

exit:
    # Exit the program
    li $v0, 10
    syscall
