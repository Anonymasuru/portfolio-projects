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
;   File name: input_array.asm
;   Language: X86-64
;   Compile: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;   Link: g++ -m64 -std=c++20 -no-pie -o reverse-array.out main.o display_array.o input_array.o reverse.o manager.o
;   Purpose: This module collects user input and stores it in an array.
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;
; ===== Begin code area ================================================================================================
;Declarations
  extern printf
  extern scanf
  extern stdin
  extern clearerr

  global input_array

segment .data
  float_format db "%lf", 0

segment .bss 

segment .text 

input_array:

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

push qword 0 ;staying on the boundary

; Taking information from parameters
mov r15, rdi  ; This holds the first parameter (the array)
mov r14, rsi  ; This holds the second parameter (the size of array)

; let user enter numbers until cntrl + d is entered
mov r13, 0 ; for loop counter
beginLoop:
  cmp r14, r13 ; we want to exit loop when we hit the size of array
  je outOfLoop
  mov rax, 0
  mov rdi, float_format
  push qword 0
  mov rsi, rsp
  call scanf
  cdqe
  cmp rax, -1  ; loop termination condition: user enters cntrl + d.
  pop r12
  je outOfLoop
  mov [r15 + 8*r13], r12  ;at array[counter], place the input number
  inc r13  ;increment loop counter
  jmp beginLoop
outOfLoop:

mov rax, 0
mov rdi, [stdin]
call clearerr ;clears bits for scanf next time
pop rax ; counter push at the beginning
mov rax, r13  ; store the number of things in the array from the counter of for loop

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