.eqv SEVENSEG_LEFT    0xFFFF0011 # Dia chi cua den led 7 doan trai. 
                                    #     Bit 0 = doan a;  
                                    #     Bit 1 = doan b; ...  
                                    #     Bit 7 = dau . 
.eqv SEVENSEG_RIGHT   0xFFFF0010 # Dia chi cua den led 7 doan phai 
 
.text 
main: 
          li    $a0,  0x3F          	# 0 
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X06          	# 1
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
          
          li    $a0,  0X5B          	# 2
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
          
          li    $a0,  0X4F          	# 3
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X66          	# 4
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X6D          	# 5
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X7D          	# 6 
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
          
          li    $a0,  0X07          	# 7
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X7F          	# 8 
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X6F          	# 9 
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
         li    $a0,  0X7F          	# 8 
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X07          	# 7
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
          
          li    $a0,  0X7D          	# 6
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
          
          li    $a0,  0X6D          	# 5
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X66          	# 4
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X4F        	# 3
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X5B          	# 2
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
          
          li    $a0,  0X06          	# 1
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
          li    $a0,  0X3F          	# 0
          jal   SHOW_7SEG_LEFT          	# show 
          nop 
         
exit:     li    $v0, 10 
          syscall 
endmain: 
 
#--------------------------------------------------------------- 
# Function  SHOW_7SEG_LEFT : turn on/off the 7seg 
# param[in]  $a0   value to shown        
# remark     $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_LEFT:  li   $t0,  SEVENSEG_LEFT # assign port's address  
                 sb   $a0,  0($t0)        # assign new value   
                 nop 
                 jr   $ra 
                 nop 
                  
#--------------------------------------------------------------- 
# Function  SHOW_7SEG_RIGHT : turn on/off the 7seg 
# param[in]  $a0   value to shown        
# remark     $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_RIGHT: li   $t0,  SEVENSEG_RIGHT # assign port's address 
                 sb   $a0,  0($t0)         # assign new value  
                 nop 
                 jr   $ra    
                 nop
