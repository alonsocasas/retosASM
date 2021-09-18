# con esta sentencia se indica el archivo de salida 
# para poder ver los resultados
set logging file outReto1.txt

# para que las salidas de print se vean bien
set print pretty on

# para que las salidas de los comandos se registren
set logging on

# para evitar que gdb haga preguntas y\n
set pagination off

# indicar el archivo que se va a depurar
file reto1  

# fijar breakpoints
b main

b iteracion

b a_1

b a_ver

b iteracion2

b resultado

# hook previo para echo
define hook-echo
echo <<<---
end

# hook posterior para echo
define hookpost-echo
echo --->>>\n
end

# aqui empieza el programa
echo INICIO

# empezar a correr el programa
run

# para que continue porque hay breakpoints
continue

#Vere si de verdad hayo los factoriales de los digitos
info r r8 r9 rcx

set $cont = $rcx

while($cont > 0)
	info r r11 r15 r10
    set $cont = $rcx
    continue
end

continue
ni
#Vere la respuesta de la sumatoria
info r r10 

set $cont = $rcx

while($cont > 0)
	info r r13 rcx
    set $cont = $rcx
    continue
end

info r rax
echo FIN 

quit