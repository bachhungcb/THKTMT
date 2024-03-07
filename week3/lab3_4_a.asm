
.text
	addi $s2, $zero, 3 #j
	addi $s1, $zero, 5 #i
	addi $s3, $zero, 3 #m
	addi $s4, $zero, 4 #n
	add  $s5, $s1, $s2 #i + j
	add  $s6, $s3, $s4 #m + n
	
	start:
		sle $t0,$s5,$s6 # i+j <= m+n ? 1 : 0
		beq $t0,$zero,else # branch to else if i + j > m + n 
		addi $t1,$t1,1 # then part: x=x+1
		addi $t3,$zero,1 # z=1
		j endif # skip “else” part
	else: 	addi $t2,$t2,-1 # begin else part: y=y-1
		add $t3,$t3,$t3 # z=2*z
	endif:
