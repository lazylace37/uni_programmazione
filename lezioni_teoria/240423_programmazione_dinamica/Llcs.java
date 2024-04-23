/** Longest common subsequence - Dynamic Programming */
public class Llcs {
  /** Longest common subsequence (recursive) */
  // public static int llcs(String u, String v) {
  //   int m = u.length();
  //   int n = v.length();
  //
  //   if (m == 0 || n == 0) {
  //     return 0;
  //   } else if (u.charAt(0) == v.charAt(0)) {
  //     return 1 + llcs(u.substring(1), v.substring(1));
  //   } else {
  //     return Math.max(llcs(u.substring(1), v), llcs(u, v.substring(1)));
  //   }
  // }

  // Memoization (Top-down) solution
  public static int llcsMem(String u, String v) {
    int m = u.length();
    int n = v.length();
    int[][] h = new int[m + 1][n + 1];
    for (int x = 0; x < m + 1; x++) {
      for (int y = 0; y < n + 1; y++) {
        h[x][y] = UNKNOWN;
      }
    }
    return llcsRec(u, v, h);
  }

  private static int llcsRec(String u, String v, int[][] h) {
    int i = u.length();
    int j = v.length();

    if (h[i][j] == UNKNOWN) {
      if (i == 0 || j == 0) {
        h[i][j] = 0;
      } else if (u.charAt(0) == v.charAt(0)) {
        h[i][j] = 1 + llcsRec(u.substring(1), v.substring(1), h);
      } else {
        h[i][j] = Math.max(llcsRec(u.substring(1), v, h), llcsRec(u, v.substring(1), h));
      }
    }

    return h[i][j];
  }

  // Bottom-up solution
  public static int llcsBottomUp(String u, String v) {
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
        if (u.charAt(0) == v.charAt(0)) {
          h[x][y] = h[x - 1][y - 1] + 1;
        } else {
          h[x][y] = h[x - 1][y] + h[x][y - 1];
        }
      }
    }
    return h[i][j];
  }

  private static final int UNKNOWN = -1;

  public static void main(String[] args) {
    String u = "arto";
    String v = "atrio";

    if (args.length >= 2) {
      u = args[0];
      v = args[1];
    }

    long t = System.currentTimeMillis();
    long nSolutions = llcsMem(u, v);
    System.out.println(
        "llcsMem("
            + u
            + ", "
            + v
            + ") = "
            + nSolutions
            + " in "
            + (System.currentTimeMillis() - t)
            + "ms");
  }
}
