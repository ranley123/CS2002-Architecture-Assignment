	.text
	.file	"itos.c"
	.globl	itos
	.p2align	4, 0x90
	.type	itos,@function
itos:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.LBB0_2
	movl	$2, %eax
	movl	%eax, %edi
	callq	malloc
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movb	$48, (%rax)
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	.LBB0_3
.LBB0_2:
	xorl	%esi, %esi
	leaq	-24(%rbp), %rdx
	movq	-8(%rbp), %rdi
	callq	itos_recur
	movq	%rax, -16(%rbp)
.LBB0_3:
	movq	-24(%rbp), %rax
	movb	$0, (%rax)
	movq	-16(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end0:
	.size	itos, .Lfunc_end0-itos
	.cfi_endproc

	.p2align	4, 0x90
	.type	itos_recur,@function
itos_recur: # This is the itos_recur commenting part
	.cfi_startproc
	pushq	%rbp # %rbp is the base pointer for a frame. Now we push the old base pointer onto the stack to save it for later.
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16  
	movq	%rsp, %rbp # copy the address of %rsp to %rbp, indicating the base of the function.
    # When %rsp has been changed (i.e. pushing values or local variables on to the stack).
    # local variables and parameters can still be accessed via a constant offset from %rbp.
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp # The stack grows downwards, reserving 64 bytes from the base of the current stack frame.
	movl	$10, %eax # movl represents that the operand will be a doubleword (32 bits); %eax is the lower 32 bits of %rax
    # This instruction is for long quot = val / 10; 
	movl	%eax, %ecx # store the divisor 10, and save it for division later.
	movq	%rdi, -8(%rbp) # store the first argument: long val into this address
	movl	%esi, -12(%rbp) # store the second argument: int depth into this address
	movq	%rdx, -24(%rbp) # store the third argument: char** end into this address
	movq	-8(%rbp), %rax # load the dividend val into %rax
	cqto # convert quadword in %rax to octoword in %rdx (sign-extend), and %rdx holds the upper 64 bits from the dividend which must not contain a random value, while zero-extend is wrong. 
    # By using cqto, the sign extension replaces zero extension.
	# val / 10;
	idivq	%rcx # put the divisor into %rcx. The quotient is put into %rax and the remainder is put into %rdx
	# long quot = val / 10;
	movq	%rax, -32(%rbp) # store long quot, the quotient into -32
	movq	-8(%rbp), %rax # load the dividend val into %rax
	cqto # convert again, for the second division
	# (val % 10)
	idivq	%rcx # do the division again to get the remainder in %rdx
	movq	%rdx, %rdi # store the remainder from %rax to %rdi for the next call
	# labs(val % 10)
	callq	labs # to obtain the absolute value of the argument in %rdi
	movq	%rax, -40(%rbp) # store the absolute mod in this address
	cmpq	$0, -32(%rbp) # (if(quot != 0)) this is to compare 0 and the quotient
	je	.LBB1_2 # if they are equal, go to .LBB1_2
	movq	-32(%rbp), %rdi # preparation to call: copy the quotient to the first argument register %rdi
	movl	-12(%rbp), %eax # load the depth into %eax
	addl	$1, %eax # depth + 1
	movq	-24(%rbp), %rdx # preparation to call: load the end pointer into %rdx (the third argument register)
	movl	%eax, %esi # preparation to call: copy the depth from %eax to the second argument register %esi 
    # itos_recur(quot, depth + 1, end)
	callq	itos_recur # By using three argument registers above, recursively call itself again.
	movq	%rax, -48(%rbp) # the return value from the subroutine is stored into this address.
	jmp	.LBB1_5 # an unconditional branch to the next statement label .LBB1_5
.LBB1_2: # this is the else part
	movl	$2, %eax # preparation for comparision: store 2 into register %eax
	movl	$3, %ecx # preparation for comparision: store 3 into register %ecx
	movl	-12(%rbp), %edx # load depth into %edx
	movq	-8(%rbp), %rsi # load long val into %rsi
	# (val < 0?)
	cmpq	$0, %rsi # compare 0 and val to see if 0 is greater than val
	cmovll	%ecx, %eax # movll is cmovl (if is less than, copy 2 from %eax to %ecx).
	addl	%eax, %edx # int len = depth + 3/2 in %eax 
	movl	%edx, -52(%rbp) # store the result (int len) into -52(%rbp) with a integer type defined.
	movslq	-52(%rbp), %rdi # load the result (int len) into %rdi as an argument for the next callee function.
	# movslq here is to do a transfer from 32 to 64 bits by using sign entenstion.
	callq	malloc # malloc(len);
	movq	%rax, -48(%rbp) # store the return value (address) of %rax into -48(%rbp)
	movq	-48(%rbp), %rax # retreive the return value and copy it into return argument register %rax
	movq	-24(%rbp), %rsi # load the third argument (actually is an address value) char **end into %rsi
	movq	%rax, (%rsi) # By derefencing the address stored in %rsi, find the corresponding address.
	# and then copy the returned value from %rax to that address. (*/end = &start[0];)
	cmpq	$0, -8(%rbp) # compare 0 and val to see if 0 is greater than val
	jge	.LBB1_4 # if 0 is greater or equal than, then jump to label .LBB1_4
	movq	-24(%rbp), %rax # load the char**end (address of *end) into %rax
	movq	(%rax), %rcx # (*end): load *end (address of the first char in start)into %rcx
	movq	%rcx, %rdx # load *end from %rcx to %rdx
	addq	$1, %rdx # (*end)++
	movq	%rdx, (%rax) # store the incremented value indirectly
	movb	$45, (%rcx) # 45 represents '-' in ASCII, so the first char of start becomes '-':*(*end)++ = '-' 
.LBB1_4:
	jmp	.LBB1_5 # branch to .LBB1_5, the return part
.LBB1_5:
	movq	-40(%rbp), %rax # load long mod into %rax
	addq	$48, %rax # doing '0' + mod: since 48 represents '0' in ASCII
	# this uses long mod as an offset against '0' in ASCII to locate the corresponding char by a numerical index
	movb	%al, %cl # %al, %cl represents the least significant 8 bits of %rax, %rcx respectively
	# this means copy the value mod of %rax to %rcx in a simple way, for efficiency.
	movq	-24(%rbp), %rax # load the char**end (address of *end) into %rax
	movq	(%rax), %rdx # (*end): load *end (address of the first char in start)into %rdx
	movq	%rdx, %rsi # load *end from %rdx to %rsi
	addq	$1, %rsi # for the increment operator ++: in this instruction, the pointer end points to the next char of start
	movq	%rsi, (%rax) # store the incremented value indirectly
	movb	%cl, (%rdx) # %cl now represets a char in ASCII. The current char pointed by end now is changed to be the char of the current position.
	movq	-48(%rbp), %rax # load start into return register
	addq	$64, %rsp # clear the current stack frame and %rsp will return to the previous position
	popq	%rbp # retrieve the address value of the previous %rbp and pop 
	retq # terminates function with value in %rax returned 
.Lfunc_end1:
	.size	itos_recur, .Lfunc_end1-itos_recur
	.cfi_endproc


	.ident	"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"
	.section	".note.GNU-stack","",@progbits