; main.asm
EXTERN ExitProcess : PROC
.data
    ;Array setup: create an array in .data large enough to hold 4 weird-sized integers.
    ;For now we'll use 5-byte values. In later phases, we'll expand on this idea.
    ;Store a value: Manually store a 5-byte value into the 3rd integer slot of the array. 
    ;Break the value into bytes and write each byte into memory using mov.
    ;Retrieve a value: Reconstruct the 5-byte value back into a register (rax) using shifts 
    ;and OR operations. Verify that the retrieved value matches the stored value.
    array BYTE 20 DUP(?)  ; Array to hold 4 weird-sized integers (5 bytes each)

.code
main PROC
    ; Store a 5-byte value into the 3rd integer slot of the array
    mov BYTE PTR [array + 10], 09Ah ; Least significant byte
    mov BYTE PTR [array + 11], 078h
    mov BYTE PTR [array + 12], 056h
    mov BYTE PTR [array + 13], 034h
    mov BYTE PTR [array + 14], 012h ; Most significant byte


    ; Retrieve the 5-byte value back into rax
    xor rax, rax            ; Clear rax
    mov al, BYTE PTR [array + 10] ; Load least significant byte
    movzx rbx, BYTE PTR [array + 11] ; Load next byte
    shl rbx, 8 ; Shift left by 8 bits (1 byte)
    or rax, rbx ; Combine
    movzx rbx, BYTE PTR [array + 12] ; Load next byte
    shl rbx, 16 ; Shift left by 16 bits (2 bytes)
    or rax, rbx ; Combine
    movzx rbx, BYTE PTR [array + 13] ; Load next byte
    shl rbx, 24 ; Shift left by 24 bits (3 bytes)
    or rax, rbx ; Combine
    movzx rbx, BYTE PTR [array + 14] ; Load most significant byte
    shl rbx, 32 ; Shift left by 32 bits (4 bytes)
    or rax, rbx ; Combine
    ; Now rax contains the reconstructed 5-byte value
 
    ; Exit the process
    invoke ExitProcess, 0
main ENDP
END main
