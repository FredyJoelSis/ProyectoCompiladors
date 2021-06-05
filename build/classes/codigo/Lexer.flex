package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens

L = [a-zA-Z]
D = [0-9]
L2 = [a-zA-ZáéíóúÁÉÍÓÚñÑÜü]
espacio=[ \t \r \n]+
TEXTO_GENERAL =  {L}+  |  {L}+ " "+ {L}* 



AF = {L2}*{D}*
CORREO = {AF}* "@" {L2}+"."{L2}+"."{L2}+
Comilla = "\"" | "&quot;" 




%{
    public String lexeme;
%}
%%

{espacio} {/*Ignore*/;}
"INI_HTML" {lexeme=yytext(); return InicioHtml;}

{D}+ {lexeme=yytext(); return Digito;}
{D}+ "." {D}+ {lexeme=yytext(); return NDecimal;}
"+" {lexeme=yytext(); return SignoMas;}
"-" {lexeme=yytext(); return SignoMenos;}
":" {lexeme=yytext(); return DosPuntos;}
"*" {lexeme=yytext(); return SignoMulti;}
";" {lexeme=yytext(); return PuntoComa;}
{Comilla} {lexeme=yytext(); return Comillas;}



"ENCABEZADO_INI" {lexeme=yytext(); return InicioHead;}
"TIT" {lexeme=yytext(); return InicioTitle;}
"TIT_FIN" {lexeme=yytext(); return FinTitle;}
"ENCABEZADO_FIN" {lexeme=yytext(); return FinHead;} 

"CUERPO_INI" {lexeme=yytext(); return InicioBody;}

"TABLA_IN" {lexeme=yytext(); return InicioTable;}
"FILA_INI" {lexeme=yytext(); return InicioTr;}
"COLUMNA_INI" {lexeme=yytext(); return InicioTh;}

"=" {lexeme=yytext(); return SignoIgual;}
"(" {lexeme=yytext(); return ParA;}



")" {lexeme=yytext(); return ParC;}

"COLUMNA_FIN" {lexeme=yytext(); return FinTh;}
"FILA_FIN"  {lexeme=yytext(); return FinTr;}

"TABLA_FIN"  {lexeme=yytext(); return FinTable;}

"NEGRITA_INI" {lexeme=yytext(); return InicioTextoB;}
 
"NEGRITA_FIN" {lexeme=yytext(); return FinTextoB;}


"IMPRIMIR"  {lexeme=yytext(); return SalidaTexto;}

"LISTA_IN" {lexeme=yytext(); return InicioList;}
"\,"       {lexeme=yytext(); return Coma;}
"ELEMENTO_INI" {lexeme=yytext(); return InicioLi;}
"ELEMENTO_FIN" {lexeme=yytext(); return FinLi;}
"LISTA_FIN" {lexeme=yytext(); return FinList;}

"ENLACE" {lexeme=yytext(); return Enlace;}

"IMAGEN_IN" {lexeme=yytext(); return InicioImg;}



"IMAGEN_FIN" {lexeme=yytext(); return FinImg;}

"CUERPO_FIN" {lexeme=yytext(); return FinBody;}

"FIN_HTML" {lexeme=yytext(); return FinHtml;}

 ( "www" "." {L}+ "." {L}+ ) | 
 ( "www" "." {L}+ "." {L}+ "/" {L}+ "." {L}+ )  {lexeme=yytext(); return URL;}

{CORREO} {lexeme=yytext(); return Correo;}


{L}+ | {L}+ " "*  {lexeme=yytext(); return Texto;}


{TEXTO_GENERAL} {lexeme=yytext(); return TextoGeneral;}



 . {lexeme=yytext(); return Error;}
