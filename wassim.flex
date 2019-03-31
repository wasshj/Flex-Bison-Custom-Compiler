%{
#include"wassim.tab.h"
#include<stdio.h>
#include<stdlib.h>
int type_compar(char *s);
int mot_pascal(char *s);
void afficher(const char *msg)
{printf("Analyse lexicale : %s \n",msg);}
%}
blanc [\t\n]+
comment ("(*"({id}|({blanc})?)*"*)")*
lettre [A-Za-z]
chiffre [0-9]
id {lettre}({lettre}|{chiffre})*
nb {chiffre}+
type "Int"|"LongInt"
mot_cles "if"|"then"|"program"|"repeat"|"until"|"not"|"func"|"proc"|"var"
%%
{comment} {afficher("Commentaire ");}
{mot_cles} {return mot_pascal(yytext);}
{type} {return type_compar(yytext);}


":=" {afficher("OpAffect");return OPPAFFECT;}
"*"|"/"|[d][i][v]|[m][o][d]|[a][n][d] {afficher("OpMult ");return OPMULT;}
"." {afficher ("End"); return END;}
";" {afficher (";"); return PV;}
":" {afficher (":");return DP;}
"," {afficher (",");return VG;}
"=" {afficher ("=");return EG;}
"(" {afficher ("(");return PO;}
")" {afficher (")");return PF;}
"{" {afficher ("{");return AO;}
"}" {afficher ("}");return AF;}
[*][*] {afficher("Puissance ");return PUISS;}
{id} {afficher("ID ");return ID;}
{nb} {afficher("NB  ");return NB;}
"+"|"-"|[o][r] {afficher("OpAdd ");return OPADD;}
"=="|"<>"|"<"|">"|"<="|">=" {afficher("Oprel ");return OPREL;}
{blanc}+;
.|\n;
%%
int mot_pascal(char *s)
{
if(strcmp(s,"if")==0){ afficher("mot cle : IF ");return IF;}
if(strcmp(s,"then")==0) {afficher("mot cle : THEN ");return THEN;}
if(strcmp(s,"else")==0) {afficher("mot cle : ELSE ");return ELSE;}
if(strcmp(s,"program")==0) {afficher("mot cle : PROGRAM ");return PROGRAM;}
if(strcmp(s,"repeat")==0) {afficher("mot cle : REPEAT ");return REPEAT;}
if(strcmp(s,"until")==0) {afficher("mot cle : UNTIL ");return UNTIL;}
if(strcmp(s,"not")==0) {afficher("mot cle : NOT ");return NOT;}
if(strcmp(s,"func")==0) {afficher("mot cle : FUNC ");return FUNC;}
if(strcmp(s,"proc")==0) {afficher("mot cle : PROC ");return PROC;}
if(strcmp(s,"var")==0) {afficher("mot cle : VAR ");return VAR;}
}
int type_compar(char *s)
{
if(strcmp(s,"Int")==0){afficher("Type : INT "); return INT;}
if(strcmp(s,"LongInt")==0) {afficher("Type : LONGINT ");return LONGINT;}
} 
int yywrap(void)
{return 1;
}
