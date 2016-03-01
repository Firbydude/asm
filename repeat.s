	.section	.rodata
	.int_wformat: .string "%d\n"
	.str_wformat: .string "%s\n"
	.int_rformat: .string "%d"
	.string_const_0: .string "a="
	.comm _gp, 16, 4
	.text
	.globl main
	.type main,@function
main:	nop
	pushq %rbp
	movq %rsp, %rbp

L1: nop
	# loop body
	
	# (a > -20) and ((a < -10) or (a > 20))

	#movl -8(%rbp), %eax # Put a into %eax

	# Print "a="
	movl $.string_const_0, %ebx
	movl %ebx, %esi
	movl $0, %eax
	movl $.str_wformat, %edi
	call printf

	# Scan a
	movq $_gp, %rbx
	addq $0, %rbx
	movl $.int_rformat, %edi
	movl %ebx, %esi
	movl $0, %eax
	call scanf

	# a into %eax
	movl (%rbx), %eax

	# (a > -20) into %ecx
	cmpl $-20, %eax
	movl $0, %ecx
	movl $1, %ebx
	cmovg %ebx, %ecx

	# (a < -10) into %edx
	cmpl $-10, %eax
	movl $0, %edx
	cmovl %ebx, %edx

	# (a > 20) into %eax
	cmpl $20, %eax
	movl $0, %eax
	cmovg %ebx, %eax

	# Perform or into %eax
	orl %edx, %eax

	# Perform and into %eax
	andl %ecx, %eax

	test %eax, %eax # Set ZF to 1 if %eax == 0
	je L1			# Jump to L1 if ZF == 1

L2: nop
	# after loop

	leave
	ret
