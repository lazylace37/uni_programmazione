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

  // // Top-down - Memoization, ma gli elementi di s sono in [0, n]
  // public static int llisTopDown(int[] s) { // s[i] > 0 per i in [0,n-1] e s[i] in [0, n]
  //   int n = s.length;
  //   int[] h = new int[n + 1]; // init to 0
  //   return llisTopDownRec(s, 0, 0, h);
  // }
  //
  // private static int llisTopDownRec(int[] s, int i, int t, int[] h) {
  //   // System.out.println("i: " + i + ", t: " + t + ", h: " + (h));
  //   if (i == s.length) { // i = n : coda di s vuota
  //     return 0;
  //   } else if (s[i] <= t) { // x = s[i] ≤ t : x non può essere scelto
  //     h[s[i]] = llisTopDownRec(s, i + 1, t, h);
  //   } else { // x > t : x può essere scelto o meno
  //     h[s[i]] = Math.max(1 + llisTopDownRec(s, i + 1, s[i], h), llisTopDownRec(s, i + 1, t, h));
  //   }
  //
  //   return h[s[i]];
  // }

  // Top-down - Memoization
  public static int llisTopDown(int[] s) { // s[i] > 0 per i in [0,n-1]
    int n = s.length;
    int[] h = new int[n + 1]; // init to 0
    return llisTopDownRec(s, 0, n, h);
  }

  private static int llisTopDownRec(int[] s, int i, int j, int[] h) {
    int t = j < s.length ? s[j] : 0;

    if (i == s.length) { // i = n : coda di s vuota
      return 0;
    } else if (s[i] <= t) { // x = s[i] ≤ t : x non può essere scelto
      h[j] = llisTopDownRec(s, i + 1, j, h);
    } else { // x > t : x può essere scelto o meno
      h[j] = Math.max(1 + llisTopDownRec(s, i + 1, i, h), llisTopDownRec(s, i + 1, j, h));
    }

    return h[j];
  }
}
