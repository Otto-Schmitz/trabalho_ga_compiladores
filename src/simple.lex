%%

%class JavaLexer
%type Token
%line
%column
%state STR

%{
    StringBuffer string = new StringBuffer();
    private int strStartLine, strStartCol;

    private Token createToken(String tipo, String valor) {
        return new Token(tipo, valor, yyline + 1, yycolumn + 1);
    }
%}

// Macros
IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]*
NUMBER = [0-9]+(\.[0-9]+)?
WHITESPACE = [ \t\r\n]+

OPERATOR = [\+|\-|\*|\/|%|\+\+|\-\-|\+=|\-=|\*=|/=|%=|&|\||\^|~|<<|>>|&=|\|=|\^=|<<=|>>=]
COMPARISON = [==|!=|<=|>=|<|>]
ASSIGNMENT = [=]
DELIMITER = [(){}\\;,]

%%

<YYINITIAL>{
    // Palavras-chave
    "if"            { return createToken("KEYWORD", yytext()); }
    "else"          { return createToken("KEYWORD", yytext()); }
    "while"         { return createToken("KEYWORD", yytext()); }
    "for"           { return createToken("KEYWORD", yytext()); }
    "return"        { return createToken("KEYWORD", yytext()); }
    "public"        { return createToken("KEYWORD", yytext()); }
    "class"         { return createToken("KEYWORD", yytext()); }
    "void"          { return createToken("KEYWORD", yytext()); }
    "int"           { return createToken("TYPE", yytext()); }
    "float"         { return createToken("TYPE", yytext()); }
    "String"        { return createToken("TYPE", yytext()); }
    "char"          { return createToken("TYPE", yytext()); }

    // Operadores e comparação
    {OPERATOR}      { return createToken("OPERATOR", yytext()); }
    {COMPARISON}    { return createToken("COMPARISON", yytext()); }
    {ASSIGNMENT}    { return createToken("ASSIGNMENT", yytext()); }

    // Delimitadores
    {DELIMITER}     { return createToken("DELIMITER", yytext()); }

    // Tokens
    {IDENTIFIER}    { return createToken("IDENTIFIER", yytext()); }
    {NUMBER}        { return createToken("NUMBER", yytext()); }

    // Ignorar espaços em branco
    {WHITESPACE}    { /* ignorar */ }

    // Strings
    \"              { string.setLength(0); yybegin(STR); strStartLine = yyline + 1;  strStartCol  = yycolumn + 1; }

    // Char literal (corrigido para aceitar '\\')
    \'([^\\'\n]|\\[nrt\"\'\\])\'  { return createToken("CHAR", yytext().substring(1, yytext().length()-1)); }
}

<STR>{
    \"              { yybegin(YYINITIAL); return createToken("STRING", string.toString()); }
    [^\n\r\"\\]+    { string.append( yytext() ); }
    \\t             { string.append('\t'); }
    \\n             { string.append('\n'); }
    \\r             { string.append('\r'); }
    \\\"            { string.append('\"'); }
    \\\\            { string.append('\\'); }
    \r\n|\n|\r      { yybegin(YYINITIAL); return createToken("ERROR","Unterminated string starting at " + strStartLine + ":" + strStartCol); }
    \\[^\"nrt\\u]   { yybegin(YYINITIAL); return createToken("ERROR", "Invalid escape in string: " + yytext() + " at " + strStartLine + ":" + strStartCol); }
}

// Caracteres não reconhecidos
.               { return createToken("ERROR", yytext()); }

<<EOF>> {
  if (yystate() == STR) {
    yybegin(YYINITIAL);
    return createToken("ERROR",
      "Unterminated string at EOF (started at " + strStartLine + ":" + strStartCol + ")");
  }
  return null;
}
