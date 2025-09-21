import java.io.*;

public class LexerTest {
    public static void main(String[] args) {
        try {
            String input = "int x = 10;\nif (x > 5) {\n    x = x + 1;\n}";
            JavaLexer lexer = new JavaLexer(new StringReader(input));
            
            System.out.println("Análise léxica do código:");
            System.out.println(input);
            System.out.println("\nTokens encontrados:");
            
            Token token;
            while ((token = lexer.yylex()) != null) {
                System.out.println(token);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}