	.text
	.file	"itos-stack.c"
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
	movq	-8(%rbp), %rdi
	leaq	-24(%rbp), %rdx
	callq	itos_recur
	movq	%rax, -16(%rbp)
.LBB0_3:
	movq	-24(%rbp), %rax
	movb	$0, (%rax)
	movq	-16(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	itos, .Lfunc_end0-itos
	.cfi_endproc

	.p2align	4, 0x90
	.type	itos_recur,@function
itos_recur:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	$10, %eax
	movl	%eax, %ecx
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	cqto
	idivq	%rcx
	movq	%rax, -32(%rbp)
	movq	-8(%rbp), %rax
	cqto
	idivq	%rcx
	movq	%rdx, %rdi
	callq	labs
	movq	%rax, -40(%rbp)
	cmpq	$0, -32(%rbp)
	je	.LBB1_2
	movq	-32(%rbp), %rdi
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movq	-24(%rbp), %rdx
	movl	%eax, %esi
	callq	itos_recur
	movq	%rax, -48(%rbp)
	jmp	.LBB1_5
.LBB1_2:
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpq	$0, %rcx
	movl	$3, %edx
	movl	$2, %esi
	cmovll	%edx, %esi
	addl	%esi, %eax
	movl	%eax, -52(%rbp)
	movslq	-52(%rbp), %rdi
	callq	malloc
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	%rax, (%rcx)
	cmpq	$0, -8(%rbp)
	jge	.LBB1_4
	movq	-24(%rbp), %rax
	movq	(%rax), %rcx
	movq	%rcx, %rdx
	addq	$1, %rdx
	movq	%rdx, (%rax)
	movb	$45, (%rcx)
.LBB1_4:
	movb	$0, %al
	callq	print_stack
.LBB1_5:
	movq	-40(%rbp), %rax
	addq	$48, %rax
	movb	%al, %cl
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movq	%rdx, %rsi
	addq	$1, %rsi
	movq	%rsi, (%rax)
	movb	%cl, (%rdx)
	movq	-48(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	itos_recur, .Lfunc_end1-itos_recur
	.cfi_endproc


	.ident	"clang version 7.0.1 (Fedora 7.0.1-1.fc29)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym itos
	.addrsig_sym malloc
	.addrsig_sym itos_recur
	.addrsig_sym labs
	.addrsig_sym print_stack
