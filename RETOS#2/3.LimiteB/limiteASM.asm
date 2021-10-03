section .text
    global limiteASM

limiteASM:
    xorps xmm0, xmm0
    xorps xmm1, xmm1
    xorps xmm2, xmm2
    cmp	  rdi,	0           ;Comparo si el N ya es 0 
	je	  done              ;Si es 0 lo mando para la salida 

    mov   rax,  rdi
valor_de_N:
    cvtsi2ss    xmm0,  rax      ;n

    xor         rbx,   rbx
    mov         rbx,     1
    cvtsi2ss    xmm1,  rbx
    cvtsi2ss    xmm2,  rbx

    divss       xmm1, xmm0
valor_de_x:
    addss       xmm1, xmm2  ;1+1/n

    ;En xmm1 tengo mi x 
    ;En rax tengo mi n 

    mov         r8,   1
    cvtsi2ss    xmm2, r8    ;xmm2 = 1
    mov         rbx,  0
    xor         rdx,  rdx
    mov         r9,   2

exponencialBinario:
    mov         rcx,  1
    and         rcx,  rax
    cmp         rcx,  r8
    jne  paso
    mulss       xmm2, xmm1 
paso:
    mulss       xmm1, xmm1
    div         r9
    cmp         rax, rbx
    jg          exponencialBinario

done:
	movss       [rsi], xmm2        ;Devuelvo la respuesta por el 3er argumento
	ret