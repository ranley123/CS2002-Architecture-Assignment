	.abicalls
	.option	pic0
	.section .mdebug.abi32
	.previous
	.file	"itos.c"
	.text
	.globl	itos
	.align	2
	.type	itos,@function
	.set	nomips16
	.ent	itos
itos:
	.frame	$fp,48,$ra
	.mask 	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	.set	noat
	addiu	$sp, $sp, -48
	sw	$ra, 44($sp)
	sw	$fp, 40($sp)
	move	 $fp, $sp
	sw	$4, 36($fp)
	move	 $1, $4
	sw	$1, 24($fp)
	bnez	$4, $BB0_3
	nop
	j	$BB0_2
	nop
$BB0_2:
	addiu	$4, $zero, 2
	jal	malloc
	nop
	sw	$2, 32($fp)
	addiu	$4, $zero, 48
	sb	$4, 0($2)
	lw	$2, 32($fp)
	addiu	$2, $2, 1
	sw	$2, 28($fp)
	j	$BB0_4
	nop
$BB0_3:
	lw	$4, 36($fp)
	addiu	$5, $zero, 0
	addiu	$6, $fp, 28
	jal	itos_recur
	nop
	sw	$2, 32($fp)
$BB0_4:
	lw	$1, 28($fp)
	addiu	$2, $zero, 0
	sb	$zero, 0($1)
	lw	$1, 32($fp)
	sw	$2, 20($fp)
	move	 $2, $1
	move	 $sp, $fp
	lw	$fp, 40($sp)
	lw	$ra, 44($sp)
	addiu	$sp, $sp, 48
	jr	$ra
	nop
	.set	at
	.set	macro
	.set	reorder
	.end	itos
$tmp3:
	.size	itos, ($tmp3)-itos

	.align	2
	.type	itos_recur,@function
	.set	nomips16
	.ent	itos_recur
itos_recur:
	.frame	$fp,80,$ra
	.mask 	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	.set	noat
	addiu	$sp, $sp, -80
	sw	$ra, 76($sp)
	sw	$fp, 72($sp)
	move	 $fp, $sp
	sw	$4, 68($fp)
	sw	$5, 64($fp)
	sw	$6, 60($fp)
	lui	$1, 26214
	ori	$1, $1, 26215
	lw	$2, 68($fp)
	mult	$2, $1
	mfhi	$2
	srl	$3, $2, 31
	sra	$2, $2, 2
	addu	$2, $2, $3
	sw	$2, 56($fp)
	lw	$2, 68($fp)
	mult	$2, $1
	mfhi	$1
	srl	$3, $1, 31
	sra	$1, $1, 2
	addu	$1, $1, $3
	sll	$3, $1, 1
	sll	$1, $1, 3
	addu	$1, $1, $3
	subu	$1, $2, $1
	sw	$4, 40($fp)
	move	 $4, $1
	sw	$6, 36($fp)
	sw	$5, 32($fp)
	jal	labs
	nop
	lw	$1, 36($fp)
	lw	$3, 32($fp)
	lw	$4, 40($fp)
	sw	$2, 52($fp)
	lw	$2, 56($fp)
	sw	$1, 28($fp)
	sw	$4, 24($fp)
	sw	$3, 20($fp)
	beqz	$2, $BB1_3
	nop
	j	$BB1_2
	nop
$BB1_2:
	lw	$6, 60($fp)
	lw	$4, 56($fp)
	lw	$1, 64($fp)
	addiu	$5, $1, 1
	jal	itos_recur
	nop
	sw	$2, 48($fp)
	j	$BB1_7
	nop
$BB1_3:
	lw	$1, 68($fp)
	slti	$1, $1, 0
	addiu	$2, $zero, 2
	addiu	$3, $zero, 3
	movn	$2, $3, $1
	lw	$1, 64($fp)
	addu	$1, $1, $2
	sw	$1, 44($fp)
	move	 $4, $1
	jal	malloc
	nop
	sw	$2, 48($fp)
	lw	$1, 60($fp)
	sw	$2, 0($1)
	lw	$1, 68($fp)
	bgez	$1, $BB1_6
	nop
	j	$BB1_5
	nop
$BB1_5:
	lw	$1, 60($fp)
	lw	$2, 0($1)
	addiu	$3, $2, 1
	addiu	$4, $zero, 45
	sw	$3, 0($1)
	sb	$4, 0($2)
$BB1_6:
$BB1_7:
	lw	$1, 60($fp)
	lw	$2, 0($1)
	addiu	$3, $2, 1
	lw	$4, 52($fp)
	sw	$3, 0($1)
	addiu	$1, $4, 48
	sb	$1, 0($2)
	lw	$2, 48($fp)
	move	 $sp, $fp
	lw	$fp, 72($sp)
	lw	$ra, 76($sp)
	addiu	$sp, $sp, 80
	jr	$ra
	nop
	.set	at
	.set	macro
	.set	reorder
	.end	itos_recur
$tmp7:
	.size	itos_recur, ($tmp7)-itos_recur


	.ident	"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"
