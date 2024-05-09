    .eqv MONITOR_SCREEN, 0x10010000  #Dia chi bat dau cua bo nho man hinh
    .eqv RED, 0x00FF0000             #Cac gia tri mau thuong su dung
    .eqv GREEN, 0x0000FF00
    .eqv BLUE, 0x000000FF
    .eqv WHITE, 0x00FFFFFF
    .eqv YELLOW, 0x00FFFF00
    .eqv BLACK, 0x00000000
.text
li      $k0,    MONITOR_SCREEN #Nap dia chi bat dau cua man hinh

#right square
li      $t0,    RED	 	#first row    
sw      $t0,    8($k0)
nop 

li      $t0,    RED	    
sw      $t0,    12($k0)
nop     

li      $t0,    RED	     	#second row
sw      $t0,    24($k0)
nop     

li      $t0,    RED	     	
sw      $t0,    28($k0)
nop     

#left square

li      $t0,    RED	 	#first row    
sw      $t0,    4($k0)
nop 

li      $t0,    RED	    
sw      $t0,    8($k0)
nop     

li      $t0,    BLACK	   	#delete the previous square  	
sw      $t0,    12($k0)
nop     


li      $t0,    RED	     	#second row
sw      $t0,    20($k0)
nop     

li      $t0,    RED	     	
sw      $t0,    24($k0)
nop     

li      $t0,    BLACK	     	#delete the previous square
sw      $t0,    28($k0)
nop     

#left most square

li      $t0,    RED	 	#first row    
sw      $t0,    0($k0)
nop 

li      $t0,    RED	    
sw      $t0,    4($k0)
nop     

li      $t0,    BLACK	   	#delete the previous square  	
sw      $t0,    8($k0)
nop     

li      $t0,    RED	     	#second row
sw      $t0,    16($k0)
nop     

li      $t0,    RED	     	
sw      $t0,    20($k0)
nop     

li      $t0,    BLACK	     	#delete the previous square
sw      $t0,    24($k0)
nop     

