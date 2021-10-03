# con esta sentencia se indica el archivo de salida 
# para poder ver los resultados
set logging file reporte.txt

# para que las salidas de print se vean bien
set print pretty on

# para que las salidas de los comandos se registren
set logging on

# para evitar que gdb haga preguntas y\n
set pagination off

# indicar el archivo que se va a depurar
file limite 

# fijar breakpoints
b limiteASM

b valor_de_N

b valor_1mas1entreN

b limite

b done

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

continue
ni
p $xmm0.v4_float[0] 

continue
p $xmm1.v4_float[0] 


continue
set $cont = $rax

while($cont > 1)
	p $xmm1.v4_float[0] 
    set $cont = $rax
    continue
end

p $xmm1.v4_float[0] 
echo FIN 

quit