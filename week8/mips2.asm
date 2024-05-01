
.data
words_0_19: .word words_0_19_0, words_0_19_1,words_0_19_2,words_0_19_3,  words_0_19_4,  words_0_19_5 ,   words_0_19_6 	, words_0_19_7 	, words_0_19_8,  words_0_19_9 ,	words_0_19_10,words_0_19_11,words_0_19_12,words_0_19_13,words_0_19_14,words_0_19_15,words_0_19_16,words_0_19_17,words_0_19_18,words_0_19_19  
words_0_19_0:    .asciiz " khong "
words_0_19_1:     			.asciiz " mot "
words_0_19_2:     			.asciiz " hai "
words_0_19_3 :  		  .asciiz " ba "
 words_0_19_4 :			   .asciiz " bon "
 words_0_19_5  :		  .asciiz " nam "
 words_0_19_6 	:		   .asciiz " sau "
 words_0_19_7 	:		   .asciiz " bay "
 words_0_19_8 	:		   .asciiz " tam "
 words_0_19_9 	:		   .asciiz " chin "
  words_0_19_10 :			  .asciiz " muoi "
 words_0_19_11  :			  .asciiz " muoi mot "
 words_0_19_12  :			  .asciiz " muoi hai "
words_0_19_13    :			 .asciiz " muoi ba "
 words_0_19_14   :			 .asciiz " muoi bon "
  words_0_19_15 :			  .asciiz " muoi lam "
 words_0_19_16   :			 .asciiz " muoi sau "
 words_0_19_17 	:		  .asciiz " muoi bay "
  words_0_19_18 :			  .asciiz " muoi tam "
  words_0_19_19	:		  .asciiz " muoi chin "

# Định nghĩa các từ hàng chục từ 20 đến 90
words_20_90: .word num00,num10,num20,num30,num40,num50,num60,num70,num80,num90

num00:.asciiz ""
num10:.asciiz ""
num20:.asciiz " hai muoi "
num30:.asciiz " ba muoi "
num40:.asciiz " bon muoi "
num50:.asciiz " nam muoi "
num60:.asciiz " sau muoi "
num70:.asciiz " bay muoi " 
num80:.asciiz " tam muoi "
num90:.asciiz " chin muoi "


# Định nghĩa các từ hàng đơn vị từ 0 đến 9
words_0_9: .word words_0_9_0, words_0_9_1,words_0_9_2,words_0_9_3,words_0_9_4,words_0_9_5,words_0_9_6,words_0_9_7,words_0_9_8,words_0_9_9
words_0_9_0:    .asciiz ""
words_0_9_1:    .asciiz " mot "
words_0_9_2:    .asciiz " hai "
words_0_9_3:    .asciiz " ba "
words_0_9_4:    .asciiz " bon "
words_0_9_5: 	.asciiz " lam "
words_0_9_6:    .asciiz " sau "
words_0_9_7:    .asciiz " bay "
words_0_9_8:    .asciiz " tam "
words_0_9_9:    .asciiz " chin"
space: .asciiz " "
hundred: .asciiz " tram "
million: .asciiz " trieu "
thousand: .asciiz " nghin "
message1: .asciiz "Please enter a number:"
message2: .asciiz "This is Vietnamese converted number:"

.text
main:   
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0,	5	#Read the number
	syscall
	
	move $t0, $v0	#Store number in $t0
	addi $t2, $zero, 1000	#Store 1000 in $t2 for work
	addi $t3, $zero, 1000000	#Store 1000000 in $t3 for work
	addi $t4, $zero, 10	#Store 10 in $t4 for work
	addi $t5, $zero, 100	#Store 10 in $t5 for work
numToText:
	beqz  $t0, printZero	#If the number equal zero, print it and skip the remain
	move $t1, $t0	#Store the temp number in $t1
	div  $t1, $t3  
	mflo $s1	#$s1 = a = num div 1000000
	mfhi $t6
	div  $t6, $t2
	mflo $s2	#$s2 = b = (num % 1000000)/1000
	div  $t1, $t2  
	mfhi $s3	#$s3 = c = num % 1000
checkMillion:
	bne  $s1, $zero, printMillion #If a != 0, print the million else skip
checkThousand:
	bne  $s2, $zero, printThousand #If b != 0, print the million else skip
checkHundred:
	bne  $s3, $zero, printHundred1
	j exit
printMillion:
	move $s4, $s1 #use a temp in here to store a
	jal convert
	nop
	
	li $v0, 4
	la $a0, million
	syscall
	
	j checkThousand
printThousand:
	move $s4, $s2 #use a temp in here to store b
	jal convert
	nop
	
	li $v0, 4
	la $a0, thousand
	syscall
	j checkHundred
printHundred1:
	move $s4, $s3 #use a temp in here to store c
	jal convert
	nop
	
	
	j exit	
convert:
    	# Lấy hàng trăm
    	div $s4,  $t5                   # Chia giá trị của num cho 100
   	mflo $s7                        # Lưu phần nguyen vào thanh ghi $s7
   	
   	# Lấy hàng chục
    	div $s4, $t5                    # Chia giá trị của num cho 100
    	mfhi $t8                        # Lưu phần dư vào thanh ghi $t8
    	div $t8, $t4				
    	mflo $t8
    	
   	# Lấy hàng đơn vị
    	div $s4, $t4
    	mfhi $t9                        # Lưu kết quả của phép chia vào thanh ghi $t9
   	
   	ble $s7, $zero, L1
   	sll $s7, $s7, 2
    	li $v0, 4                       # In chuỗi
    	lw $a0, words_0_19($s7)         # Load địa chỉ của từ số từ 0 đến 19 tương ứng vào $a0
    	syscall                         # Gọi hệ thống để in từ
    	
    	li $v0, 4
    	la $a0, hundred
    	syscall

L1:
    	ble $t8, 1 ,L2			#if hang chuc > 1
    	
    	li $v0, 4                       # In chuỗi
    	sll $t8, $t8, 2
    	lw $a0, words_20_90($t8)        # Load địa chỉ của từ hàng chục từ 20 đến 90 tương ứng vào $a0
    	syscall                         # Gọi hệ thống để in từ
    	
    	li $v0, 4                       # In chuỗi
    	sll $t9, $t9, 2
    	lw $a0, words_0_9($t9)          # Load địa chỉ của từ hàng chục từ 20 đến 90 tương ứng vào $a0
    	syscall                         # Gọi hệ thống để in từ
L2:
	bne $t8, 1 ,L3
	sll $t9, $t9, 2
    	addi $t9, $t9, 40
    	li $v0, 4
      	lw $a0, words_0_19($t9)
    	syscall
    	
L3:
	bne $t8, $zero, skip
	sll $t9, $t9, 2
    	li $v0, 4                       # In chuỗi
    	lw $a0, words_0_19($t9)          # Load địa chỉ của từ số hàng đơn vị từ 0 đến 9 tương ứng vào $a0
    	syscall                         # Gọi hệ thống để in từ
skip:
    	jr $ra                          # Trả về
printZero:
	li $v0,	4
	lw $a0, words_0_19($t0)
	syscall
	
	j exit	
exit:
	li $v0, 10
	syscall