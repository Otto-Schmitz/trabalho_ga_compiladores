import java.io.IOException;

%%

%{
  private void imprimir(String tipo, String lexema) {
    System.out.println(tipo + ": " + lexema);
  }
%}

%class JavaLexer
%type Object
%unicode
%line
%column
%standalone

BRANCO     = [ \t\n\r]+
ID         = [a-zA-Z][a-zA-Z0-9_]*
NUMERO     = 0|[1-9][0-9]*
DECIMAL    = [0-9]+\.[0-9]+
STRING     = \"([^\"\\]|\\.)*\"
OPERADOR   = "=="|"="|"+"|"-"|"*"|"/"|"<"|">"|"%"|"!"|"&"
DELIMITADOR = "{"|"}"|"("|")"|";"|"."|","|"'"|"["|"]"

%%

// Palavras reservadas
"class"   { imprimir("PALAVRA_RESERVADA", yytext()); }
"public"  { imprimir("PALAVRA_RESERVADA", yytext()); }
"int"     { imprimir("PALAVRA_RESERVADA", yytext()); }
"float"   { imprimir("PALAVRA_RESERVADA", yytext()); }
"String"  { imprimir("PALAVRA_RESERVADA", yytext()); }
"void"    { imprimir("PALAVRA_RESERVADA", yytext()); }
"if"      { imprimir("PALAVRA_RESERVADA", yytext()); }
"else"    { imprimir("PALAVRA_RESERVADA", yytext()); }
"while"   { imprimir("PALAVRA_RESERVADA", yytext()); }

// Identificadores e Números
{ID}         { imprimir("IDENTIFICADOR", yytext()); }
{NUMERO}     { imprimir("NUMERO_INT", yytext()); }
{DECIMAL}    { imprimir("NUMERO_FLOAT", yytext()); }
{STRING}     { imprimir("STRING", yytext()); }

// Operadores
{OPERADOR}   { imprimir("OPERADOR", yytext()); }

// Delimitadores
{DELIMITADOR} { imprimir("DELIMITADOR", yytext()); }

// Espaços em branco
{BRANCO}     { /* ignora */ }

// EOF
<<EOF>> { return YYEOF; }

// Caractere inválido
.            { throw new RuntimeException("Caractere inválido: " + yytext()); }
