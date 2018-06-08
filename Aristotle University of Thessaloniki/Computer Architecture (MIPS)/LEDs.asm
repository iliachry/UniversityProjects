			.data 
Run: 		.asciiz "\n Run the program: "
K:   		.asciiz "K"
user:   	.space 2
switch_1: 	.asciiz "\n Switch 1: "
switch_2: 	.asciiz "\n Switch 2: "
switch_3: 	.asciiz "\n Switch 3: "
On: 		.asciiz "On "
Off: 		.asciiz "Off "
Led1:		.asciiz " \n \t \t  Led1 is: "
Led2:		.asciiz ", Led2 is: "
Led3:		.asciiz ", Led3 is: "
start:		.asciiz "\t Please insert the state of the three switches \n" 
			.text
			
main:			la $a0,start
			li $v0, 4
			syscall

			la $a0 , switch_1         #switch_1 
			li $v0, 4
			syscall
			
			li $v0, 5
			syscall
			sw $v0,0($gp)
			
			la $a0 , switch_2         #switch_2 
			li $v0, 4
			syscall
			
			li $v0, 5
			syscall
			sw $v0,4($gp)
			
			la $a0 , switch_3         #switch_3 
			li $v0, 4
			syscall
			
			li $v0, 5
			syscall
			sw $v0,8($gp)
			
			la $a0 , Run        
			li $v0, 4
			syscall
			
			la $a0, user        	#read character "K"
			addi $v0, $zero, 12
			syscall
			move $t0,$v0
				
			la $t3, K
			lw $s3, ($t3)
			beq $s3, $t0, L1
			li $v0, 10
			syscall
			
L1:			la $a0 , Led1        
			li $v0, 4
			syscall
			addi $t0, $zero, 1
			lw $t1,0($gp)
			beq $t0, $t1, L2
			la $a0 , Off
			syscall
			j L3
L2:			la $a0 , On
			syscall

L3:			la $a0 , Led2        
			li $v0, 4
			syscall
			lw $t1,4($gp)
			beq $t0, $t1, L4
			la $a0 , Off
			syscall
			j L5
L4:			la $a0 , On
			syscall

L5:			la $a0 , Led3        
			li $v0, 4
			syscall
			lw $t1,8($gp)
			beq $t0, $t1, L6
			la $a0 , Off
			syscall
			j L7
L6:			la $a0 , On
			syscall

L7:			and $v0, $v0, $zero
			ori $v0, $v0, 10
			syscall
				
			