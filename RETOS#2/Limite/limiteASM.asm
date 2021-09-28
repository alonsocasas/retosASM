section .text
    global limiteASM

limiteASM:
    xorpd xmm0, xmm0
    xorpd xmm1, xmm1
    xorpd xmm2, xmm2
    cmp	  rdi,	0           ;Comparo si el N ya es 0 
	je	  done              ;Si es 0 lo mando para la salida 

    mov      rax,  rdi
valor_de_N:
    cvtsi2ss xmm0, rax      ;n

    xor         rbx,   rbx
    mov         rbx,     1
    cvtsi2ss    xmm1,  rbx
    cvtsi2ss    xmm2,  rbx

    divss       xmm1, xmm0
    addss       xmm1, xmm2  ;1+1/n
valor_1mas1entreN:
    movss       xmm2, xmm1  ;copia

    dec rax                 ;N-1
limite:
    mulss   xmm1, xmm2
    dec rax
    cmp rax, 0 
    jne limite

done:
	movss	[rdx],	xmm1        ;Devuelvo la respuesta por el 3er argumento
	ret