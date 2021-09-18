nasm -f elf64 -g reto2.asm -o reto2.o
ld reto2.o -o reto2
gdb -x reto2.gdb
./reto2 