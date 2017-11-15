.data
	userString: .space 9
.text
	main:
		# Gets the user Input
		li $v0, 8
		la $a0, userString
		li $a1, 9
		syscall
		
		# Display the user Input for testing
		li $v0, 4
		la $a0, userString
		syscall
		
	# tell the system the end of main
	li $v0, 10
	syscall
