
section .text
    global varianzaASM                  

varianzaASM:                    ;Inicio del programa
	xorpd	xmm0,	xmm0        ;Limpio mi registro xmm0
	xorpd	xmm1,	xmm1        ;Limpio mi registro xmm1
	xorpd	xmm2,	xmm2        ;Limpio mi registro xmm2
	cmp	    rsi,	0           ;Comparo si el N ya es 0 
	je	done                    ;Si es 0 lo mando para la salida 

valor_N:
    mov     rax, rsi            ;Copio mi N       
    mov     rbx, rdi            ;Copio el puntero a rbx que usare en la 2da iteracion
promedio:
    movss   xmm0, [rdi]         ;Copio el elemento 
    addss   xmm1, xmm0          ;Sumo el elemento en el acumulador
    add	    rdi,	4           ;Añado 4 porque estoy usando floats
    dec     rsi                 ;Decremento en 1 el N
    cmp     rsi, 0              ;Si no es 0 sigue iterando
    jne     promedio

    mov      rsi, rax            ;Copio N denuevo 
    cvtsi2ss xmm2, rsi           ;Convierto en float
obtengo_promedio:   
    divss    xmm1, xmm2          ;Obtengo el promedio

    xorpd	xmm0,	xmm0         ;Limpio los registros xmm0 y xmm3
    xorpd   xmm3,   xmm3

varianza: 
    movss   xmm0, [rbx]          ;Copio el elemento 
    subss   xmm0, xmm1           ;Le resto la media al elemento
    mulss   xmm0, xmm0           ;Lo multiplico por el mismo
    addss   xmm3, xmm0           ;Lo agrego a mi acumulador 
    add	    rbx,	4            ;Aumento en 4 mi puntero 
    dec     rax                  ;Decremento en 1 el N
    cmp     rax, 0               ;Si no es 0 sigue iterando 
    jne     varianza               

sumEntreN:
divss xmm3, xmm2                ;sumtoria/N

done:
	movss	[rdx],	xmm3        ;Devuelvo la respuesta por el 3er argumento
	ret
