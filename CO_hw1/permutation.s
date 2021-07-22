# Class: 109暑 計算機組織 蔡文錦
# Author: 陳品劭 109550206
# Date: 20210716
.data
msg1:	.asciiz "Please input integer n: "
msg2:	.asciiz "Please input integer k: "
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
  		move    $s0, $v0      		# store input in $s0 (set arugument of procedure prime)

# print msg1 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg2		# load address of string into $a0
		syscall                 	# run the syscall
		
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $s1, $v0      		# store input in $s1 (set arugument of procedure prime)

#permutation procedure
		addi	$t0, $zero, 0		#$t0 = i = 0
		addi	$s2, $zero, 1		#$s2 = temp = 1
		
permutation:	slt	$t1, $t0, $s1		#if i >= k
		beq	$t1, $zero, L		#branch to L
		sub	$t2, $s0, $t0		#$t2 = n - i
		mul	$s2, $s2, $t2		#sum *= $t2
		addi	$t0, $t0, 1		#i++
		j 	permutation		#loop

# print the result of procedure prime on the console interfac
		
L:		li 	$v0, 4			# call system call: print string
		la 	$a0, msg3		# load address of string into $a0
		syscall                 	# run the syscall
		
		move 	$a0, $s2			
		li 	$v0, 1			# call system call: print integer
		syscall 			# run the syscall

		li 	$v0, 10			# call system call: exit
  		syscall				# run the syscall
