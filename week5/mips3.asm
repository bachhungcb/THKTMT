.data
  filename: .asciiz "C:\\Users\\Admin\\OneDrive - Hanoi University of Science and Technology\\20232\\THKTMT\\MARS\\THKTMT\\week5\\Idol-Yoasobi.mid"
  buffer: .space 1024

.text
  li $v0, 33  
li $a0, 42    #pitch 
li $a1, 500  #time 
li $a2, 0     #musical instrusment 
li $a3, 212   #volume 
syscall

  li $v0, 33  
li $a0, 42    #pitch 
li $a1, 500  #time 
li $a2, 1     #musical instrusment 
li $a3, 212   #volume 
syscall
