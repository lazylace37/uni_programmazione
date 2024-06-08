import java.util.Arrays;

public class Test {
  // 1
  public static DoubleSList lisDP(double[] s) {
    int n = s.length;
    double[] v = s.clone();
    Arrays.sort(v);
    DoubleSList[][] mem = new DoubleSList[n + 1][n + 1];
    for (int k = 0; k <= n; k = k + 1) {
      mem[k][n] = DoubleSList.NULL_LIST;
      mem[n][k] = DoubleSList.NULL_LIST;
    }
    for (int i = n - 1; i >= 0; i--) {
      for (int j = n - 1; j >= 0; j--) {
        if (s[i] == v[j]) {
          mem[i][j] = mem[i + 1][j + 1].cons(s[i]);
        } else {
          mem[i][j] = longer(mem[i + 1][j], mem[i][j + 1]);
        }
      }
    }
    return mem[0][0];
  }

  private static DoubleSList longer(DoubleSList u, DoubleSList v) {
    return ((u.length() < v.length()) ? v : u);
  }

  public static void main(String[] args) {
    DoubleSList r = lisDP(new double[] {9, 4, 5, 6, 7, 0});
    while (!r.isNull()) {
      System.out.print(r.car() + " ");
      r = r.cdr();
    }
    System.out.println();
  }
}

// 2
class DoubleSList {
  public static final DoubleSList NULL_LIST = new DoubleSList();

  private final boolean empty;
  private final double first;
  private final DoubleSList rest;

  public DoubleSList() {
    empty = true;
    first = 0;
    rest = null;
  }

  public DoubleSList(double e, DoubleSList r) {
    empty = false;
    first = e;
    rest = r;
  }

  public boolean isNull() {
    return empty;
  }

  public double car() {
    return first;
  }

  public DoubleSList cdr() {
    return rest;
  }

  public DoubleSList cons(double e) {
    return new DoubleSList(e, this);
  }

  public String toString() {
    if (isNull()) {
      return "()";
    } else {
      String lst = "(" + car();
      DoubleSList r = cdr();
      while (!r.isNull()) {
        lst += " " + r.car();
        r = r.cdr();
      }
      return lst + ")";
    }
  }

  public int length() {
    if (isNull()) return 0;
    return 1 + cdr().length();
  }

  public double listRef(int i) {
    if (i == 0) return car();
    return cdr().listRef(i - 1);
  }

  public boolean equals(DoubleSList s) {
    if (isNull()) {
      return s.isNull();
    } else if (s.isNull()) {
      return false;
    } else if (car() == s.car()) {
      return cdr().equals(s.cdr());
    } else {
      return false;
    }
  }

  public DoubleSList append(DoubleSList s) {
    if (this.isNull()) return s;
    return this.cdr().append(s).cons(car());
  }

  public DoubleSList reverse() {
    return this.reverseRec(new DoubleSList());
  }

  private DoubleSList reverseRec(DoubleSList rev) {
    if (this.isNull()) return rev;
    return this.cdr().reverseRec(rev.cons(this.car()));
  }
}
