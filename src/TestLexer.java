public class TestLexer {

  int x;

  public void verificar() {
    if (x == 10) {
      x = x + 1;
    } else {
      while (x <= 10) {
        x = x + 1;
      }
    }
    if (!true) {}

    x &= 1;

    System.out.println(x);

    // float y = 1.0f;
  }
}
