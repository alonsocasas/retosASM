nasm -f elf64 -g reto1.asm -o reto1.o
gcc  -m64 reto1.o -o reto1
gdb -x reto1.gdb
./reto1

