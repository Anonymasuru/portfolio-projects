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
;   File name: manager.asm
;   Language: X86-64
;   Compile: nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Link: g++ -m64 -std=c++20 -no-pie -o reverse-array.out main.o display_array.o input_array.o reverse.o manager.o
;   Purpose: This is the central manager for the Array Reverser.
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;
; ===== Begin code area ================================================================================================
; Declarations
    extern printf
    extern scanf
    extern fgets
    extern stdin
    extern strlen

    extern input_array
    extern display_array
    extern reverse

    max equ 10
    LARGE_BOUNDARY equ 64
    SMALL_BOUNDARY equ 16
    INPUT_LEN equ 256

    global manager

segment .data
    align SMALL_BOUNDARY
        format db "%s", 0
        prompt_name db "Please enter your name: ",0
        prompt_title db "What is your title: ",0
        welcome db "Welcome ",0
        spc db " ", 0
        exit_spc db "", 10, 10, 0
    align LARGE_BOUNDARY
    introduce db "This is our reversible program.",10,10,0
    welcome_control db "This is our reversible program.",10,10,0
    inform_reverse db "The function reverse was called",10,10,0
    present_numbers_A db "You entered",10,0
    present_numbers_B db "The second array holds these values",10,0
    enter_prompt db "Please enter up to 10 floating point numbers separated by ws and press <enter><control+d> to terminate inputs.", 10, 0

segment .bss
    name resb INPUT_LEN
    title resb INPUT_LEN
    arrayA resq max
    arrayB resq max

segment .text

manager:

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

;======Fgets======;
; Print name prompt
    push qword 0
    mov rax, 0
    mov rdi, prompt_name
    call printf
    pop rax

; Fgets: Grab name of individual
    mov rax, 0
    mov rdi, name 
    mov rsi, INPUT_LEN 
    mov rdx, [stdin] 
    call fgets 

    mov rax, 0 
    mov rdi, name
    call strlen 
    sub rax, 1 
    mov byte [name + rax], 0 

; Print title prompt
    push qword 0
    mov rax, 0
    mov rdi, prompt_title
    call printf
    pop rax

; Fgets: Grab title of individual
    mov rax, 0 
    mov rdi, title 
    mov rsi, INPUT_LEN 
    mov rdx, [stdin] 
    call fgets 

    mov rax, 0 
    mov rdi, title 
    call strlen 
    sub rax, 1 
    mov byte [title + rax], 0 

; Print welcome
    push qword 0
    mov rax, 0 
    mov rdi, format 
    mov rsi, welcome 
    call printf 
    pop rax

; Print title
    push qword 0
    mov rax, 0 
    mov rdi, format 
    mov rsi, title
    call printf 
    pop rax

; Print space
    push qword 0
    mov rax, 0 
    mov rdi, format 
    mov rsi, spc 
    call printf 
    pop rax

; Print name
    push qword 0
    mov rax, 0 
    mov rdi, format 
    mov rsi, name 
    call printf 
    pop rax

; Print exitspace
    push qword 0
    mov rax, 0 
    mov rdi, format 
    mov rsi, exit_spc 
    call printf 
    pop rax

; Print introduction
    push qword 0
    mov rax, 0
    mov rdi, introduce
    call printf
    pop rax

;Prompt
  push qword 0
  mov rax, 0
  mov rdi, enter_prompt
  call printf
  pop rax

;======Array A======;

;Fill the array using the input_array module
    push qword 0
    mov rax, 0
    mov rdi, arrayA ; array passed in as first param
    mov rsi, max ; array size passed in as second param
    call input_array
    mov r15, rax ; length of A
    pop rax

;Output number presentation
    push qword 0
    mov rax, 0
    mov rdi, present_numbers_A
    call printf
    pop rax

;Display the numbers in array using the Display module
    push qword 0
    mov rax, 0
    mov rdi, arrayA
    mov rsi, r15
    call display_array
    pop rax

;======Array B======;
;Inform user of reversal
  push qword 0
  mov rax, 0
  mov rdi, inform_reverse
  call printf
  pop rax

;Call reverse function
    push qword 0
    mov rax, 0
    mov rdi, r15 ; length of A
    mov rdx, arrayA
    mov rcx, arrayB
    call reverse
    mov r14, rax ; length of B
    pop rax
    
;Output number presentation
    push qword 0
    mov rax, 0
    mov rdi, present_numbers_B
    call printf
    pop rax

;Display the numbers in array using the Display module
    push qword 0
    mov rax, 0
    mov rdi, arrayB
    mov rsi, r14
    call display_array
    pop rax

pop rax ; counter push at the beginning

;Restore
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