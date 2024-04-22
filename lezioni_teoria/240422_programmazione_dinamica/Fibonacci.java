public class Fibonacci {
  public static long fibMem(int n) {
    long[] h = new long[n + 1];
    for (int i = 0; i < n + 1; i++) h[i] = UNKNOWN;
    return fibRec(n, h);
  }

  public static long fibRec(int n, long[] h) {
    if (h[n] == UNKNOWN) {
      if (n < 2) {
        h[n] = 1;
      } else {
        h[n] = fibRec(n - 2, h) + fibRec(n - 1, h);
      }
    }
    return h[n];
  }

  private static final int UNKNOWN = 0;

  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);

    long t = System.currentTimeMillis();
    long res = fibMem(n);
    System.out.println(
        "fib(" + n + ") = " + res + " in " + (System.currentTimeMillis() - t) + "ms");
  }
}
