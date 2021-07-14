.data
msg1:	.asciiz "Please enter integer x: "
msg2:	.asciiz "Please enter integer y: "
msg3:	.asciiz "The result is: "
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
  		move    $a1, $v0      		# store input in $a1 (set arugument of procedure gcd)
# print msg1 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg2		# load address of string into $a0
		syscall                 	# run the syscall
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a2, $v0      		# store input in $a2 (set arugument of procedure gcd)

# jump to procedure gcd
  		jal 	gcd
		move 	$t0, $v0		# save return value in t0 (because v0 will be used by system call) 

# print the result of procedure gcd on the console interfac
		li      $v0, 4			# call system call: print string
		la      $a0, msg3		# load address of string into $a0
		syscall                 	# run the syscall
# print the result of procedure gcd on the console interface		
		move 	$a0, $t0			
		li 	$v0, 1			# call system call: print integer
		syscall 			# run the syscall
		
		li 	$v0, 10			# call system call: exit
  		syscall				# run the syscall

#------------------------- procedure gcd -----------------------------
# load argument n in a1, a2, return value in v0. 
.text
gcd:		addi 	$sp, $sp, -12		# adiust stack for 2 items
		sw 	$ra, 8($sp)		# save the return address
		sw 	$a1, 4($sp)		# save the argument x
		sw 	$a2, 0($sp)		# save the argument y
		
		beq 	$a2, $zero, returnA	#if (b == 0) return a;
		div 	$a1, $a2		#a % b
		move 	$a1, $a2		#a = b
		mfhi	$a2			#b = a % b
		jal 	gcd			# call gcd with (b, a % b)	
		lw 	$a2, 0($sp)
		lw 	$a1, 4($sp)
		lw 	$ra, 8($sp)		# restore the return address
		addi 	$sp, $sp, 12		# adjust stack pointer to pop 2 items
		jr 	$ra			# return to the caller
		
returnA:		add 	$v0, $zero, $a1		# return 0
		addi 	$sp, $sp, 12		# pop 2 items off stack
		jr 	$ra			# return to caller	
