.data
	userString: .space 9
.text
	main:
		# Gets the user Input
		li $v0, 8
		la $a0, userString
		li $a1, 9
		syscall
		
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
		li $v0, 11
		syscall
		
		add $t0, $t0, 1
		add $t1, $t1, 1
		
		j printChar
	# tell the system the end of main
	end:
		li $v0, 10
		syscall
