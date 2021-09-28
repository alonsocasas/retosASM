#include <stdio.h>
#include <stdlib.h>

extern void varianzaASM(float *v1, int N, float *rpta);
void varianzaC(float *v1, int N, float *rpta);

int main() {

	float *v1, rptaC, rptaAsm;
	int N = 30;
	
	v1 = malloc(N * sizeof(float));
	int i = 0;

	for(i = 0; i < N; i++){
		v1[i] = (float)i+1;
	}

	varianzaC(v1, N, &rptaC);
	varianzaASM(v1, N, &rptaAsm);

	printf("%f\n%f\n",rptaC,rptaAsm);

	return 0;
};

void varianzaC(float *v1, int N, float *rpta) {
	int i = 0;
	float sum = 0;
    
    for(i = 0; i < N; i++){
        sum += v1[i];
    }
    float prom = sum / N; 

    sum = 0;
	for(i = 0; i < N; i++) {
		sum += (v1[i]-prom)*(v1[i]-prom);
	}

    sum = sum / N;

	rpta[0] = sum;
}