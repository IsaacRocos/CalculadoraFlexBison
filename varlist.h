/*
*
	Lista enlazada que se usa para el almacenamiento de 
	las variables que se declaran en las expresiones de la Calculadora.
*
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Elemento {
	
	char nombre[25] ; // Nombre de la variable
	float valor; 	 // Su valor
	struct Elemento* siguiente;

}Variable;

/* PRITOTIPOS ---------------------------------------------*/
void insertarEnLista(Variable** vCabeza , float valorVar, char* nombreVar);
Variable* nuevaVariable(float valorVar, char* nombreVar);
void imprimirVariables();
Variable* buscarVariable(Variable* cabeza,char* nombreVar);
//-----------------------------------------------------------
/*
Para pruebas locales, no se usa por el momento
Variable *cabeza;
Variable *ptr;
*/

/*INSERTA UN NUEVO ELEMENTO EN LA LISTA, ES DECIR, EL IDENTIFICADOR DE LA VARIABLE Y SU VALOR*/
void insertarEnLista(Variable** cabeza , float valorVar, char nombreVar[]){
	Variable *nueva;
	nueva = nuevaVariable(valorVar,nombreVar);
	nueva -> siguiente = *cabeza;
	*cabeza = nueva;
}


/*CREA UNA NUEVA VARIABLE*/
Variable* nuevaVariable(float valorVar, char nombreVar[]){
	Variable *var;
	var = (Variable*)malloc(sizeof(Variable));
	//var -> nombre = nombreVar;
	strcpy( var->nombre, nombreVar );
	var -> valor = valorVar;
	var -> siguiente = NULL;
	printf("\n[vl]Nueva variable: <%s> = %5.2f\n",nombreVar,valorVar);
	return var;
}


/*BUSCA UNA VARIABLE*/
/*
REGRESA indice, si encuentra nombreVar en alguna variable en la lista.
REGRESA NULL,  si no encuentra un variable con nombre nombreVar
*/
Variable* buscarVariable(Variable* cabeza,char nombreVar[]){
	int k;
	Variable *indice;
	printf("[vl]Buscando identificador");
		for( k = 0 , indice = cabeza; indice; ){
			if( strcmp( indice->nombre, nombreVar) == 0 )
  			{
     			printf("[vl]Var Encontrada...\n");
     			return indice;
  			}else{
  				printf(".");
  				k++;
				indice = indice->siguiente;
  			}
		}
		return NULL;
}


/*
void imprimirVariables(){
	int k;
		for( k = 0 , ptr = cabeza; ptr; ){
			printf("%s = %5.2f\n",ptr->nombre,ptr->valor);
			k++;
			ptr = ptr->siguiente;
		}
}
*/
