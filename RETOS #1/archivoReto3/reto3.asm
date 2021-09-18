
section .data
    cadenaEvaluar db "casasac"      ;Definimos la cadena a comparar si es palindromo
    len equ $-cadenaEvaluar         ;Definimos el tamaño de la cadena

section .bss
    cadenaVolteada resb   30        ;Creamos espacio de memoria para la cadena volteada que usaremos
    caracter       resb   8         ;Creamos espacio de memoria para el caracter

section .text
    global _start                   ;start

_start: 
    mov rax, cadenaEvaluar      ;Puntero en la cadena a evaluar
    mov rbx, 0                  ;Inicializo rbx con 0    


bucle1:                         ;En este primer bucle llevare el puntero hasta el final del arreglo
    inc rax                     ;Incremento indicador de cadenaEvaluar
    inc rbx                     ;Incremento el contador
    cmp rbx, len                ;Comparo el contador con el tamaño de la cadena
    jne bucle1                  ;Si no son iguales sigue la iteracion
    
    dec rax                     ;Decremento 1 porque se pasa 1 por el comparador abajo
    mov rcx, 0                  ;Reseteo rcx porque usare para mover el puntero de la cadena volteada
bucle2:                         ;Aqui el puntero rax ya debe estar en el último caracter
    mov r8, cadenaVolteada      ;Copio en r8 la direccion de cadenaVolteada        
    add r8, rcx                 ;Mueve el puntero

    dec rax                     ;Decremento indicador de cadenaEvaluar
    mov r9b, [rax]               ;r9b toma el ultimo caracter de cadenaEvaluar
    mov [r8], r9b                ;Introduzco el caracter en r8

    
    dec rbx                     ;Decremento el registro que me lleva la cuenta del tamaño
    inc rcx                     ;Incremento indicador de cadenaVolteada
    cmp rbx, 0  
    jne bucle1

comprobar:
    mov r10, cadenaEvaluar      ;Me direcciono al inicio de la cadena denuevo
    mov r11,  cadenaVolteada     ;Me direcciono al inicio de la cadena denuevo

    mov rcx, len
    dec rcx
bucle3:
    xor r12, r12
    xor r13, r13

    mov r12b, [r10]              ;Me guardo un caracter de cadena a evaluar
    mov r13b, [r11]              ;Me guardo un caracter de cadena volteada

    inc r10                      ;Incremento el puntero
    inc r11                      ;Incremento el puntero

    cmp r12b, r13b               ;Comparo los dos caracteres 
    jne no_palindromo            ;Si apenas uno no es igual se va a no palindromo
    loop bucle3                  ;Si termina el bucle se vaa palindromo


palindromo:
    mov r13, caracter  
    mov r15, "T"
    mov [r13], r15
    inc r13
    mov r14, 10
    mov [r13], r14
    jmp impresion

no_palindromo:
    mov r13, caracter  
    mov r15, "F"
    mov [r13], r15
    inc r13
    mov r14, 10
    mov [r13], r14
   

impresion:
	mov rax, 1		    
	mov rdi, 1		    
	mov rsi, caracter	
	mov rdx, 8		
	syscall			   

exit:
	mov rax, 60		
	mov rdi, 0
	syscall