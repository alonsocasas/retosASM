section .datad
    mensaje1 db "Se cumple la siguiente igualdad",10     
    mensaje2 db "No se cumple la siguiente igualdad",10

    a dq  2
    n dq  3

section .bss
    respuesta resb 1 

section .text

    global main 

main: 

    mov r8, QWORD[rel a] ;Copio el a en memoria al r8       
    mov r9, QWORD[rel n] ;Copio el n en memoria al r9  

    mov r10, 0 
    mov r11, 255

    cmp r8, r10 
    jl final
    cmp r8, r11
    jg final 

    cmp r9, r10 
    jl final
    cmp r9, r11
    jg final 


    mov rcx, r9     ;en rcx tendremos el numero que decrecera como contador N
    dec rcx
    mov r10, 0      ;para mantener la suma
    mov r12, 0       

iteracion: 
    mov r11, rcx
    mov r15, r8
    potencia:
        mov rax, r8     ;en rax guardo el a 
        mul r15 
        mov r15, rax 
        dec r11     
        cmp r11, r12
        jne potencia    

    add r10, r15       ;Sumo el cuadrado a mi sumador
    loop iteracion    


a_1:
add r10, r8             ; le sumamos el a^1
;En r10 tendremos la sumatoria

a_ver:
    

xor r11, r11

mov r11, r8 ;a
mov r13, r8 ;a
mov r12, r9 ;N

dec r11 ;a-1
inc r12 ;N+1

mov rcx, r9 ;rcx <= N para la iteracion
mov r14, 0  ;Guardaremos el productor
iteracion2:
    mov rax, r8
    mul r13
    mov r13, rax
loop iteracion2

;En r13 terminamos con el a^N-1

sub r13, r8 ;(a^N-1)-a
mov rax, r13 
mov rdx, 0
div r11

;En r13 tenemos el resultado
resultado:
mov r13, rax 


final:
    mov rax, 0
    ret
