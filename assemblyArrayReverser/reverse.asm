;***************************************************************************************************************************
;Program name: "Assembly Array Reverser".  Copyright (C) 2023 Kevin Tran                                                    *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;Version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;
;Author Information
;  Name: Kevin Tran
;  Email: kev.tran.2001@gmail.com
;
;Program information
;  Program name: Assembly Array Reverser
;  Programming languages: Main function in C; display function in C++; manager and array related functions in X86-64; bash file in Windows Shell
;  Date program began: 2023-Mar-22
;  Date of last update: 2023-Mar-22
;  Comments reorganized: 2023-Oct-02
;  Files in the program: main.c, display_array.cc, run.sh, manager.asm, reverse.asm, input_array.asm
;
;This file
;   File name: reverse.asm
;   Language: X86-64
;   Compile: nasm -f elf64 -l reverse.lis -o reverse.o reverse.asm
;   Link: g++ -m64 -std=c++20 -no-pie -o reverse-array.out main.o display_array.o input_array.o reverse.o manager.o
;   Purpose: This is an array module that reverses an array's contents by dumping it into another array backwards.
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;
; ===== Begin code area ================================================================================================
; Declarations
    global reverse

segment .data

segment .bss

segment .text

reverse:

;Prolog
    push rbp
    mov  rbp,rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf

push qword 0  ; remain on the boundary

mov r15, rdi ;counter, uppermost position on arrayA
mov r14, 0 ;Counter, lowermost position on arrayB
mov r12, rdx ;arrayA
mov r11, rcx ;arrayB
dec r15 ; Necessary or else displaying array B adds an unnecessary 0
beginLoop:
    cmp r15, 0
    jl endLoop

    mov rax, [r12 + 8*r15]
    mov [r11 + 8*r14], rax

    dec r15
    inc r14
    jmp beginLoop
endLoop:

pop rax ; counter push at the beginning
mov rax, r14  ; store the number of things in the array from the counter of for loop

;===== Restore original values to integer registers ===================================================================
    popf
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp

ret