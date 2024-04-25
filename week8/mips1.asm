.text
	li $s0, 4			#strlen
	li $t0, 2			#t0 = 2 de kiem tra chan le cua strlen
	div $s0, $t0			#hi la phan du hi = 1 tuc la strlen le, nguoc lai strlen chan
	mfhi $t1		
	beq $t1, $zero, thuchien	
	j main	
