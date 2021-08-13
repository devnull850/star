	.global _start
	.global	main

	.data
msg:
	.ascii	"*****\n"

	.text
main:
	push	%rbp
	movq	%rsp,%rbp
	add	$0xffffffffffffffe8,%rsp
	movl	%edi,0xfffffffffffffffc(%rbp)	# argc
	movq	%rsi,0xffffffffffffffe8(%rbp)	# argv
	movq	$msg,0xfffffffffffffff0(%rbp)	# p
	xor	%ecx,%ecx
	movl	%ecx,0xfffffffffffffff8(%rbp)	# i = 0
.l0:
	movl	0xfffffffffffffff8(%rbp),%ecx
	cmp	$5,%ecx				# i < 5
	jge	.end
	inc	%ecx				# ++i
	movl	%ecx,0xfffffffffffffff8(%rbp)
	movq	0xfffffffffffffff0(%rbp),%rax	# p
	add	%rcx,%rax			# p + i
	movb	$0xa,(%rax)			# *p = '\n'
	movq	$1,%rax				# write(stdout, p, i)
	movq	$1,%rdi
	movq	0xfffffffffffffff0(%rbp),%rsi
	movl	%ecx,%edx
	inc	%edx
	syscall
	movl	0xfffffffffffffff8(%rbp),%ecx
	movq	0xfffffffffffffff0(%rbp),%rax
	add	%rcx,%rax			# p + i
	movb	$0x2a,(%rax)			# *p = '*'
	jmp	.l0
.end:
	xor	%eax,%eax
	add	$0x18,%rsp
	pop	%rbp
	ret					# return 0
_start:
	pop	%rdi
	movq	%rsp,%rsi
	call	main
	movl	%eax,%edi
	movl	$0x3c,%eax
	syscall
