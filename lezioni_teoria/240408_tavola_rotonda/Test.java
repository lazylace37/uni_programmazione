public class Test {
  public static int ultimoCavaliere(int n) {
    TavolaRotonda tr = new TavolaRotonda(n);
    while (tr.quantiCavalieri() > 1) {
      tr = tr.serve().passa();
    }
    return tr.chiHaLaBrocca();
  }

  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);

    int u = 0;
    for (int k = 1; k <= n; k++) {
      u = ultimoCavaliere(k);
    }
    System.out.println("u: " + u);
  }
}
