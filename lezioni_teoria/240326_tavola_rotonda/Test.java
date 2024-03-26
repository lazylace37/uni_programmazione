public class Test {
  public static int ultimoCavaliere(int n) {
    TavolaRotonda tr = new TavolaRotonda(n);
    while (tr.quantiCavalieri() > 1) {
      tr = tr.serve().passa();
    }
    return tr.chiHaLaBrocca();
  }

  public static void main(String[] args) {
    System.out.println(ultimoCavaliere(9));
    System.out.println(ultimoCavaliere(13));
    System.out.println(ultimoCavaliere(23));
  }
}
