%{
#include <stdio.h>
#include <stdlib.h>
#include "varlist.h"
extern int yylineno;
extern char * yytext;
Variable *cabeza;
Variable *ptr;
void nuevoIdentificador(Variable** cabeza , float valorVar, char nombreVar[]);
%}

%union
{
    float real;
    char id[25]; //Para identificadores TKN_ID
}

%start Calculadora
%token <real> TKN_NUM
%token TKN_IGUAL
%token TKN_PTOCOMA
%token TKN_MAS
%token TKN_MENOS
%token <id>TKN_ID
%type  <id>Identficador
%type  <real> Expresion
%left  TKN_MAS TKN_MENOS
%%

Calculadora :Expresion TKN_PTOCOMA//{ printf("\n%5.2f\n", $1); };
;
          	
Expresion :  TKN_NUM {$$=$1;}|
             Expresion TKN_MAS Expresion {$$=$1+$3;}|
             Expresion TKN_MENOS Expresion {$$=$1-$3;}|
             Identficador TKN_IGUAL Expresion {	$$=$3;
			 								printf("%s = %5.2f",$1,$$);
			 								nuevoIdentificador(&cabeza , $$, $1);
			 							}
;

Identficador: TKN_ID{strcpy($$, yytext);}
;
%%

void nuevoIdentificador(Variable** cabeza , float valorVar, char nombreVar[]){
	insertarEnLista(cabeza , valorVar, nombreVar);
}

int yyerror(char *msg)
{
	printf("%d: Error: %s en '%s'\n", yylineno, msg, yytext);
}

int main()
{
    yyparse();
    printf("\nNumero lineas analizadas: %d\n", yylineno);
    return (0);
}
