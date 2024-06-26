public class LLIS {
  public static int llis(int[] s) { // s[i] > 0 per i in [0,n-1], dove n = s.length
    return llisRec(s, 0, 0);
  }

  private static int llisRec(int[] s, int i, int t) {
    if (i == s.length) { // i = n : coda di s vuota
      return 0;
    } else if (s[i] <= t) { // x = s[i] ≤ t : x non può essere scelto
      return llisRec(s, i + 1, t);
    } else { // x > t : x può essere scelto o meno
      return Math.max(1 + llisRec(s, i + 1, s[i]), llisRec(s, i + 1, t));
    }
  }

  //// Top-down - Memoization, ma gli elementi di s sono in [0, n]
  // public static int llisTopDown(int[] s) { // s[i] > 0 per i in [0,n-1] e s[i] in [0, n]
  //  int n = s.length;
  //  int[][] h = new int[n + 1][n + 1];
  //  for (int i = 0; i < n; i++) {
  //    for (int j = 0; j < n + 1; j++) {
  //      h[i][j] = UNKNOWN;
  //    }
  //  }
  //  return llisTopDownRec(s, 0, 0, h);
  // }
  //
  // private static final int UNKNOWN = -1;
  //
  // private static int llisTopDownRec(int[] s, int i, int t, int[][] h) {
  //  if (h[i][t] == UNKNOWN) {
  //    if (i == s.length) { // i = n : coda di s vuota
  //      h[i][t] = 0;
  //    } else if (s[i] <= t) { // x = s[i] ≤ t : x non può essere scelto
  //      h[i][t] = llisTopDownRec(s, i + 1, t, h);
  //    } else { // x > t : x può essere scelto o meno
  //      h[i][t] = Math.max(1 + llisTopDownRec(s, i + 1, s[i], h), llisTopDownRec(s, i + 1, t, h));
  //    }
  //  }
  //
  //  return h[i][t];
  // }

  // Top-down - Memoization
  public static int llisTopDown(int[] s) { // s[i] > 0 per i in [0,n-1]
    int n = s.length;
    int[][] h = new int[n + 1][n + 1];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n + 1; j++) {
        h[i][j] = UNKNOWN;
      }
    }
    return llisTopDownRec(s, 0, n, h);
  }

  private static final int UNKNOWN = -1;

  private static int llisTopDownRec(int[] s, int i, int j, int[][] h) {
    int t = j < s.length ? s[j] : 0;

    if (h[i][j] == UNKNOWN) {
      if (i == s.length) { // i = n : coda di s vuota
        h[i][j] = 0;
      } else if (s[i] <= t) { // x = s[i] ≤ t : x non può essere scelto
        h[i][j] = llisTopDownRec(s, i + 1, j, h);
      } else { // x > t : x può essere scelto o meno
        h[i][j] = Math.max(1 + llisTopDownRec(s, i + 1, i, h), llisTopDownRec(s, i + 1, j, h));
      }
    }
    return h[i][j];
  }
}
