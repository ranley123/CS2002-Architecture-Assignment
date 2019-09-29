	.syntax unified
	.cpu	arm7tdmi
	.eabi_attribute	6, 2
	.eabi_attribute	8, 1
	.eabi_attribute	20, 1
	.eabi_attribute	21, 1
	.eabi_attribute	23, 3
	.eabi_attribute	24, 1
	.eabi_attribute	25, 1
	.file	"itos.c"
	.text
	.globl	itos
	.align	2
	.type	itos,%function
itos:
	push	{r11, lr}
	mov	r11, sp
	sub	sp, sp, #16
	str	r0, [r11, #-4]
	mov	r1, r0
	cmp	r0, #0
	str	r1, [sp]
	bne	.LBB0_2
	b	.LBB0_1
.LBB0_1:
	mov	r0, #2
	bl	malloc
	str	r0, [sp, #8]
	mov	r1, #48
	strb	r1, [r0]
	ldr	r0, [sp, #8]
	add	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB0_3
.LBB0_2:
	ldr	r0, [r11, #-4]
	mov	r1, #0
	add	r2, sp, #4
	bl	itos_recur
	str	r0, [sp, #8]
.LBB0_3:
	ldr	r0, [sp, #4]
	mov	r1, #0
	strb	r1, [r0]
	ldr	r0, [sp, #8]
	mov	sp, r11
	pop	{r11, lr}
	bx	lr
.Ltmp0:
	.size	itos, .Ltmp0-itos

	.align	2
	.type	itos_recur,%function
itos_recur:
	push	{r4, r5, r11, lr}
	add	r11, sp, #8
	sub	sp, sp, #48
	mov	r3, r2
	mov	r12, r1
	mov	lr, r0
	str	r0, [r11, #-12]
	str	r1, [r11, #-16]
	str	r2, [r11, #-20]
	ldr	r0, [r11, #-12]
	ldr	r1, .LCPI1_0
	smull	r2, r4, r0, r1
	asr	r0, r4, #2
	add	r0, r0, r4, lsr #31
	str	r0, [r11, #-24]
	ldr	r0, [r11, #-12]
	smull	r4, r5, r0, r1
	asr	r1, r5, #2
	add	r1, r1, r5, lsr #31
	add	r1, r1, r1, lsl #2
	sub	r0, r0, r1, lsl #1
	str	r3, [sp, #16]
	str	r12, [sp, #12]
	str	lr, [sp, #8]
	str	r2, [sp, #4]
	str	r4, [sp]
	bl	labs
	str	r0, [sp, #28]
	ldr	r0, [r11, #-24]
	cmp	r0, #0
	beq	.LBB1_2
	b	.LBB1_1
.LBB1_1:
	ldr	r0, [r11, #-24]
	ldr	r1, [r11, #-16]
	add	r1, r1, #1
	ldr	r2, [r11, #-20]
	bl	itos_recur
	str	r0, [sp, #24]
	b	.LBB1_5
.LBB1_2:
	ldr	r0, [r11, #-16]
	ldr	r1, [r11, #-12]
	mov	r2, #2
	cmp	r1, #0
	movlt	r2, #3
	add	r0, r0, r2
	str	r0, [sp, #20]
	bl	malloc
	str	r0, [sp, #24]
	ldr	r1, [r11, #-20]
	str	r0, [r1]
	ldr	r0, [r11, #-12]
	cmp	r0, #0
	bge	.LBB1_4
	b	.LBB1_3
.LBB1_3:
	ldr	r0, [r11, #-20]
	ldr	r1, [r0]
	add	r2, r1, #1
	str	r2, [r0]
	mov	r0, #45
	strb	r0, [r1]
.LBB1_4:
.LBB1_5:
	ldr	r0, [sp, #28]
	add	r0, r0, #48
	ldr	r1, [r11, #-20]
	ldr	r2, [r1]
	add	r3, r2, #1
	str	r3, [r1]
	strb	r0, [r2]
	ldr	r0, [sp, #24]
	sub	sp, r11, #8
	pop	{r4, r5, r11, lr}
	bx	lr
	.align	2
.LCPI1_0:
	.long	1717986919
.Ltmp1:
	.size	itos_recur, .Ltmp1-itos_recur


	.ident	"clang version 3.4.2 (tags/RELEASE_34/dot2-final)"
