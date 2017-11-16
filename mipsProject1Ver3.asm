.data
	userString: .space 9
	message: .asciiz "This char is invalid"
.text
	main:
		# Gets the user Input
		jal getUserInput
		
		# output whole string
		#li $v0, 4
		#la $a0, userString
		#syscall
		
		la $t0, userString
		li $t1, 0
	printChar:
		# output the char
		lb $a0, 0($t0)
		beqz $a0, end
		bge $a0, '0', digit
		bge $a0, 'A', upperCase
		bge $a0, 'a', lowerCase
	rest:
		li $v0, 11
		syscall
		
		add $t0, $t0, 1
		add $t1, $t1, 1
		
		j printChar
	# tell the system the end of main
	
	end:
		li $v0, 10
		syscall
	
	digit:
		bgt $a0, '9', invalidChar
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
