%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>    
#include "varlist.h"
extern int yylineno;
extern char * yytext;
Variable *cabeza;
Variable *ptr;
void nuevoIdentificador(Variable** cabeza , float valorVar, char nombreVar[]);
void imprimirIdentificador(char identificadorVariable[]);
Variable* identificadorExiste(char identificadorVariable[]);
%}

%union
{
    float real;
    char id[25]; //Para identificadores TKN_ID
}

%start Calculadora
%token <real> TKN_NUM
%token TKN_MAS
%token TKN_MENOS
%token TKN_MULT
%token TKN_DIV
%token TKN_PAA
%token TKN_PAC
%token TKN_COS
%token TKN_SEN
%token TKN_TAN
%token TKN_EXP
%token TKN_SQRT
%token TKN_MODULO
%token TKN_IGUAL
%token TKN_PTOCOMA
%token <id>TKN_ID
%token TKN_IMPRIMIR
%type  <id>Identficador
%type  <real> Expresion
%left  TKN_MAS TKN_MENOS
%left  TKN_MULT TKN_DIV
%right TKN_MODULO
%right TKN_EXP
%left  TKN_SIGNO_MENOS

%%

Calculadora :Expresion TKN_PTOCOMA //{ printf("\n%5.2f\n", $1); };
;
          	
Expresion :  TKN_NUM {$$=$1;}|
//====================== OPERACIONES MATEMATICAS ===========================================
             Expresion TKN_MAS Expresion {$$=$1+$3;}|
             Expresion TKN_MENOS Expresion {$$=$1-$3;}|
             Expresion TKN_MULT Expresion {$$=$1*$3;}|
             Expresion TKN_DIV Expresion {
                                             if($3!=0)
                                                $$=$1/$3;
                                             else
                                                printf("\n>>Resultado indeterminado");
                                         }|
             TKN_PAA Expresion TKN_PAC {$$=$2;}|
             TKN_COS TKN_PAA Expresion TKN_PAC {
                          double rad=($3*3.1416)/180;
                          $$=cos(rad);
                           }|
             TKN_SEN TKN_PAA Expresion TKN_PAC {
                                                  double rad=($3*3.1416)/180;
                          $$=sin(rad);
                                               }|
             TKN_TAN TKN_PAA Expresion TKN_PAC {
                                                  if($3!=90)
                          {
                                                     double rad=($3*3.1416)/180;
                             $$=tan(rad);
                          }
                          else
                             printf("\n>>Resultado Indeterminado");
                                               }|
             Expresion TKN_EXP Expresion {$$=pow($1,$3);}|
             TKN_SQRT TKN_PAA Expresion TKN_PAC {
                                                   if($3>=0)
                                                      $$=sqrt($3);
                                                   else
                                                      printf(">>\nResultado Indeterminado");
                                                }|
             //Expresion TKN_MODULO Expresion {$$=$1%$3;}|
             TKN_MENOS Expresion %prec TKN_SIGNO_MENOS {$$=-($2);}|

//================ CREAR IDENTIFICADORES E IMPRESION=================================================
             
             TKN_IMPRIMIR TKN_PAA Identficador TKN_PAC {imprimirIdentificador($3);}|
             Identficador TKN_IGUAL Expresion {	$$=$3;
			 								printf(">>%s = %5.2f",$1,$$);
			 								nuevoIdentificador(&cabeza , $$, $1);
			 							}
;

Identficador: TKN_ID{strcpy($$, yytext);}
;
%%

void nuevoIdentificador(Variable** cabeza , float valorVar, char nombreVar[]){
    Variable *existe;
    existe = identificadorExiste(nombreVar);
    if(existe!=NULL){
        existe->valor = valorVar;
    }else{
        insertarEnLista(cabeza , valorVar, nombreVar);
    }
}

void imprimirIdentificador(char identificadorVariable[]){
    Variable *existe;
    existe = identificadorExiste(identificadorVariable);
    if(existe!=NULL){
        printf(">>%s = %5.2f\n", existe->nombre,existe->valor);
    }else{
        printf("\n>>Valor de identificador %s nulo\n", identificadorVariable);
    }
}

Variable* identificadorExiste(char identificadorVariable[]){
    Variable *existe;
    existe = buscarVariable(cabeza,identificadorVariable);
    if(existe!=NULL){
        return existe;
    }else{
        return NULL;
    }
}


int yyerror(char *msg)
{
	printf(">>Error (l %d): %s en '%s'\n", yylineno, msg, yytext);
}

int main()
{
    yyparse();
    printf("\n>>Numero lineas analizadas: %d\n", yylineno);
    return (0);
}
