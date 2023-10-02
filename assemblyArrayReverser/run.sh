# Information
    # Author: Kevin Tran
    # Email: kev.tran.2001@gmail.com
    # Program Name: Assembly Array Reverser
    #Purpose: script file to run the program files together.

# ===== Begin code area ================================================================================================

rm *.o
rm *.out

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble reverse.asm"
nasm -f elf64 -l reverse.lis -o reverse.o reverse.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "compile main.c using gcc compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "compile display_array.cc using the g++ compiler standard 2017"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.cc

echo "Link object files using the g++ Linker standard 2020"
g++ -m64 -std=c++20 -no-pie -o reverse-array.out main.o display_array.o input_array.o reverse.o manager.o

echo "Run the Reverse Array Program:"
./reverse-array.out

rm *.lis
rm *.o
rm *.out