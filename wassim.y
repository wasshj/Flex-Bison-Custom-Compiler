%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#define YYSTYPE char*
extern FILE *yyin;
int yylex(void);
void yyerror(char*);

%}
%token PROGRAM
%token REPEAT
%token UNTIL
%token NOT
%token FUNC
%token PROC
%token VAR
%token INT
%token LONGINT
%token OPREL
%token OPADD
%token OPMULT
%token OPPAFFECT
%token PUISS
%token CHAINE
%token ID
%token END
%token DP
%token PV
%token VG
%token EG
%token PO
%token PF
%token AO
%token AF
%token NB
%token IF
%token THEN
%token ELSE
%start programme

%%
programme:PROGRAM ID PV declarations declaration_sous_programmes instruction_composee END 
         ;
declarations:VAR declaration
	    |
	    ;
declaration:liste_identificateurs DP type PV declaration
	   |liste_identificateurs DP type PV
	   ;
type:INT
    |LONGINT
    ;
liste_identificateurs:ID 
		     |liste_identificateurs VG ID 
                     ;
declaration_sous_programmes:declaration_sous_programmes declaration_sous_programme PV
		            |
			    ;
declaration_sous_programme:entete_sous_programmes declarations instruction_composee
	                  ;
entete_sous_programmes:FUNC ID arguments DP type PV
                      |PROC ID arguments PV
                      ;
arguments:PO liste_parametres  PF
         |
         ;
liste_parametres:liste_identificateurs DP type
                |liste_parametres PV liste_identificateurs DP type
                ;
instruction_composee:AO instructions_optionnelles AF 
                    ;
instructions_optionnelles:liste_instructions 
                         ; 
liste_instructions:instruction 
                  |liste_instructions PV instruction  
                  ;
instruction:variable OPPAFFECT expression
           |instruction_proc
           |instruction_composee
           |IF expression THEN AO instruction AF
           |IF expression THEN AO instruction AF  AO instruction AF 
           |REPEAT instruction UNTIL expression
           ;
variable:ID
        ;
instruction_proc:ID
                |ID PO liste_expressions PF
                ;
liste_expressions:expression
                 |liste_expressions VG expression
                 ;
expression:expression_simple
          |expression_simple OPREL expression_simple
          ;
expression_simple:terme
                 |signe terme
		 |expression_simple OPADD terme
		 |expression_simple EG terme
                 ;
terme:facteur
     |terme OPMULT facteur
     |terme PUISS facteur
     ;
facteur:ID
       |ID PO liste_expressions PF
       |NB
       |PO expression PF
       |NOT facteur
       ;
signe:'+'
     |'-'
     ;
%%
void yyerror(char*s)
{
printf("%s",s);
}
int main(int argc,char* argv[])
{
yyin=fopen(argv[1],"r");
if(yyparse()==0) printf("programme est bien compilé \n");
else yyerror("erreure de compilation !!");
return 0;
}




