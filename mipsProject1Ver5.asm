.data
	userString: .space 9
	message: .asciiz "Invalid Hexacdecimal Character"
.text
	main:
		# Gets the user Input
		jal getUserInput
		
		# output whole string
		#li $v0, 4
		#la $a0, userString
		#syscall
		
		la $t0, userString # stores the address of the first char
		li $t1, 0			# stores the length of the string
		
		
	calLength: 			# loops through the bytes in the str
		lb $t2, ($t0)
		beq $t2, '\n', calLength2
		beq $t2, '\0', calLength2
		add $t0, $t0, 1 	# moves the address register to the next char
		add $t1, $t1, 1		# increments the number of characters
		j calLength
	
	calLength2:			# signifies the end of the str
		la $t3, userString		# load the address of the front to t3
		sub $t0, $t0, 1			# stores the address of last character excluding the null
		sub $t1, $t1, 1			# set the length to value is the index began at 0
		
		move $t6, $t1
		addi $t5, $zero, 1	# initilizes the value of first power of 16
	miniLoop:
		beq $t6, 0, breakMiniLoop # calculate in the highest power of 16 for the length of the str
		mul $t5, $t5, 16
				
		sub $t6, $t6, 1
		
		j miniLoop
		
	breakMiniLoop:
		li $v0, 1 			# Print the highest power of 16 in the str length
		move $a0, $t5
		syscall
		j end
		
	checkValidity:
	
		bgt $t3, $t0, end 		# the end of the str has been reached
		
		lb $t2, ($t3)			# loads the char into t2
		bge $t2, '0', digit		# checks to see if the characters are valid
		bge $t2, 'A', upperCase	
		bge $t2, 'a', lowerCase	
	rest:
				
		j checkValidity
	# tell the system the end of main
	
	end:
		li $v0, 10
		syscall
	
	digit:
		bgt $a0, '9', invalidChar
		sub $t4, $t2, '0' 		# t4 stores the decimal value of the char		
		j rest
		
	upperCase:
		bgt $a0, 'F', invalidChar
		j rest
		
	lowerCase:
		bgt $a0, 'f', invalidChar
		j rest
		
	invalidChar:
		li $v0, 4
		la $a0, message
		syscall 
		j end
		
	getUserInput:
		li $v0, 8
		la $a0, userString
		li $a1, 9
		syscall
		
		jr $ra
