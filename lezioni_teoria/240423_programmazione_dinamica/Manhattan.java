/** Manhattan - dynamic programming (bottom-up) solution */
public class Manhattan {
  public static long pathsDp(int i, int j) {
    long[][] h = new long[i + 1][j + 1];
    for (int y = 0; y < j + 1; y++) {
      h[0][y] = 1;
    }
    for (int x = 0; x < i + 1; x++) {
      h[x][0] = 1;
    }
    for (int x = 1; x < i + 1; x++) {
      for (int y = 1; y < j + 1; y++) {
        h[x][y] = h[x - 1][y] + h[x][y - 1];
      }
    }
    return h[i][j];
  }

  public static void main(String[] args) {
    int i = Integer.parseInt(args[0]);
    int j = Integer.parseInt(args[1]);

    long t = System.currentTimeMillis();
    long nPaths = pathsDp(i, j);
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
