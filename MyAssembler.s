	.file	"MainProblem.c"
	.intel_syntax noprefix
	.text
	
	.globl	read_str
	.type	read_str, @function
read_str:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi # переменная str
	mov	DWORD PTR -8[rbp], 0 # переменная i
.L2:
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	fgetc@PLT 
	mov	DWORD PTR -4[rbp], eax # переменная ch
	mov	eax, DWORD PTR -8[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -8[rbp], edx
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -4[rbp]
	mov	BYTE PTR [rax], dl
	cmp	edx, -1 # Было DWORD PTR -4[rbp]
	jne	.L2
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	nop
	leave
	ret
	.size	read_str, .-read_str
	
	.globl	is_letter
	.type	is_letter, @function
is_letter:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	eax, edi
	mov	BYTE PTR -4[rbp], al # переменная c
	cmp	al, 96 # Было BYTE PTR -4[rbp]
	jle	.L4
	cmp	al, 122 # Было BYTE PTR -4[rbp]
	jle	.L5
.L4:
	cmp	al, 64 # Было BYTE PTR -4[rbp]
	jle	.L6
	cmp	al, 90 # Было BYTE PTR -4[rbp]
	jg	.L6
.L5:
	mov	eax, 1 # Кладём true
	jmp	.L7
.L6:
	mov	eax, 0 # Кладём false
.L7:
	and	eax, 1 # Кладём true
	pop	rbp
	ret
	.size	is_letter, .-is_letter
	
	.globl	make_reverse_str
	.type	make_reverse_str, @function
make_reverse_str:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi # переменная str
	mov	DWORD PTR -28[rbp], esi # переменная left
	mov	DWORD PTR -32[rbp], edx # переменная right
	mov	eax, DWORD PTR -28[rbp] 
	mov	DWORD PTR -4[rbp], eax # eax - переменная i
	jmp	.L10
.L11:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -5[rbp], al # переменная tmp
	mov	edx, DWORD PTR -32[rbp]
	mov	eax, DWORD PTR -28[rbp]
	add	eax, edx
	sub	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -4[rbp]
	movsx	rcx, edx
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	mov	edx, DWORD PTR -32[rbp]
	mov	eax, DWORD PTR -28[rbp]
	add	eax, edx
	sub	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, -1[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -5[rbp]
	mov	BYTE PTR [rdx], al
	add	DWORD PTR -4[rbp], 1
.L10:
	mov	edx, DWORD PTR -28[rbp]
	mov	eax, DWORD PTR -32[rbp]
	add	eax, edx
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	cmp	DWORD PTR -4[rbp], eax
	jl	.L11
	nop
	nop
	pop	rbp
	ret
	.size	make_reverse_str, .-make_reverse_str
	
	.globl	make_reverse_words
	.type	make_reverse_words, @function
make_reverse_words:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	QWORD PTR -40[rbp], rdi # переменная str
	mov	DWORD PTR -16[rbp], 0 # переменная len
	jmp	.L13
.L14:
	add	DWORD PTR -16[rbp], 1
.L13:
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L14
	mov	edx, DWORD PTR -16[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	esi, 0
	mov	rdi, rax
	call	make_reverse_str
	mov	DWORD PTR -12[rbp], 0 # переменная start_word
	mov	DWORD PTR -8[rbp], 0 # переменная end_word
	mov	BYTE PTR -17[rbp], 0 # переменная is_word
	mov	DWORD PTR -4[rbp], 0 # переменная i
	jmp	.L15
.L19:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	is_letter
	test	al, al
	je	.L16
	movzx	eax, BYTE PTR -17[rbp]
	xor	eax, 1
	test	al, al
	je	.L17
	mov	eax, DWORD PTR -4[rbp]
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -4[rbp]
	mov	DWORD PTR -8[rbp], eax
	mov	BYTE PTR -17[rbp], 1
.L17:
	add	DWORD PTR -8[rbp], 1
	jmp	.L18
.L16:
	cmp	BYTE PTR -17[rbp], 0
	je	.L18
	mov	edx, DWORD PTR -8[rbp]
	mov	ecx, DWORD PTR -12[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	make_reverse_str
	mov	BYTE PTR -17[rbp], 0
.L18:
	add	DWORD PTR -4[rbp], 1
.L15:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -16[rbp]
	jl	.L19
	cmp	BYTE PTR -17[rbp], 0
	je	.L21
	mov	edx, DWORD PTR -8[rbp]
	mov	ecx, DWORD PTR -12[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	make_reverse_str
.L21:
	nop
	leave
	ret
	.size	make_reverse_words, .-make_reverse_words

	.section	.rodata
	.align 8
.LC0:
	.string	"\320\222\320\262\320\265\320\264\320\270 \321\201\321\202\321\200\320\276\320\272\321\203 (\320\267\320\260\320\272\320\276\320\275\321\207\320\270\320\262 \320\275\320\260\320\266\320\274\320\270\321\202\320\265 Ctrl + D):"
	.align 8
.LC1:
	.string	"\n\320\222\320\276\321\202 \320\262\320\260\321\210\320\260 \321\201\321\202\321\200\320\276\320\272\320\260:"
	.align 8
.LC2:
	.string	"\320\222\320\276\321\202 \321\200\320\260\320\267\320\262\321\221\321\200\320\275\321\203\321\202\320\260\321\217 \321\201\321\202\321\200\320\276\320\272\320\260:"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 40
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -24[rbp], rax # переменная str
	xor	eax, eax
	mov	rax, rsp
	mov	rbx, rax
	mov	DWORD PTR -44[rbp], 1000 # переменная cap
	mov	eax, DWORD PTR -44[rbp]
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -40[rbp], rdx
	movsx	rdx, eax
	mov	r8, rdx
	mov	r9d, 0
	movsx	rdx, eax
	mov	rsi, rdx
	mov	edi, 0
	cdqe
	mov	edx, 16
	sub	rdx, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L23:
	cmp	rsp, rdx
	je	.L24
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L23
.L24:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L25
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L25:
	mov	rax, rsp
	add	rax, 0
	mov	QWORD PTR -32[rbp], rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	read_str
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	make_reverse_words
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	mov	rsp, rbx
	mov	rdx, QWORD PTR -24[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L27
	call	__stack_chk_fail@PLT
.L27:
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	main, .-main
