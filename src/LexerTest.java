import java.io.FileReader;
import java.io.BufferedReader;
import java.io.StringReader;

public class LexerTest {
    public static void main(String[] args) throws Exception {

        // Lê o conteúdo de TestLexer.java
        BufferedReader reader = new BufferedReader(new FileReader("src/TestLexer.java"));
        StringBuilder builder = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) { // le ate o EOF
            builder.append(line).append("\n"); // adiciona todas as linha no builder
        }
        reader.close();

        // Cria o analisador léxico e executa
        JavaLexer lexer = new JavaLexer(new StringReader(builder.toString()));
        lexer.yylex();
    }
}
