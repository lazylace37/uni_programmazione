public class Test {
  // Memoization (15 Luglio 2014)
  private static final int UNKNOWN = -1;

  public static int llcs3(String t, String u, String v, int[][][] mem) {
    if (mem[t.length()][u.length()][v.length()] == UNKNOWN) {
      if (t.length() == 0 || u.length() == 0 || v.length() == 0) {
        mem[t.length()][u.length()][v.length()] = 0;
      } else if (t.charAt(0) == u.charAt(0) && u.charAt(0) == v.charAt(0)) {
        int a = 1 + llcs3(t.substring(1), u.substring(1), v.substring(1), mem);
        mem[t.length()][u.length()][v.length()] = a;
      } else {
        int m = Math.max(llcs3(t.substring(1), u, v, mem), llcs3(t, u.substring(1), v, mem));
        m = Math.max(m, llcs3(t, u, v.substring(1), mem));
        mem[t.length()][u.length()][v.length()] = m;
      }
    }
    return mem[t.length()][u.length()][v.length()];
  }

  // Programmazione in Java (15 Luglio 2014)
  // public static boolean isSymmetric(int[][] matrix) {
  //  int n = matrix.length;
  //  for (int i = 0; i < n; i++) {
  //    if (matrix[i][i] != 0) return false;
  //  }
  //  for (int i = 1; i < n; i++) {
  //    for (int j = 0; j < i; j++) {
  //      if (matrix[i][j] != matrix[j][i]) return false;
  //    }
  //  }
  //  return true;
  // }

  // Oggetti in Java (9 Settembre 2015)
  // public static void addQueen(String pos) {
  //  char col = pos.charAt(0);
  //  int row = (int) pos.charAt(1);
  //
  //  int colNumber = -1;
  //  String cols = " abcdefghijklmno";
  //  for (int i = 0; i < cols.length(); i++) {
  //    if (cols[i] == col) {
  //      colNumber = i;
  //      break;
  //    }
  //  }
  //  return new Board(this, row, colNumber);
  // }

  // Ricorsione e iterazione (4 Luglio 2016)
  // public static int shortestCodeLength(Node root) {
  //  int sc = Integer.MAX_VALUE;
  //  Stack<Node> stack = new Stack<Node>();
  //  Stack<Integer> depth = new Stack<Integer>();
  //  stack.push(root);
  //  depth.push(0);
  //  do {
  //    Node n = stack.pop();
  //    int d = depth.pop();
  //    if (n.isLeaf()) {
  //      sc = Math.min(sc, d);
  //    } else if (d + 1 < sc) {
  //      stack.push(n.left());
  //      depth.push(d + 1);
  //      stack.push(n.right());
  //      depth.push(d + 1);
  //    }
  //  } while (!stack.empty());
  //  return sc;
  // }

  // Programmazione in Java (24 Settembre 2019)
  // private static int commonStretches(String u, String v) {
  //  int c = 0;
  //
  //  int u0 = 0;
  //  int u1 = 0;
  //  int v0 = 0;
  //  int v1 = 0;
  //
  //  for (int i = 0; i < u.length(); i++) {
  //    char cu = u.charAt(i);
  //    char cv = v.charAt(i);
  //
  //    if (cu == cv && u0 == v0) {
  //      c++;
  //    }
  //
  //    if (cu == '0') u0++;
  //    if (cv == '0') v0++;
  //  }
  //
  //  return c;
  // }

  // Ricorsione e iterazione (20 Giugno 2022)
  // public class Frame {
  //  public final Node node;
  //  public final int depth;
  //
  //  public Frame(Node n, int d) {
  //    this.node = n;
  //    this.depth = d;
  //  }
  // } // class Frame

  // public static int codeSizeIter(Node root) {
  //  long bits = 0;
  //  Stack<Frame> stack = new Stack<Frame>();
  //  stack.push(new Frame(root, 0));
  //  do {
  //    Frame current = stack.pop();
  //    Node n = current.node;
  //    int depth = current.depth;
  //
  //    if (node.isLeaf()) {
  //      bits += depth * node.weight();
  //    } else {
  //      stack.push(new Frame(n.left(), depth + 1));
  //      stack.push(new Frame(n.right(), depth + 1));
  //    }
  //
  //  } while (!stack.empty());
  //  return (int) (bits / 7) + ((bits % 7 > 0) ? 1 : 0);
  // }

  // Programmazione in Java (20 Giugno 2022)
  private static boolean heapCheck(double[] arr) {
    for (int i = 1; i < arr.length - 1; i++) {
      for (int j = i + 1; j < arr.length; j++) {
        if (j == 2 * i || j == 2 * i + 1) {
          if (arr[i] > arr[j]) return false;
        }
      }
    }
    return true;
  }

  // Programmazione dinamica (16 Settembre 2022)
  public static String lpsDP(String s) {
    int n = s.length();
    String[][] mem = new String[n + 1][n + 1];
    for (int k = 0; k <= n; k = k + 1) {
      for (int i = 0; i <= n - k; i = i + 1) {
        // k : lunghezza della sottostringa s* di s considerata;
        // i : posizione di s* in s:
        // s* corrisponde al potenziale argomento di una invocazione ricorsiva di lps.
        if (k < 2) {
          mem[i][i + k] = s.substring(i, i + k);
        } else if (s.charAt(i) == s.charAt(i + k - 1)) {
          mem[i][i + k] = s.charAt(i) + mem[i + 1][i + k - 1] + s.charAt(i + k - 1);
        } else {
          mem[i][i + k] = longer(mem[i][i + k - 1], mem[i + 1][i + k]);
        }
      }
    }
    return mem[0][n];
  }

  private static String longer(String a, String b) {
    return a.length() > b.length() ? a : b;
  }

  public static void main(String[] args) {
    // {
    //  String t = "ABCBDAB";
    //  String u = "BDCABA";
    //  String v = "BDCABA";
    //  int[][][] mem = new int[t.length() + 1][u.length() + 1][v.length() + 1];
    //  for (int i = 0; i < t.length() + 1; i++) {
    //    for (int j = 0; j < u.length() + 1; j++) {
    //      for (int k = 0; k < v.length() + 1; k++) {
    //        mem[i][j][k] = UNKNOWN;
    //      }
    //    }
    //  }
    //  int l = llcs3(t, u, v, mem);
    //  System.out.println("llcs3: " + l);
    // }
    //
    // {
    //  int c = commonStretches("1010110110", "1100011101"); // → 3 // m = 4, n = 6
    //  System.out.println(c);
    //  assert c == 3;
    // }

    {
      assert heapCheck(new double[] {5.0, 3.1, 5.7, 3.1, 8.5, 6.0, 3.8, 4.2, 9.3}) == true;
      assert heapCheck(new double[] {5.0, 3.1, 5.7, 3.1, 8.5, 6.0, 3.0, 4.2, 9.3}) == false;
    }

    {
      System.out.println(lpsDP("irradiare"));
    }
  }
}
