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
        if (!b.underAttach(i, j)) {
          count += numCompletamenti(b.addQueen(i, j));
        }
      }
      return count;
    }
  }

  // public static BoardSList listaSoluzioni(int n) {
  //   return listaCompletamenti(new Board(n));
  // }
  //
  // public static BoardSList listaCompletamenti(Board b) {
  //   int n = b.size();
  //   int q = b.queensOn();
  //   if (q == n) {
  //     return BoardSList.NULL_BOARDLIST.cons(b);
  //   } else {
  //     int i = q + 1;
  //     BoardSList list = BoardSList.NULL_BOARDLIST;
  //     for (int j = 1; j <= n; j++) {
  //       if (!b.underAttach(i, j)) {
  //         list.append(numCompletamenti(b.addQueen(i, j)));
  //       }
  //     }
  //     return list;
  //   }
  // }

  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);
  }
}
