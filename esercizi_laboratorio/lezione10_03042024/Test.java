public class Test {
  public static StringSList btrRange(String btr, int n) {
    StringSList btrList = new StringSList(btr, StringSList.NULL_STRINGLIST);

    for (int i = 1; i < n; i++) {
      String nextBtr = BtrSucc.btrSucc(btrList.car());
      btrList = btrList.cons(nextBtr);
    }

    return btrList.reverse();
  }

  public static void main(String[] args) {
    System.out.println(btrRange("+-", 5));

    StringSList btrs = btrRange("-", 7);
    System.out.println(btrs);

    // Ho creato una lista da 0 (in btr) fino a `n` (in btr) e poi di nuovo a 0 (in btr).
    System.out.println(btrs.append(btrs.reverse().cdr()));

    // Continuo a generare altri `n` numeri btr successivi all'ultimo generato.
    System.out.println(
        btrs.append(btrRange(BtrSucc.btrSucc(btrs.listRef(btrs.length() - 1)), btrs.length())));
  }
}
