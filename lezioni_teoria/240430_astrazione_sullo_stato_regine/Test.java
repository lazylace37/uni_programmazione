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
        }
      }
      return count;
    }
  }

  public static SList<Board> listaSoluzioni(int n) {
    return listaCompletamenti(new Board(n));
  }

  public static SList<Board> listaCompletamenti(Board b) {
    int n = b.size();
    int q = b.queensOn();
    if (q == n) {
      return NULL_BOARDLIST.cons(b);
    } else {
      int i = q + 1;
      SList<Board> list = NULL_BOARDLIST;
      for (int j = 1; j <= n; j++) {
        if (!b.underAttack(i, j)) {
          b.addQueen(i, j);
          list = list.append(listaCompletamenti(b));
        }
      }
      return list;
    }
  }

  private static final SList<Board> NULL_BOARDLIST = new SList<Board>();

  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);
    System.out.println(numSoluzioni(n));
    System.out.println(listaSoluzioni(n));
  }
}
