nasm -f elf64 limiteASM.asm -o limite.o
gcc limite.o limite.c -o limite
gdb -x limite.gdb
./limite
