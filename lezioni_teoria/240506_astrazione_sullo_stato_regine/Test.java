public class Test {
  public static int numSoluzioni(int n) {
    return numCompletamenti(new Board(n));
  }

  public static int numCompletamenti(Board b) {
    int n = b.size();
    int q = b.queensOn();
    if (q == n) {
      return 1;
    } else {
      int i = q + 1;
      int count = 0;
      for (int j = 1; j <= n; j++) {
        if (!b.underAttack(i, j)) {
          b.addQueen(i, j);
          count += numCompletamenti(b);
          b.removeQueen(i, j);
        }
      }
      return count;
    }
  }

  public static SList<String> listaSoluzioni(int n) {
    return listaCompletamenti(new Board(n));
  }

  public static SList<String> listaCompletamenti(Board b) {
    int n = b.size();
    int q = b.queensOn();
    if (q == n) {
      return NULL_STRLIST.cons("" + b);
    } else {
      int i = q + 1;
      SList<String> list = NULL_STRLIST;
      for (int j = 1; j <= n; j++) {
        if (!b.underAttack(i, j)) {
          b.addQueen(i, j);
          list = list.append(listaCompletamenti(b));
          b.removeQueen(i, j);
        }
      }
      return list;
    }
  }

  private static final SList<String> NULL_STRLIST = new SList<String>();

  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);
    System.out.println(numSoluzioni(n));
    System.out.println(listaSoluzioni(n));
  }
}
