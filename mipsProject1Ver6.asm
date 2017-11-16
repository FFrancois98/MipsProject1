.data
	userString: .space 11
	message: .asciiz "Invalid Hexacdecimal Character"
	newLine: .asciiz "\n"
	product: .asciiz "product"
	curDecVal: .asciiz "curDecVal"
	totDecVal: .asciiz "totDecVal"
	charMess: .asciiz "this is the char"
.text
	main:
		# Gets the user Input
		jal getUserInput
		
		# output whole string
		#li $v0, 4
		#la $a0, userString
		#syscall
		li $t7, 0
		
		la $t0, userString 			# stores the address of the first char
		li $t1, 0					# stores the length of the string
		
		
	calLength: 						# loops through the bytes in the str
		lb $t2, ($t0)
		beq $t2, '\n', calLength2
		beq $t2, '\0', calLength2
		add $t0, $t0, 1 			# moves the address register to the next char
		add $t1, $t1, 1				# increments the number of characters
		j calLength
	
	calLength2:						# signifies the end of the str
		la $t3, userString			# load the address of the front to t3
		sub $t0, $t0, 1				# stores the address of last character excluding the null
		sub $t1, $t1, 1				# set the length to value is the index began at 0
		
		move $t6, $t1
		addi $t5, $zero, 1			# initilizes the value of first power of 16
		
	miniLoop:
		beq $t6, 0, breakMiniLoop 	# calculate in the highest power of 16 for the length of the str
		mul $t5, $t5, 16
				
		sub $t6, $t6, 1
		
		j miniLoop
		
	breakMiniLoop:
		li $v0, 1 					# Print the highest power of 16 in the str length
		move $a0, $t5
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall 
		
	checkValidity:
	
		bgt $t3, $t0, end 			# the end of the str has been reached
		
		lb $t2, 0($t3)				# loads the char into t2
		
		li $v0, 11
		move $a0, $t2				# print the char
		syscall
		
		li $v0, 4
		la $a0, charMess			# print out the message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out the new line
		syscall
		
		
		bge $t2, 'a', lowerCase		# checks to see if the characters are valid
		bge $t2, 'A', upperCase	
		bge $t2, '0', digit	
		
		#add $t3, $t3, 1
	rest:
		add $t3, $t3, 1		
		j checkValidity
									# tell the system the end of main
	
	end:
		li $v0, 10
		syscall
		
	lowerCase:
		blt $t5, 1, end
		bgt $t2, 'f', invalidChar
		sub $t4, $t2, 'W'
		
		li $v0, 1
		move $a0, $t4				# Prints out the decimal value
		syscall
		
		li $v0, 4
		la $a0, curDecVal			# prints out message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out the new line
		syscall 
		
		mul $t6, $t5, $t4			# t6 stores the product of the power of 16 * decimal value 
		
		li $v0, 1
		move $a0, $t6				# prints out the product
		syscall
		
		li $v0, 4
		la $a0, product				# prints out the message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out a new line
		syscall 
		
		add $t7, $t7, $t6
		div $t5, $t5, 16
		
		li $v0, 1
		move $a0, $t7				# prints out the total decimal value
		syscall
		
		li $v0, 4
		la $a0, totDecVal			# prints out the message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out a new line
		syscall
		
		j rest
		
	upperCase:
		blt $t5, 1, end
		bgt $t2, 'F', invalidChar
		sub $t4, $t2, '7'
		
		li $v0, 1
		move $a0, $t4				# Prints out the decimal value
		syscall
		
		li $v0, 4
		la $a0, curDecVal			# prints out message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out the new line
		syscall 
		
		mulu $t6, $t5, $t4			# t6 stores the product of the power of 16 * decimal value 
		
		li $v0, 1
		move $a0, $t6				# prints out the product
		syscall
		
		li $v0, 4
		la $a0, product				# prints out the message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out a new line
		syscall 
		
		add $t7, $t7, $t6
		div $t5, $t5, 16
		
		li $v0, 1
		move $a0, $t7				# prints out the total decimal value
		syscall
		
		li $v0, 4
		la $a0, totDecVal			# prints out the message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out a new line
		syscall
		
		j rest		
		
	digit:	
		blt $t5, 1, end
		bgt $t2, '9', invalidChar
		sub $t4, $t2, '0' 			# t4 stores the decimal value of the char	
		
		li $v0, 1
		move $a0, $t4				# Prints out the decimal value
		syscall
		
		li $v0, 4
		la $a0, curDecVal			# prints out message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out the new line
		syscall 
		
		mul $t6, $t5, $t4			# t6 stores the product of the power of 16 * decimal value 
		
		li $v0, 1
		move $a0, $t6				# prints out the product
		syscall
		
		li $v0, 4
		la $a0, product				# prints out the message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out a new line
		syscall 
		
		add $t7, $t7, $t6
		div $t5, $t5, 16
		
		li $v0, 1
		move $a0, $t7				# prints out the total decimal value
		syscall
		
		li $v0, 4
		la $a0, totDecVal			# prints out the message
		syscall
		
		li $v0, 4
		la $a0, newLine				# prints out a new line
		syscall 
		
		j rest	
		
	invalidChar:
		li $v0, 4
		la $a0, message
		syscall 
		j end
		
	getUserInput:
		li $v0, 8
		la $a0, userString
		li $a1, 11
		syscall
		
		jr $ra
		
