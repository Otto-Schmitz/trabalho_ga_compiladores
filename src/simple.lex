%%

%class JavaLexer
%type Token
%line
%column
%state STR

%{
    StringBuffer string = new StringBuffer();

    private Token createToken(String tipo, String valor) {
        return new Token(tipo, valor, yyline + 1, yycolumn + 1);
    }
%}

// Definições de padrões
IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]*
NUMBER = [0-9]+
WHITESPACE = [ \t\r\n]+


%%

<YYINITIAL>{
    // Palavras-chave
    "if"            { return createToken("KEYWORD", yytext()); }
    "else"          { return createToken("KEYWORD", yytext()); }
    "while"         { return createToken("KEYWORD", yytext()); }
    "for"           { return createToken("KEYWORD", yytext()); }
    "return"        { return createToken("KEYWORD", yytext()); }
    "int"           { return createToken("TYPE", yytext()); }
    "float"         { return createToken("TYPE", yytext()); }
    "String"        { return createToken("TYPE", yytext()); }
    "char"          { return createToken("TYPE", yytext()); }

    // Operadores
    "+"             { return createToken("OPERATOR", yytext()); }
    "-"             { return createToken("OPERATOR", yytext()); }
    "*"             { return createToken("OPERATOR", yytext()); }
    "/"             { return createToken("OPERATOR", yytext()); }
    "="             { return createToken("ASSIGNMENT", yytext()); }
    "=="            { return createToken("COMPARISON", yytext()); }
    "!="            { return createToken("COMPARISON", yytext()); }
    "!"             { return createToken("COMPARISON", yytext()); }
    "%"             { return createToken("COMPARISON", yytext()); }
    "<"             { return createToken("COMPARISON", yytext()); }
    ">"             { return createToken("COMPARISON", yytext()); }
    "%"             { return createToken("OPERATOR", yytext()); }
    "&"             { return createToken("OPERATOR", yytext()); }
    "|"             { return createToken("OPERATOR", yytext()); }
    "^"             { return createToken("OPERATOR", yytext()); }
    "~"             { return createToken("OPERATOR", yytext()); }
    "<<"            { return createToken("OPERATOR", yytext()); }
    ">>"            { return createToken("OPERATOR", yytext()); }
    "++"            { return createToken("OPERATOR", yytext()); }
    "--"            { return createToken("OPERATOR", yytext()); }
    "+="            { return createToken("OPERATOR", yytext()); }
    "-="            { return createToken("OPERATOR", yytext()); }
    "*="            { return createToken("OPERATOR", yytext()); }
    "/="            { return createToken("OPERATOR", yytext()); }
    "%="            { return createToken("OPERATOR", yytext()); }
    "&="            { return createToken("OPERATOR", yytext()); }
    "|="            { return createToken("OPERATOR", yytext()); }
    "^="            { return createToken("OPERATOR", yytext()); }
    "<<="           { return createToken("OPERATOR", yytext()); }
    ">>="           { return createToken("OPERATOR", yytext()); }
    "<="            { return createToken("COMPARISON", yytext()); }
    ">="            { return createToken("COMPARISON", yytext()); }



    // Delimitadores
    "("             { return createToken("DELIMITER", yytext()); }
    ")"             { return createToken("DELIMITER", yytext()); }
    "{"             { return createToken("DELIMITER", yytext()); }
    "}"             { return createToken("DELIMITER", yytext()); }
    ";"             { return createToken("DELIMITER", yytext()); }
    ","             { return createToken("DELIMITER", yytext()); }


    // Tokens
    {IDENTIFIER}    { return createToken("IDENTIFIER", yytext()); }
    {NUMBER}        { return createToken("NUMBER", yytext()); }

    // Ignorar espaços em branco
    {WHITESPACE}    { /* ignorar */ }

    \"              {string.setLength(0); yybegin(STR);}
    \'([^\\'\n]|\\[nrt\"\\])\'  {return createToken("CHAR", yytext().substring(1, yytext().length()-1));}

}

<STR>{
    \" { yybegin(YYINITIAL); return createToken("STRING", string.toString()); }
    [^\n\r\"\\]+ { string.append( yytext() ); }
    \\t { string.append('\t'); }
    \\n { string.append('\n'); }
    \\r { string.append('\r'); }
    \\\" { string.append('\"'); }
    \\ { string.append('\\'); }
}



// Caracteres não reconhecidos
.               { return createToken("ERROR", yytext()); }

<<EOF>>         { return null; }