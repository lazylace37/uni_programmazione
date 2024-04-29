public class Lcs {
  public static String lcs(String u, String v) {
    int m = u.length();
    int n = v.length();

    if (m == 0 || n == 0) {
      return "";
    } else if (u.charAt(0) == v.charAt(0)) {
      return u.charAt(0) + lcs(u.substring(1), v.substring(1));
    } else {
      return longer(lcs(u.substring(1), v), lcs(u, v.substring(1)));
    }
  }

  private static String longer(String u, String v) {
    int m = u.length();
    int n = v.length();

    if (m < n) {
      return v;
    } else if (m > n) {
      return u;
    } else if (Math.random() < 0.5) {
      return v;
    } else {
      return u;
    }
  }

  // Memoization (Top-down) solution
  public static String lcsMem(String u, String v) {
    int m = u.length();
    int n = v.length();
    String[][] h = new String[m + 1][n + 1];
    for (int x = 0; x < m + 1; x++) {
      for (int y = 0; y < n + 1; y++) {
        h[x][y] = null;
      }
    }
    return lcsRec(u, v, h);
  }

  private static String lcsRec(String u, String v, String[][] h) {
    int i = u.length();
    int j = v.length();

    if (h[i][j] == null) {
      if (i == 0 || j == 0) {
        h[i][j] = "";
      } else if (u.charAt(0) == v.charAt(0)) {
        h[i][j] = u.charAt(0) + lcsRec(u.substring(1), v.substring(1), h);
      } else {
        h[i][j] = longer(lcsRec(u.substring(1), v, h), lcsRec(u, v.substring(1), h));
      }
    }

    return h[i][j];
  }

  // Bottom-up solution
  public static String lcsBottomUp(String u, String v) {
    int i = u.length();
    int j = v.length();

    String[][] h = new String[i + 1][j + 1];
    for (int y = 0; y < j + 1; y++) {
      h[0][y] = "";
    }
    for (int x = 0; x < i + 1; x++) {
      h[x][0] = "";
    }
    for (int x = 1; x < i + 1; x++) {
      for (int y = 1; y < j + 1; y++) {
        if (u.charAt(i - x) == v.charAt(j - y)) {
          h[x][y] = u.charAt(i - x) + h[x - 1][y - 1];
        } else {
          h[x][y] = longer(h[x - 1][y], h[x][y - 1]);
        }
      }
    }
    return h[i][j];
  }

  // Smart bottom-up solution
  public static String lcsDp(String u, String v) {
    int i = u.length();
    int j = v.length();

    int[][] h = new int[i + 1][j + 1];
    for (int y = 0; y < j + 1; y++) {
      h[0][y] = 0;
    }
    for (int x = 0; x < i + 1; x++) {
      h[x][0] = 0;
    }
    for (int x = 1; x < i + 1; x++) {
      for (int y = 1; y < j + 1; y++) {
        if (u.charAt(i - x) == v.charAt(j - y)) {
          h[x][y] = h[x - 1][y - 1] + 1;
        } else {
          h[x][y] = Math.max(h[x - 1][y], h[x][y - 1]);
        }
      }
    }

    String s = "";
    int x = i, y = j;
    while (h[x][y] > 0) {
      if (u.charAt(i - x) == v.charAt(j - y)) {
        s += u.charAt(i - x);
        x--;
        y--;
      } else if (h[x - 1][y] < h[x][y - 1]) {
        y--;
      } else if (h[x - 1][y] > h[x][y - 1]) {
        x--;
      } else if (Math.random() < 0.5) {
        y--;
      } else {
        x--;
      }
    }

    return s;
  }

  public static void main(String[] args) {
    String u = "arto";
    String v = "atrio";

    if (args.length >= 2) {
      u = args[0];
      v = args[1];
    }

    String lcs = lcs(u, v);
    String lcsMem = lcsMem(u, v);
    String lcsBottomUp = lcsBottomUp(u, v);
    String lcsDp = lcsDp(u, v);
    System.out.println("lcs(" + u + ", " + v + ") = " + lcs);
    System.out.println("lcsMem(" + u + ", " + v + ") = " + lcsMem);
    System.out.println("lcsBottomUp(" + u + ", " + v + ") = " + lcsBottomUp);
    System.out.println("lcsDp(" + u + ", " + v + ") = " + lcsDp);
  }
}
