nasm -f elf64 varianza.asm -o varianza.o
gcc varianza.o varianza.c -o varianza
gdb -x scrip.gdb
./varianza
