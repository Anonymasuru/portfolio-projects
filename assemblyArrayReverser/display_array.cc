//***************************************************************************************************************************
//Program name: "Assembly Array Reverser".  Copyright (C) 2023 Kevin Tran                                                    *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//Version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************
//
//
//
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//
//Author Information
//  Name: Kevin Tran
//  Email: kev.tran.2001@gmail.com
//
//Program information
//  Program name: Assembly Array Reverser
//  Programming languages: Main function in C; display function in C++; manager and array related functions in X86-64; bash file in Windows Shell
//  Date program began: 2023-Mar-22
//  Date of last update: 2023-Mar-22
//  Comments reorganized: 2023-Oct-02
//  Files in the program: main.c, display_array.cc, run.sh, manager.asm, reverse.asm, input_array.asm
//
//This file
//   File name: display_array.cc
//   Language: C++
//   Compile: g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.cc
//   Link: g++ -m64 -std=c++20 -no-pie -o reverse-array.out main.o display_array.o input_array.o reverse.o manager.o
//   Purpose: This module displays the contents of the array.
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//
// ===== Begin code area ================================================================================================
#include <iostream>

extern "C" void display_array(double arr[], int arr_size);

//Prints the contents of the array, up to arr_size, determined by the fill asm module
void display_array(double arr[], int arr_size) {
  for (int i = 0; i < arr_size; i++)
  {
    printf("%.10lf", arr[i]);
    printf(" ");
  }
  printf("\n");
}