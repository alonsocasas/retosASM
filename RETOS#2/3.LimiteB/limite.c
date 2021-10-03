#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void limiteASM(int N, float *rpta);
void limiteC(int N, float *rpta);

int main() {

	float   rptaC, rptaAsm;
	int     N;
 	struct timespec time1, time2;               // Estructuras necesarias para medir tiempo de cada una de las funciones implementadas.
	printf("Ingrese un numero para N:\n");
	scanf("%d",&N);

    //Funcion en C implementada 
    limiteC(N, &rptaC);
    
    //Funcion en ASM implementada
    limiteASM(N, &rptaAsm);    

    //Imprimimos las respuestas 
    printf("%f\n%f\n",rptaC,rptaAsm);

	return 0;
};

void limiteC( int N, float *rpta) {
    float f;
    //Inicializamos la respuesta
    float res = 1;

    //Nuestro x será el termino del límite
    f = (double)1/N + 1;
    
    while(N > 0){
        //and binario para saber si es impar 
        if(N & 1) res *= f;
        f *= f;
        //Desplazamiento a la derecha N=N/2
        N >>= 1;
    }

    rpta[0] = res;
}