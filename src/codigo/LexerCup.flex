package codigo;

import java_cup.runtime.Symbol;

%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char

L = [a-zA-Z]
D = [0-9]
L2 = [a-zA-ZáéíóúÁÉÍÓÚñÑÜü]
espacio=[ \t \r \n]+
TEXTO_GENERAL =  {L}+  |  {L}+ " "+ {L}* 



AF = {L2}*{D}*
CORREO = {AF}* "@" {L2}+"."{L2}+"."{L2}+
Comilla = "\"" | "&quot;" 


%{
        private Symbol symbol (int type, Object value){
        return new Symbol (type, yyline, yycolumn, value);
    }

    private Symbol symbol (int type){
        return new Symbol (type, yyline, yycolumn);
    }
%}
%%

{espacio} {/*Ignore*/;}
"INI_HTML" {return new Symbol(sym.InicioHtml, yychar, yyline, yytext());}

{D}+          {return new Symbol(sym.Digito, yychar, yyline, yytext());}
{D}+ "." {D}+ {return new Symbol(sym.NDecimal, yychar, yyline, yytext());}
"+"           {return new Symbol(sym.SignoMas, yychar, yyline, yytext());}
"-"           {return new Symbol(sym.SignoMenos, yychar, yyline, yytext());}
":"           {return new Symbol(sym.DosPuntos, yychar, yyline, yytext());}
"*"           {return new Symbol(sym.SignoMulti, yychar, yyline, yytext());}
";"           {return new Symbol(sym.PuntoComa, yychar, yyline, yytext());}
{Comilla}     {return new Symbol(sym.Comillas, yychar, yyline, yytext());}



"ENCABEZADO_INI"    {return new Symbol(sym.InicioHead, yychar, yyline, yytext());}
"TIT"               {return new Symbol(sym.InicioTitle, yychar, yyline, yytext());}
"TIT_FIN"           {return new Symbol(sym.FinTitle, yychar, yyline, yytext());}
"ENCABEZADO_FIN"    {return new Symbol(sym.FinHead, yychar, yyline, yytext());} 

"CUERPO_INI"        {return new Symbol(sym.InicioBody, yychar, yyline, yytext());}

"TABLA_IN"          {return new Symbol(sym.InicioTable, yychar, yyline, yytext());}
"FILA_INI"          {return new Symbol(sym.InicioTr, yychar, yyline, yytext());}
"COLUMNA_INI"           {return new Symbol(sym.InicioTh, yychar, yyline, yytext());}

"="                 {return new Symbol(sym.SignoIgual, yychar, yyline, yytext());}
"("                 {return new Symbol(sym.ParA, yychar, yyline, yytext());}



")"                 {return new Symbol(sym.ParC, yychar, yyline, yytext());}

"COLUMNA_FIN"       {return new Symbol(sym.FinTh, yychar, yyline, yytext());}
"FILA_FIN"          {return new Symbol(sym.FinTr, yychar, yyline, yytext());}

"TABLA_FIN"         {return new Symbol(sym.FinTable, yychar, yyline, yytext());}

"NEGRITA_INI"           {return new Symbol(sym.InicioTextoB, yychar, yyline, yytext());}
"NEGRITA_FIN"       {return new Symbol(sym.FinTextoB, yychar, yyline, yytext());}



"IMPRIMIR"          {return new Symbol(sym.SalidaTexto, yychar, yyline, yytext());}

"LISTA_IN"          {return new Symbol(sym.InicioList, yychar, yyline, yytext());}
"\,"                {return new Symbol(sym.Coma, yychar, yyline, yytext());}
"ELEMENTO_INI"      {return new Symbol(sym.InicioLi, yychar, yyline, yytext());}
"ELEMENTO_FIN"      {return new Symbol(sym.FinLi, yychar, yyline, yytext());}
"LISTA_FIN"         {return new Symbol(sym.FinList, yychar, yyline, yytext());}

"ENLACE"            {return new Symbol(sym.Enlace, yychar, yyline, yytext());}

"IMAGEN_IN"         {return new Symbol(sym.InicioImg, yychar, yyline, yytext());}



"IMAGEN_FIN"        {return new Symbol(sym.FinImg, yychar, yyline, yytext());}

"CUERPO_FIN"        {return new Symbol(sym.FinBody, yychar, yyline, yytext());}

"FIN_HTML"          {return new Symbol(sym.FinHtml, yychar, yyline, yytext());}

 ( "www" "." {L}+ "." {L}+ ) | 
 ( "www" "." {L}+ "." {L}+ "/" {L}+ "." {L}+ )  {return new Symbol(sym.URL, yychar, yyline, yytext());}

{CORREO}            {return new Symbol(sym.Correo, yychar, yyline, yytext());}


{L}+ | {L}+ " "*    {return new Symbol(sym.Texto, yychar, yyline, yytext());}


{TEXTO_GENERAL}     {return new Symbol(sym.TextoGeneral, yychar, yyline, yytext());}



 .                  {return new Symbol(sym.Error, yychar, yyline, yytext());}
