.data
	Message: .space 100
.text 
li  $v0, 8 
la  $a0, Message 
li  $a1, 100 
syscall  