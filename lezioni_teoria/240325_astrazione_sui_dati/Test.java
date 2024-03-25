import AstrazioneSuiDati.IntSList;

public class Test {
  public static IntSList intervallo(int inf, int sup) {
    if (inf > sup) return new IntSList();
    return intervallo(inf + 1, sup).cons(inf);
  }

  public static void main(String[] args) {
    IntSList s = intervallo(1, 10);
    System.out.println("Ecco la lista:");
    System.out.println(s);
  }
}
