public class BtrSucc {
  public static String btrSucc(String btr) { // btr: stringa di -/./+
    int n = btr.length();
    char lsb = btr.charAt(n - 1);
    if (n == 1) {
      if (lsb == '+') {
        return "+-";
      } else {
        return "+";
      }
    } else {
      String pre = btr.substring(0, n - 1);
      if (lsb == '+') {
        return btrSucc(pre) + "-";
      } else {
        return pre + (lsb == '-' ? "." : "+");
      }
    }
  }

  public static void main(String[] args) {
    assert btrSucc("+").equals("+-");
    assert btrSucc("+-").equals("+.");
    assert btrSucc("+-+-").equals("+-+.");
    assert btrSucc("-+-++").equals("-+.--");
  }
}
