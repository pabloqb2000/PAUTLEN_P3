%{
/*
Ejemplo de Bison - La solución de la práctica debe seguir los parámetros indicados en el documento.
*/
#include <stdio.h>
int yylex();
void yyerror();
extern FILE * out;
extern long yylin;
extern long yycol;
extern int yy_morph_error;
%}

%token TOK_MAIN 
%token TOK_INT 
%token TOK_BOOLEAN 
%token TOK_ARRAY 
%token TOK_FUNCTION 
%token TOK_IF 
%token TOK_ELSE 
%token TOK_WHILE 
%token TOK_SCANF 
%token TOK_PRINTF 
%token TOK_RETURN 

%token TOK_PUNTOYCOMA         
%token TOK_COMA               
%token TOK_PARENTESISIZQUIERDO
%token TOK_PARENTESISDERECHO  
%token TOK_CORCHETEIZQUIERDO  
%token TOK_CORCHETEDERECHO    
%token TOK_LLAVEIZQUIERDA     
%token TOK_LLAVEDERECHA       
%token TOK_ASIGNACION         
%token TOK_MAS                
%token TOK_MENOS              
%token TOK_DIVISION           
%token TOK_ASTERISCO          
%token TOK_AND                
%token TOK_OR                 
%token TOK_NOT                
%token TOK_IGUAL              
%token TOK_DISTINTO           
%token TOK_MENORIGUAL         
%token TOK_MAYORIGUAL         
%token TOK_MENOR              
%token TOK_MAYOR     

%token TOK_IDENTIFICADOR 

%token TOK_CONSTANTE_ENTERA
%token TOK_TRUE            
%token TOK_FALSE           

%token TOK_ERROR 

%left TOK_MAS TOK_MENOS
%left TOK_DIVISION TOK_ASTERISCO
%left TOK_AND TOK_OR
%%

declaraciones: declaracion {fprintf(out, ";R2:	<declaraciones> ::= <declaracion> <declaraciones>\n");}
             | declaracion declaraciones {fprintf(out, ";R3:	<declaraciones> ::= <declaracion>\n");}
             ;

declaracion : clase identificadores {fprintf(out, ";R4:	<declaracion> ::= <clase> <identificadores> ;\n");}
            ;

clase: clase_escalar {fprintf(out, ";R5:	<clase> ::= <clase_escalar>\n");}
     | clase_vector {fprintf(out, ";R7:	<clase> ::= <clase_vector>\n");}
     ;

clase_escalar: tipo {fprintf(out, ";R9:	<clase_escalar> ::= <tipo>\n");}
             ;

tipo: int {fprintf(out, ";R10:	<tipo> ::= int\n");}
    | boolean {fprintf(out, ";R11:	<tipo> ::= boolean\n");}
    ;

clase_vector: array tipo [constante_entera] {fprintf(out, ";R15:	<clase_vector> ::= array <tipo> [<constante_entera>]\n");}
            ;

identificadores: identificador {fprintf(out, ";R18:	<identificadores> ::= <identificador>\n");}
               | identificador identificadores {fprintf(out, ";R19:	<identificadores> ::= <identificador> <identificadores>\n");} 
               ;

funciones: funcion funciones {fprintf(out, ";R20:	<funciones> ::= <funcion> <funciones>\n");}
         |  {fprintf(out, ";R21:	<funciones> ::=\n");}
         ;

funcion: function tipo identificador ( parametros_funcion ) { declaracion_funcion sentencias } {fprintf(out, ";R22:	<funcion> ::= function <tipo> <identificador> ( <parametros_funcion> ) { <declaraciones_funcion> <sentencias> } \n");}
       ;

parametros_funcion: parametro_funcion resto_parametros_funcion {fprintf(out, ";R23:	<parametros_funcion> ::= <parametro_funcion> <resto_parametros_funcion>\n");}
                  |  {fprintf(out, ";R24:	<parametros_funcion> ::=\n");}   
                  ;

resto_parametros_funcion: TOK_PUNTOYCOMA parametro_funcion parametros_funcion {fprintf(out, ";R25:	<resto_parametros_funcion> ::= ; <parametro_funcion> <resto_parametros_funcion>\n");}
                        |  {fprintf(out, ";R26:	<resto_parametros_funcion> ::=\n");}
                        ;

parametro_funcion: tipo identificador {fprintf(out, ";R27:	<parametro_funcion> ::= <tipo> <identificador>\n");}
                 ;

declaraciones_funcion: declaraciones {fprintf(out, ";R28:	<declaraciones_funcion> ::= <declaraciones>\n");}
                     |  {fprintf(out, ";R29:	<declaraciones_funcion> ::=\n");}
                     ;

sentencias: sentencia {fprintf(out, ";R30:	<sentencias> ::= <sentencia>\n");}
          | sentencia sentencias {fprintf(out, ";R31:	<sentencias> ::= <sentencia> <sentencias>\n");}
          ;

sentencia: sentencia_simple TOK_PUNTOYCOMA {fprintf(out, ";R32:	<sentencias> ::= <sentencia_simple> ;\n");}
         | bloque {fprintf(out, ";R33:	<sentencias> ::= <bloque>\n");}
         ;

sentencia_simple: asignacion {fprintf(out, ";R34:	<sentencia_simple> ::= <asignacion>\n");}
                | lectura {fprintf(out, ";R35:	<sentencia_simple> ::= <lectura>\n");}
                | escritura {fprintf(out, ";R36:	<sentencia_simple> ::= <escritura>\n");}
                | retorno_funcion {fprintf(out, ";R38:	<sentencia_simple> ::= <retorno_funcion>\n");}
                ;

bloque: condicional {fprintf(out, ";R40:	<bloque> ::= <condicional>\n");}
      | bucle {fprintf(out, ";R41:	<bloque> ::= <bucle>\n");}

asignacion: identificador TOK_ASIGNACION exp  {fprintf(out, ";R43:	<asignacion> ::= <bucle>\n");}
          ;


exp: exp TOK_MAS exp {fprintf(out, "exp Opt. 1\n");}
   | exp TOK_MENOS exp {fprintf(out, "exp Opt. 1\n");}
   | identificador {fprintf(out, "exp Opt. 1\n");}
   | constante {fprintf(out, "exp Opt. 1\n");}
   ;

identificador: TOK_IDENTIFICADOR {fprintf(out, "identificador\n");}
             ;

constante: TOK_CONSTANTE_ENTERA {fprintf(out, "constante\n");}
         ;

%%

void yyerror(const char * s) {
    if(!yy_morph_error) {
        printf("****Error sintactico en linea: %ld\n", yylin);
    }
}



exp: exp TOK_MAS exp {fprintf(out, "exp Opt. 1\n");}
   | exp TOK_MENOS exp {fprintf(out, "exp Opt. 1\n");}
   | identificador {fprintf(out, "exp Opt. 1\n");}
   | constante {fprintf(out, "exp Opt. 1\n");}
   ;

escritura: printf exp {fprintf(out, ";R56:\t<escritura> ::= printf <exp>\n");};

retorno_funcion: return exp {fprintf(out, ";R61:\t<retorno_funcion> ::= return <exp>\n");};

exp: exp + exp       {fprintf(out, ";R72:\t<exp> ::= <exp> + <exp>\n");} 
   | exp - exp       {fprintf(out, ";R73:\t<exp> ::= <exp> - <exp>\n");} 
   | exp / exp       {fprintf(out, ";R74:\t<exp> ::= <exp> / <exp>\n");}  
   | exp * exp       {fprintf(out, ";R75:\t<exp> ::= <exp> * <exp>\n");} 
   | - exp           {fprintf(out, ";R76:\t<exp> ::= - <exp>\n");}
   | exp && exp      {fprintf(out, ";R77:\t<exp> ::= <exp> && <exp>\n");} 
   | exp || exp      {fprintf(out, ";R78:\t<exp> ::= <exp> || <exp>\n");} 
   | ! <exp>         {fprintf(out, ";R79:\t<exp> ::= ! <exp>\n");}
   | identificador   {fprintf(out, ";R80:\t<exp> ::= <identificador>\n");}
   | constante       {fprintf(out, ";R81:\t<exp> ::= <constante>\n");}
   | ( exp )         {fprintf(out, ";R82:\t<exp> ::= ( <exp> )\n");}
   | ( comparacion ) {fprintf(out, ";R83:\t<exp> ::= ( <comparacion> )\n");}
   | elemento_vector {fprintf(out, ";R85:\t<exp> ::= <elemento_vector>\n");}
   | identificador ( lista_expresiones ) {fprintf(out, ";R88:\t<exp> ::= <identificador> ( <lista_expresiones> )\n");}
   ;

lista_expresiones: exp	resto_lista_expresiones {fprintf(out, ";R89:\t<lista_expresiones> ::= <exp> <resto_lista_expresiones>\n");}
	             | {fprintf(out, ";R90:\t<lista_expresiones> ::=\n");} 
                 ;	
                 
resto_lista_expresiones: , exp resto_lista_expresiones {fprintf(out, ";R91:\t<resto_lista_expresiones> ::= , <exp> <resto_lista_expresiones>\n");}
	                   | {fprintf(out, ";R92:\t<resto_lista_expresiones> ::=\n");} 
                       ;

comparacion: exp == exp {fprintf(out, ";R93:\t<comparacion> ::= <exp> == <exp>\n");} 
 	       | exp != exp {fprintf(out, ";R94:\t<comparacion> ::= <exp> != <exp>\n");} 
 	       | exp <= exp {fprintf(out, ";R95:\t<comparacion> ::= <exp> <= <exp>\n");} 
 	       | exp >= exp {fprintf(out, ";R96:\t<comparacion> ::= <exp> >= <exp>\n");} 
 	       | exp < exp  {fprintf(out, ";R97:\t<comparacion> ::= <exp> < <exp>\n");} 
 	       | exp > exp  {fprintf(out, ";R98:\t<comparacion> ::= <exp> > <exp>\n");} 
           ;

constante: constante_logica {fprintf(out, ";R99:\t<constante> ::= <constante_logica>\n");}
         | constante_entera {fprintf(out, ";R100:\t<constante> ::= <constante_entera>\n");}
         ;

constante_logica: TOK_TRUE  {fprintf(out, ";R102:\t<constante_logica> ::= TOK_TRUE\n");}
            	| TOK_FALSE {fprintf(out, ";R103:\t<constante_logica> ::= TOK_FALSE\n");}
                ;
constante_entera: TOK_CONSTANTE_ENTERA {fprintf(out, ";R104:\t<constante_entera> ::= TOK_CONSTANTE_ENTERA\n");}
                ;

identificador: TOK_IDENTIFICADOR {fprintf(out, ";R104:\t<identificador> ::= TOK_IDENTIFICADOR\n");}
             ;

%%

void yyerror(const char * s) {
    if(!yy_morph_error) {
        printf("****Error sintactico en linea: %ld\n", yylin);
    }
}