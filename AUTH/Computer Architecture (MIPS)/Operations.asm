			.data 
			.align 2
array_a:	.space 36
			.align 2
array_b:	.space 36
			.align 3
array_d:	.space 72
a:		.asciiz "a("
beta:		.asciiz "b("
d:		.asciiz "d("
comma:		.asciiz ","
paren:		.asciiz ")="
enter:		.asciiz "\n"
tab:		.asciiz "\t"

		.text

main:		
			li $s0,3		#matrix a
			li $t2,0
			li $t0,0
L2:			li $t1,0
L1:					
			li $v0,4
			la $a0,a
			syscall
			
			andi $a0,$zero,0
			add $a0, $t2, $zero
			li $v0, 1
			syscall
			
			li $v0,4
			la $a0,comma
			syscall
			
			andi $a0,$zero,0
			add $a0, $t1, $zero
			li $v0, 1
			syscall
			
			li $v0,4
			la $a0,paren
			syscall
							
			li $v0,6
			syscall
			
			la $a0, array_a
			addu $a0,$t0,$a0
			s.s $f0,0($a0)
			addi $t0,$t0,4
			addi $t1,$t1,1
			blt $t1,$s0,L1
			addi $t2,$t2,1
			blt $t2,$s0,L2
													
			li $s0,3		#matrix b
			li $t2,0
			li $t0,0
L4:			li $t1,0
L3:			
							
			li $v0,4
			la $a0,beta
			syscall
			
			andi $a0,$zero,0
			add $a0, $t2, $zero
			li $v0, 1
			syscall
			
			li $v0,4
			la $a0,comma
			syscall
			
			andi $a0,$zero,0
			add $a0, $t1, $zero
			li $v0, 1
			syscall
			
			li $v0,4
			la $a0,paren
			syscall
							
			li $v0,6
			syscall
			
			la $a1, array_b
			addu $a1,$a1,$t0
			s.s $f0,0($a1)
			addi $t0,$t0,4
			addi $t1,$t1,1
			blt $t1,$s0,L3
			addi $t2,$t2,1
			blt $t2,$s0,L4
									#multiplication 
			la $a0, array_a
			la $a1, array_b
			la $a2, array_d	
				
			li $t1, 3               # $t1=3
			li $s0, 0               # i=0		
L5:     		li $s1, 0               # j=0
L6:     		li $s2, 0               # k=0
			mul $t2, $s0, 3         # $t2=i*3
			addu $t2, $t2, $s1      # $t2=$t2+j
			sll $t2, $t2, 3         # $t2=offset byte from [i][j]
			addu $t2, $a2, $t2      # $t2=adress byte of d[i][j]
			l.d $f4, 0($t2)         # $f4=8 byte of d[i][j]
			
L7:     		mul $t0, $s2, 3         # $t0=k*3
			addu $t0, $t0, $s1      # $t0=$t0+j
			sll $t0, $t0, 2         # $t0=adress offset of [k][j]
			addu $t0, $a1, $t0      # $t0=adress byte of b[k][j]
			l.s $f16, 0($t0)        # $f16=4 byte of b[k][j]
			
			mul $t0, $s0, 3         # $t0=i*3
			addu $t0, $t0, $s2      # $t0=$t0+k
			sll $t0, $t0, 2         # $t0=adress offset of [i][k]
			addu $t0, $a0, $t0      # $t0=adress byte of a[i][k]
			l.s $f18, 0($t0)        # $f16=4 byte of a[i][k]
			
			mul.s $f16, $f18, $f16  # $f16=a[i][k]*b[k][j]
			cvt.d.s $f10, $f16
			add.d $f4, $f4, $f10    # $f4=d[i][j]+a[i][k]*b[k][j]
			
			addiu $s2, $s2, 1       # k=k+1
			bne $s2, $t1, L7        # if (k!=3) goto L7
			s.d $f4, 0($t2)         # d[i][j]=$f4
			
			addiu $s1, $s1, 1       # j=j+1
			bne $s1, $t1, L6        # if (j!=3) goto L6
			addiu $s0, $s0, 1       # i=i+1
			bne $s0, $t1, L5        # if (i!=3) goto L5											
								
								#matrix d		
			li $s0,3
			li $s1,2
			li $t2,0
			li $t0,0
L9:			li $t1,0
L8:					
			li $v0,4
			la $a0, d
			syscall
			
			andi $a0,$zero,0
			add $a0, $t2, $zero
			li $v0, 1
			syscall
			
			li $v0,4
			la $a0,comma
			syscall
			
			andi $a0,$zero,0
			add $a0, $t1, $zero
			li $v0, 1
			syscall
			
			li $v0,4
			la $a0,paren
			syscall
			
			li $v0, 3	
			la $a0, array_d
			addu $a0,$a0,$t0
			l.d $f12, 0($a0)
			syscall
			
			bne $t1,$s1,L10
			
			li $v0,4
			la $a0,enter
			syscall
			beq $t1,$s1,L11
			
L10:		li $v0,4
			la $a0,tab
			syscall
			
L11:		addi $t0,$t0,8
			addi $t1,$t1,1
			blt $t1,$s0,L8
			addi $t2,$t2,1
			blt $t2,$s0,L9
			
			li $v0, 10              
			syscall
