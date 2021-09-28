#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void limiteASM(int N, float *rpta);
void limiteC(int N, float *rpta);

int main() {

	float   rptaC, rptaAsm;
	int     N;
 	struct timespec time1, time2; // Estructuras necesarias para medir tiempo de cada una de las funciones implementadas.
	printf("Ingrese un numero para N:\n");
	scanf("%d",&N);


	// Midiendo el tiempo de procesamiento para la funcion en C    
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);    // Inicio el contador de tiempo y guardo en la variable time1
	limiteC(N, &rptaC);
	//for(int i=0; i<100; i++){printf("%u\t",Cc[i]);}
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);    // Detengo el contador de tiempo y guardo en la variable time2
    double tC = (double)((time2.tv_sec-time1.tv_sec) + (time2.tv_nsec-time1.tv_nsec)/1e9);  // Calculo el tiempo con la diferencia entre time2 y time1. 

    // Midiendo el tiempo de procesamiento para la funcion en ASM    
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    limiteASM(N, &rptaAsm);
    //for(int i=0; i<100; i++){printf("%u\t", Casm[i]);}

    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2); //toc
    double tASM = (double)((time2.tv_sec-time1.tv_sec) + (time2.tv_nsec-time1.tv_nsec)/1e9);
    
    // Imprimimos los tiempos de cada una de las funciones y el SU relativo de ASM respecto a C
    printf("El tiempo de ejecución en C es: %.5f us\n", tC*1e6);
    printf("El tiempo de ejecución en ASM es: %.5f us\n", tASM*1e6);
    printf("El speed-up es: %.2f \n", tC/tASM);
	
	

	printf("%f\n%f\n",rptaC,rptaAsm);

	return 0;
};

void limiteC( int N, float *rpta) {
    float f,f2;
    int i;

    f = (double)1/N + 1;
    f2 = (double)1/N + 1;
    for(i=0;i<N-1;i++){
    	f = f*f2;	
	}   
    rpta[0] = f;
}