public class Manhattan {
  public static long paths(int i, int j) {
    if (i == 0 || j == 0) {
      return 1;
    } else {
      return paths(i - 1, j) + paths(i, j - 1);
    }
  }

  public static long pathsMem(int i, int j) {
    long[][] h = new long[i + 1][j + 1];
    for (int x = 0; x < i + 1; x++) {
      for (int y = 0; y < j + 1; y++) {
        h[x][y] = UNKNOWN;
      }
    }
    return pathsRec(i, j, h);
  }

  private static long pathsRec(int i, int j, long[][] h) {
    if (h[i][j] == UNKNOWN) {
      if (i == 0 || j == 0) {
        h[i][j] = 1;
      } else {
        h[i][j] = pathsRec(i - 1, j, h) + pathsRec(i, j - 1, h);
      }
    }
    return h[i][j];
  }

  private static final long UNKNOWN = 0;

  public static void main(String[] args) {
    int i = Integer.parseInt(args[0]);
    int j = Integer.parseInt(args[1]);

    // long t = System.currentTimeMillis();
    // long nPaths = paths(i, j);
    // System.out.println(
    //     "paths("
    //         + i
    //         + ", "
    //         + j
    //         + ") = "
    //         + nPaths
    //         + " in "
    //         + (System.currentTimeMillis() - t)
    //         + "ms");

    long t = System.currentTimeMillis();
    long nPaths = pathsMem(i, j);
    System.out.println(
        "paths("
            + i
            + ", "
            + j
            + ") = "
            + nPaths
            + " in "
            + (System.currentTimeMillis() - t)
            + "ms");
  }
}
