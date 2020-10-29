/* Analizador sintactico para reconocer java en español  */

/* Sección DEFINICIONES */
%{
#include <stdio.h>
/*#define YYERROR_VERBOSE*/

int yylex();
int yyerror(char *s);
%}

/* Sección REGLAS */
%token TIPO_BYTE TIPO_CORTO TIPO_LARGO TIPO_FLOTANTE TIPO_DOBLE TIPO_ENTERO TIPO_CARACTER TIPO_CADENA TIPO_BOOLEANO TIPO_VACIO ENTERO REAL CARACTER CADENA BOOL OPERADOR_SUMA OPERADOR_RESTA OPERADOR_MULTIPLICACION OPERADOR_DIVISION OPERADOR_MODULO OPERADOR_INCREMENTAL OPERADOR_DECREMENTAL OPERADOR_ARITMETICO_COMBINADO OPERADOR_COMPARACION OPERADOR_BOOLEANO NEG OPERADOR_CONDICIONAL_SI OPERADOR_CONDICIONAL_CONTRA FIN_LINEA ASIGNACION PARENTESIS_A PARENTESIS_C LLAVE_A LLAVE_C CORCHETE_A CORCHETE_C COMA SI CONTRA MIENTRAS HACER PARA CAMBIAR CASO INTERRUMPIR DEFECTO CONTINUAR PUBLICO CLASE ESTATICO PRIMITIVA_LEER PRIMITIVA_ESCRIBIR ESPACIOS SALTO COMENTARIO_LINEA COMENTARIO_LINEAS ID

%%
decl_clase: PUBLICO CLASE ID LLAVE_A decl_main LLAVE_C
    ;
decl_main: PUBLICO ESTATICO TIPO_VACIO ID PARENTESIS_A TIPO_CADENA ID CORCHETE_A CORCHETE_C PARENTESIS_C LLAVE_A S LLAVE_C
    ;
S: I S
    | I
    ;
I: declaracion FIN_LINEA
    | asignaciones FIN_LINEA
    | condicional
    | switch
    | while
    | do
    | for
    | write FIN_LINEA
    | falso_si {printf("Caracter no esperado, se esperaba (");}
    | falso_for {printf("Se esperaba una expresion boolena no aritmetica");}
    | falso_caso {printf("Se esperaba un valor literal");}
    | falso_while {printf("Se esperaba una expresion boolena no aritmetica");}
    | falso_si_expr {printf("Se esperaba una expresion booleana");}
    ;
/*Gramatica para ids*/
identificadores: ID
    | ID COMA identificadores
    ;
expr_aritmetica: expr_aritmetica OPERADOR_SUMA term
    | expr_aritmetica OPERADOR_RESTA term
    | term
    ;
term: term OPERADOR_MULTIPLICACION factor
    | term OPERADOR_DIVISION factor
    | term OPERADOR_MODULO factor
    | factor
    ;
factor: PARENTESIS_A expr_aritmetica PARENTESIS_C
    | ID 
    | ENTERO
    | REAL
    ;
expr_booleana: comp_booleana OPERADOR_BOOLEANO comp_booleana
    | PARENTESIS_A expr_booleana PARENTESIS_C
    | comp_booleana
    | NEG expr_booleana
    ;
comp_booleana: expr_aritmetica OPERADOR_COMPARACION expr_aritmetica
    | PARENTESIS_A comp_booleana PARENTESIS_C
    | BOOL
    | ID
    ;
declaracion: decl_byte
    | decl_corto
    | decl_largo
    | decl_flotante
    | decl_doble
    | decl_entero
    | decl_caracter
    | decl_cadena
    | decl_booleano
    ;
/* Asignaciones */
asignaciones: asig_numero
    | asig_caracter
    | asig_cadena
    | asig_booleano
    | asig_incremental
    | asig_decremental
    ;
asig_numero: identificadores ASIGNACION expr_aritmetica
    | identificadores OPERADOR_ARITMETICO_COMBINADO expr_aritmetica
    ;
/*Declaraciones*/
decl_byte: TIPO_BYTE identificadores
    | TIPO_BYTE asig_numero
    ;
decl_corto: TIPO_CORTO identificadores
    | TIPO_CORTO asig_numero
    ;
decl_largo: TIPO_LARGO identificadores
    | TIPO_LARGO asig_numero
    ;
decl_entero: TIPO_ENTERO identificadores
    | TIPO_ENTERO asig_numero
    ;
decl_flotante: TIPO_FLOTANTE identificadores
    | TIPO_FLOTANTE asig_numero
    ;
decl_doble: TIPO_DOBLE identificadores
    | TIPO_DOBLE asig_numero
    ;
decl_caracter: TIPO_CARACTER identificadores
    | TIPO_CARACTER asig_caracter
    ;
asig_caracter: identificadores ASIGNACION CARACTER
    ;
decl_cadena: TIPO_CADENA identificadores
    | TIPO_CADENA asig_cadena
    ;
asig_cadena: identificadores ASIGNACION CADENA
    | identificadores ASIGNACION PRIMITIVA_LEER
    ;
decl_booleano: TIPO_BOOLEANO identificadores
    | TIPO_BOOLEANO asig_booleano
    ;
asig_booleano: identificadores ASIGNACION expr_booleana
    ;
asig_incremental: ID OPERADOR_INCREMENTAL
    ;
asig_decremental: ID OPERADOR_DECREMENTAL
    ;
condicional: condicional_si condicional_contra
    | condicional_si;
condicional_si: SI PARENTESIS_A expr_booleana PARENTESIS_C I
    | SI PARENTESIS_A expr_booleana PARENTESIS_C LLAVE_A S LLAVE_C;
condicional_contra: CONTRA I
    | CONTRA LLAVE_A S LLAVE_C;
switch: CAMBIAR PARENTESIS_A ID PARENTESIS_C LLAVE_A case default LLAVE_C;
case: CASO expr_aritmetica OPERADOR_CONDICIONAL_CONTRA S INTERRUMPIR FIN_LINEA
    | CASO expr_aritmetica OPERADOR_CONDICIONAL_CONTRA S INTERRUMPIR FIN_LINEA case;
default: /* vacío */
    | DEFECTO OPERADOR_CONDICIONAL_CONTRA S;
while: MIENTRAS PARENTESIS_A expr_booleana PARENTESIS_C I
    | MIENTRAS PARENTESIS_A expr_booleana PARENTESIS_C LLAVE_A S LLAVE_C;
do: HACER I MIENTRAS PARENTESIS_A expr_booleana PARENTESIS_C
    | HACER LLAVE_A S LLAVE_C MIENTRAS PARENTESIS_A expr_booleana PARENTESIS_C;
for: PARA PARENTESIS_A declaracion FIN_LINEA expr_booleana FIN_LINEA asignaciones PARENTESIS_C LLAVE_A S LLAVE_C
    | PARA PARENTESIS_A asignaciones FIN_LINEA expr_booleana FIN_LINEA asignaciones PARENTESIS_C LLAVE_A S LLAVE_C;
write: PRIMITIVA_ESCRIBIƐR PARENTESIS_A CADENA PARENTESIS_C
    | PRIMITIVA_ESCRIBIR PARENTESIS_A ID PARENTESIS_C;
falso_si: SI CORCHETE_A expr_booleana CORCHETE_C;
falso_for: PARA PARENTESIS_A declaracion FIN_LINEA expr_aritmetica FIN_LINEA asignaciones PARENTESIS_C;
falso_caso: CASO ID OPERADOR_CONDICIONAL_CONTRA;
falso_while: MIENTRAS PARENTESIS_A expr_aritmetica PARENTESIS_C;
falso_si_expr: SI PARENTESIS_A expr_aritmetica PARENTESIS_C;
%%

/* Sección CODIGO USUARIO */
FILE *yyin;
int main() {
    do {
        yyparse();
    }
    while ( !feof(yyin) );
    
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "A.Sintactico: %s\n", s);
    return 0;
}
