	.section	.rodata
	.int_wformat: .string "%d\n"
	.str_wformat: .string "%s\n"
	.int_rformat: .string "%d"
	.string_const_0: .string "a="
	.comm _gp, 16, 4
	.text
	.globl main
	.type main,@function
	.T:	.quad .L1, .DEF, .L2, .L3, .DEF, .L4
main:	nop
	pushq %rbp
	movq %rsp, %rbp

	#movl -4(%rbp), %eax # Put a into %eax

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

	# If a < 200 jump to default
	cmpl $200, %eax
	jl .DEF

	# If a > 205 jump to default
	cmpl $205, %eax
	jg .DEF

	movq $.T, %rbx
	subl $200, %eax
	movl $8, %ecx
	imull %ecx, %eax
	movslq %eax, %rax
	addq %rax, %rbx
	movq (%rbx), %rax
	jmp *%rax

.L1: # 200
	nop # call foo1()
.L2: # 202
	nop     # call foo2()
	jmp .L5 # break
.L3: # 203
.L4: # 205
	nop     # call foo3()
	jmp .L5 # break;
.DEF: # default
	nop # call foo4()
.L5: # end of cases

	leave
	ret
