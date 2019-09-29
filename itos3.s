	.text
	.file	"itos.c"
	.globl	itos
	.p2align	4, 0x90
	.type	itos,@function
itos:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	testq	%rdi, %rdi
	je	.LBB0_1
	movq	%rsp, %rdx
	xorl	%esi, %esi
	callq	itos_recur
	movq	(%rsp), %rcx
	movb	$0, (%rcx)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB0_1:
	.cfi_def_cfa_offset 16
	movl	$2, %edi
	callq	malloc
	movb	$48, (%rax)
	movq	%rax, %rcx
	addq	$1, %rcx
	movq	%rcx, (%rsp)
	movb	$0, (%rcx)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	itos, .Lfunc_end0-itos
	.cfi_endproc

	.p2align	4, 0x90
	.type	itos_recur,@function
itos_recur:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %r14
	movabsq	$7378697629483820647, %rcx
	movq	%rdi, %rax
	imulq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	leaq	(%rdx,%rdx), %rax
	leaq	(%rax,%rax,4), %rax
	movq	%rdi, %rcx
	subq	%rax, %rcx
	movq	%rcx, %rbx
	negq	%rbx
	cmovlq	%rcx, %rbx
	leaq	9(%rdi), %rax
	cmpq	$19, %rax
	jb	.LBB1_2
	addl	$1, %esi
	movq	%rdx, %rdi
	movq	%r14, %rdx
	callq	itos_recur
	movq	(%r14), %rcx
	jmp	.LBB1_4
.LBB1_2:
	movq	%rdi, %r15
	movq	%rdi, %rax
	shrq	$63, %rax
	leal	(%rax,%rsi), %eax
	addl	$2, %eax
	movslq	%eax, %rdi
	callq	malloc
	movq	%rax, (%r14)
	movq	%rax, %rcx
	testq	%r15, %r15
	jns	.LBB1_4
	addq	$1, %rcx
	movq	%rcx, (%r14)
	movb	$45, (%rax)
.LBB1_4:
	addb	$48, %bl
	leaq	1(%rcx), %rdx
	movq	%rdx, (%r14)
	movb	%bl, (%rcx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	itos_recur, .Lfunc_end1-itos_recur
	.cfi_endproc


	.ident	"clang version 7.0.1 (Fedora 7.0.1-1.fc29)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
