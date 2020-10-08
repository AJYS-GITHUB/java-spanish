/* Programa que reconoce el lenguaje java en español */

/* Sección DEFINICIONES */
%{
#include <stdio.h>
#include "parser.tab.h"


int agregar_token(int tipo, char *palabra);
int buscar_token(char *palabra, int tipo);
int listar_tokens();
%}



TIPO_BYTE byte
TIPO_CORTO corto
TIPO_LARGO largo
TIPO_FLOTANTE flotante
TIPO_DOBLE doble
TIPO_ENTERO entero
TIPO_CARACTER caracter
TIPO_CADENA cadena
TIPO_BOOLEANO booleano
TIPO_VACIO vacio
ENTERO -?[0-9]+
REAL -?[0-9]+\.[0-9]+
CARACTER \'.\'
CADENA \"(.|\n)*\"
BOOL (verdad|falso)
OPERADOR_SUMA "+"
OPERADOR_RESTA "-"
OPERADOR_MULTIPLICACION "*"
OPERADOR_DIVISION "/"
OPERADOR_MODULO "%"
OPERADOR_INCREMENTAL "++"
OPERADOR_DECREMENTAL "--"
OPERADOR_ARITMETICO_COMBINADO ("+="|"-="|"*="|"/="|"%=")
OPERADOR_COMPARACION ("=="|"<="|">="|"<"|">"|"!=")
OPERADOR_BOOLEANO ("&"|"&&"|"|"|"||"|"^")
NEG "!" 
OPERADOR_CONDICIONAL_SI ("?")
OPERADOR_CONDICIONAL_CONTRA (":")
FIN_LINEA ";"
ASIGNACION "="
PARENTESIS_A "("
PARENTESIS_C ")"
LLAVE_A "{"
LLAVE_C "}"
CORCHETE_A "["
CORCHETE_C "]"
COMA ","
SI "si"
CONTRA "contra"
MIENTRAS "mientras"
HACER "hacer"
PARA "para"
CAMBIAR "cambiar"
INTERRUMPIR "interrumpir"
DEFECTO "defecto"
CONTINUAR "continuar"
PUBLICO "publico"
CLASE "clase"
ESTATICO "estatico"
PRIMITIVA_LEER "leerLinea()"
PRIMITIVA_ESCRIBIR "escribirLinea"
ESPACIOS [[:blank:]]
SALTO \n
COMENTARIO_LINEA "//".*\n
COMENTARIO_LINEAS "/*"(.|\n)*"*/"
ID [a-zA-Z_$][a-zA-Z0-9_$]*

/* Sección REGLAS */ 
%%
{PUBLICO} {agregar_token(PUBLICO, yytext); return PUBLICO;}
{CLASE} {agregar_token(CLASE, yytext); return CLASE;}
{ESTATICO} {agregar_token(ESTATICO, yytext); return ESTATICO;}
{PRIMITIVA_LEER} {agregar_token(PRIMITIVA_LEER, yytext); return PRIMITIVA_LEER;}
{PRIMITIVA_ESCRIBIR} {agregar_token(PRIMITIVA_ESCRIBIR, yytext); return PRIMITIVA_ESCRIBIR;}
{SI} {agregar_token(SI, yytext); return SI;}
{CONTRA} {agregar_token(CONTRA, yytext);  return CONTRA;}
{MIENTRAS} {agregar_token(MIENTRAS, yytext); return MIENTRAS;}
{HACER} {agregar_token(HACER, yytext); return HACER;}
{PARA} {agregar_token(PARA, yytext); return PARA;}
{CAMBIAR} {agregar_token(CAMBIAR, yytext); return CAMBIAR;}
{CONTINUAR} {agregar_token(CONTINUAR, yytext); return CONTINUAR;}
{DEFECTO} {agregar_token(DEFECTO, yytext); return DEFECTO;}
{INTERRUMPIR} {agregar_token(INTERRUMPIR, yytext); return INTERRUMPIR;}
{TIPO_BYTE} {agregar_token(TIPO_BYTE, yytext); return TIPO_BYTE;}
{TIPO_CORTO} {agregar_token(TIPO_CORTO, yytext); return TIPO_CORTO;}
{TIPO_LARGO} {agregar_token(TIPO_LARGO, yytext);  return TIPO_LARGO;}
{TIPO_FLOTANTE} {agregar_token(TIPO_FLOTANTE, yytext); return TIPO_FLOTANTE;}
{TIPO_DOBLE} {agregar_token(TIPO_DOBLE, yytext); return TIPO_DOBLE;}
{TIPO_ENTERO} {agregar_token(TIPO_ENTERO, yytext); return TIPO_ENTERO;}
{TIPO_CARACTER} {agregar_token(TIPO_CARACTER, yytext); return TIPO_CARACTER;}
{TIPO_CADENA} {agregar_token(TIPO_CADENA, yytext); return TIPO_CADENA;}
{TIPO_BOOLEANO} {agregar_token(TIPO_BOOLEANO, yytext); return TIPO_BOOLEANO;}
{TIPO_VACIO} {agregar_token(TIPO_VACIO, yytext); return TIPO_VACIO;}
{ENTERO} {agregar_token(ENTERO, yytext); return ENTERO;}
{REAL} {agregar_token(REAL, yytext); return REAL;}
{CADENA} {agregar_token(CADENA, yytext); return CADENA;}
{BOOL} {agregar_token(BOOL, yytext); return BOOL;}
{OPERADOR_SUMA} {agregar_token(OPERADOR_SUMA, yytext); return OPERADOR_SUMA;}
{OPERADOR_RESTA} {agregar_token(OPERADOR_RESTA, yytext); return OPERADOR_RESTA;}
{OPERADOR_MULTIPLICACION} {agregar_token(OPERADOR_MULTIPLICACION, yytext); return OPERADOR_MULTIPLICACION;}
{OPERADOR_DIVISION} {agregar_token(OPERADOR_DIVISION, yytext); return OPERADOR_DIVISION;}
{OPERADOR_MODULO} {agregar_token(OPERADOR_MODULO, yytext); return OPERADOR_MODULO;}
{OPERADOR_INCREMENTAL} {agregar_token(OPERADOR_INCREMENTAL, yytext); return OPERADOR_INCREMENTAL;}
{OPERADOR_DECREMENTAL} {agregar_token(OPERADOR_DECREMENTAL, yytext); return OPERADOR_DECREMENTAL;}
{OPERADOR_ARITMETICO_COMBINADO} {agregar_token(OPERADOR_ARITMETICO_COMBINADO, yytext); return OPERADOR_ARITMETICO_COMBINADO;}
{OPERADOR_COMPARACION} {agregar_token(OPERADOR_COMPARACION, yytext); return OPERADOR_COMPARACION;}
{OPERADOR_BOOLEANO} {agregar_token(OPERADOR_BOOLEANO, yytext); return OPERADOR_BOOLEANO;}
{NEG} {agregar_token(NEG, yytext); return NEG;}
{OPERADOR_CONDICIONAL_SI} {agregar_token(OPERADOR_CONDICIONAL_SI, yytext); return OPERADOR_CONDICIONAL_SI;}
{OPERADOR_CONDICIONAL_CONTRA} {agregar_token(OPERADOR_CONDICIONAL_CONTRA, yytext); return OPERADOR_CONDICIONAL_CONTRA;}
{ID} {agregar_token(ID, yytext); return ID;}
{ASIGNACION} {agregar_token(ASIGNACION, yytext); return ASIGNACION;}
{FIN_LINEA} {agregar_token(FIN_LINEA, yytext); return FIN_LINEA;}
{PARENTESIS_A} {agregar_token(PARENTESIS_A, yytext); return PARENTESIS_A;}
{PARENTESIS_C} {agregar_token(PARENTESIS_C, yytext); return PARENTESIS_C;}
{LLAVE_A} {agregar_token(LLAVE_A, yytext); return LLAVE_A;}
{LLAVE_C} {agregar_token(LLAVE_C, yytext);  return LLAVE_C;}
{CORCHETE_A} {agregar_token(CORCHETE_A, yytext); return CORCHETE_A;}
{CORCHETE_C} {agregar_token(CORCHETE_C, yytext); return CORCHETE_C;}
{COMA} {agregar_token(COMA, yytext); return COMA;}
{ESPACIOS} {}
{SALTO} {}
{COMENTARIO_LINEA} {}
{COMENTARIO_LINEAS} {}

%%
/* Sección CODIGO USUARIO */

struct token {
    char *nombre_token;
    int tipo_token;
    struct token *sgte;
};

struct token *lista = NULL; /*primer elemento de la lista*/

int agregar_token(int tipo, char *token) {
    struct token *p; /*entrada de la lista*/
    
    if ( buscar_token(token, tipo) != 0 ) {
        /*printf("El token %s ya fue definido!!!\n", token);*/
        return 0;
    }
    
    /* asignar espacio de memoria */
    p = malloc( sizeof( struct token ) );
    p->nombre_token = malloc( strlen(token) + 1 ); 
    /* copiar datos de palabra */
    strcpy( p->nombre_token, token );
    p->tipo_token = tipo;
    /* enlazar nueva entrada a lista */
    p->sgte = lista;
    lista = p;
    return 1;
}

int buscar_token(char *token, int tipo){
    struct token *p = lista;
    
    /* buscar palabra en la lista */
    while (p != NULL) {
        if ( strcmp(p->nombre_token, token) == 0 && p->tipo_token == tipo)
            return 1;
        p = p->sgte;
    }
    
    return 0; /*no encontrado*/
}

int listar_tokens(){
    
    /* buscar palabra en la lista */
    struct token *p = lista;    
    /* buscar palabra en la lista */
    while (p != NULL) {
        printf("|tipo_token: %i | valor: %s|\n",p->tipo_token,p->nombre_token);
        p = p->sgte;
    }
    
    return 0; /*no encontrado*/
}
