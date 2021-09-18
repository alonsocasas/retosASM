# con esta sentencia se indica el archivo de salida 
# para poder ver los resultados
set logging file outReto2.txt

# para que las salidas de print se vean bien
set print pretty on

# para que las salidas de los comandos se registren
set logging on

# para evitar que gdb haga preguntas y\n
set pagination off

# indicar el archivo que se va a depurar
file reto2  

# fijar breakpoints
b _start

b Suma

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
info r r8 r9 r10
continue

echo FIN 

quit