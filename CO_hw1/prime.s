.data
msg1:	.asciiz "Please input a number(>=1): "
msg2:	.asciiz "It's a prime\n"
msg3:	.asciiz "It's not a prime\n"
.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg1		# load address of string into $a0
		syscall                 	# run the syscall
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a0, $v0      		# store input in $a0 (set arugument of procedure prime)

# jump to procedure prime
  		jal prime
		move $t0, $v0			# save return value in t0 (because v0 will be used by system call) 

# print the result of procedure prime on the console interfac
		
		bne $t0, $zero, L		#if $t0 == 0 means not prime
		
		li      $v0, 4			# call system call: print string
		la      $a0, msg3		# load address of string into $a0
		syscall                 	# run the syscall
		j exit				
		
L:		li      $v0, 4			# call system call: print string
		la      $a0, msg2		# load address of string into $a0
		syscall                 	# run the syscall
		
exit:   
		li $v0, 10			# call system call: exit
  		syscall				# run the syscall

#------------------------- procedure prime -----------------------------
# load argument n in a0, return value in v0. 
.text
prime:		addi $sp, $sp, -8		# adiust stack for 2 items
		sw $ra, 4($sp)			# save the return address
		sw $a0, 0($sp)			# save the argument n
		
		addi $t0, $zero, 1		# $t0 = 1
		beq $v0, $t0, return0		# if n == 1 go to return 0
		
		addi $t1, $zero, 2		# $t1 = i = 2
L1:		mul $t0, $t1, $t1		# $t0 = i * i
		slt $t2, $a0, $t0 		# if(i * i > n) 
		bne $t2, $zero, return1		#branch to return 1
		#
		div $a0, $t1			#a0 / t1 = x...y
		mfhi $t3			#get y
		beq $t3, $zero, return0		#if(n%i == 0) return 0;
		#
		addi $t1, $t1, 1		# i++
		j L1
		
return0:		addi $v0, $zero, 0		# return 0
		addi $sp, $sp, 8		# pop 2 items off stack
		jr $ra				# return to caller
return1:		addi $v0, $zero, 1		# return 1
		addi $sp, $sp, 8		# pop 2 items off stack
		jr $ra				# return to caller