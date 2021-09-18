
;Programa que determina si un numero entero en memoria es fuerte o no
;Se guardara en memoria la letra T en caso este numero sea fuerte
;Se guardara en memoria la lera F en caso no sea numero fuerte

section .data  
    mensaje1 db "Se cumple la igualdad",10      ;Mensaje de que se cumple la igualdad 
	len1 equ $-mensaje1     
    mensaje2 db "No se cumple la igualdad",10   ;Mensaje de que no se cumple la igualdad 
	len2 equ $-mensaje2     
    numero  dd  145                             ;Numero entero en memoria

section .bss
    respuesta resb 1        ;Reservamos un byte para el caracter respuesta

section .text
	global _start 

;Si el numero es de 3 digitos           | Si el numero es de 2 digitos  
;La unidad estará en el registro r8     | La unidad estará en el registro r8 
;La decena estará en el registro r9     | La decena estará en el registro r10 
;La centena estará en el registro r10   |


_start:    
    mov rax, QWORD[numero] ;Copio el numero en memoria al rax
    mov r11, rax

division:   
    mov r8, 10             ;Pongo un 10 para la division 
    mov rdx, 0             ;Limpio el rdx para una division correcta
    div r8                 ;Divido el 145 entre 10

                           ;en el resto me queda       5  => rdx
                           ;en el cociente me queda    14 => rax
    mov r10, rax           ;guardamos el valor de rax en r10
    mov r15, 1             ;RECORDEMOS QUE EL FACTORIAL DE 1 ES 1, no iterariamos
    cmp rdx, r15           ;Comparamos si en este caso la cifra unitaria es 1 
    je  saltaFactorial     ;Si es 1 se salta la iteracion

factorial:
    ;Para hayar el factorial usaremos un loop        
    mov rcx, rdx      ;en rcx tendremos el numero que decrecera como contador
    dec rcx           ;iterara (numero - 1) 
    mov rax, rdx      ;Pasamos el 5 al rax
    mov r8,  rdx      ;usaremos r8 para restarle uno y multiplicarlo

iterara:
    dec     r8                        ;r8 = r8 - 1
    mul     r8                        ;rax = rax*r8   => numero(numero-1)
    loop    iterara        
    mov     r8, rax                   ;en r8 tenemos el factorial del primer digito(la unidad)
    jmp verificar_centena_decena     ;Saltamos a verificar si el numero tiene centenares o decimales

saltaFactorial:
    mov r8, 1            ;Si era 1 entonces al registro correspondiente en este caso de la unidad r8 se le otorga 1

verificar_centena_decena:
    mov rax, r10         ;En r10 tenemos el valor de los numeros decimales y centenares fuera el caso
    mov r9, 10           ;R9 me servira para saber si hay centena o no
    cmp rax, r9          ;Comparo con 10
    jl  no_tiene_centena ;Si es menor que 10 entonces se va defrente a no_tiene_centena porque no habria centena

tiene_centena:          
    mov rdx, 0          ;Limpio el rdx para una division correcta
    div r9              ;en el resto me queda    4  => rdx
                        ;en el cociente me queda 1  => rax  
    mov r10, rax        ;guardamos el valor de rax

    cmp rdx, r15           ;Comparamos si en este caso la cifra decenal es 1 
    je  saltaFactorial2    ;Si es 1 se salta la iteracion

factorial2:    
    mov rcx, rdx      ;en rcx tendremos el numero que decrecera como contador
    dec rcx           ;iterara (numero - 1) 
    mov rax, rdx      ;Pasamos el 5 al rax
    mov r9, rdx       ;usaremos r9 para restarle uno y multiplicarlo

iterara2:
    dec     r9           ;r9 = r9 - 1
    mul     r9           ;rax = rax*r9  => numero(numero-1)
    loop    iterara2      
    mov r9, rax          ;en r9 tenemos el factorial del segundo digito
    jmp seguimos_proceso

saltaFactorial2:
    mov r9, 1

seguimos_proceso:
    mov rax, r10         ;Recuperamos el valor de rax la centena o decena fuera el caso que no tenia centena
    cmp rax, r15         ;Comparamos para ver si es 1
    je saltaFactorial3   ;Si la centena es 1 no se hara bucle 1! = 1

no_tiene_centena:        ;Aca se hayara la centena del numero que tenia centena o decena del numero que no tenia centena
    mov rcx, rax         ;en rcx tendremos el numero que decrecera como contador
    dec rcx              ;iterara (numero - 1) 
    mov r10, rax         ;usaremos r8 para restarle uno y multiplicarlo

iterara3:
    dec     r10           ;r10 = r10  - 1
    mul     r10           ;rax = rax*r10   => numero(numero-1)
    loop    iterara2     
    mov r10, rax          ;en r10 tenemos el factorial del ultimo digito
    jmp Suma

saltaFactorial3:
    mov r10, 1             ;En la centena o decena sea el caso le pones el factorial de 1 que es 1

;Entonces:
;Si el numero es de 3 digitos           | Si el numero es de 2 digitos  
;La unidad estará en el registro r8     | La unidad estará en el registro r8 
;La decena estará en el registro r9     | La decena estará en el registro r10 
;La centena estará en el registro r10   |

Suma: 
    add r8,r10
    mov rax, r11            ;Recuperamos valor inicial
    mov rdx, 0
    mov rcx, 10
    div rcx
    cmp rax, rcx
    jl no_habia_centena    ;Si es menor no habia centena

habia_centena:
    add r8,r9
no_habia_centena:
    cmp r11, r8             ;En r11 teniamos el numero principal
    je  se_cumple_igualdad

no_se_cumple_igualdad:
    mov r15, 70
    mov QWORD[respuesta], r15    ;Se guarda en memoria la letra F    
    ; ----- Codigo para impresión en pantalla ----- ;
	mov rax, 1	         ; función a utilizar (printf)
	mov rdi, 1		     ; imprimir en pantalla: 1
	mov rsi, mensaje2    ; rsi debe contener el puntero hacia el arreglo a imprimir
	mov rdx, len2	         ; numero de elementos a imprimir
	syscall			     ; system call --> llamadas a funciones del sistema (SO)
	; --------------------------------------------- ;
    jmp exit 

se_cumple_igualdad:
    mov r15, 84
    mov QWORD[respuesta], r15    ;Se guarda en memoria la letra F    
    ; ----- Codigo para impresión en pantalla ----- ;
	mov rax, 1	            ; función a utilizar (printf)
	mov rdi, 1		        ; imprimir en pantalla: 1
	mov rsi, mensaje1       ; rsi debe contener el puntero hacia el arreglo a imprimir
	mov rdx, len1	        ; numero de elementos a imprimir
	syscall			        ; system call --> llamadas a funciones del sistema (SO)
	; --------------------------------------------- ;

exit:
    ; ---- return 0 ---- ;
	mov rax, 60		; función para terminar la ejecución del programa. Similar a int 21h
	mov rdi, 0
	syscall
    ; ------------------ ;