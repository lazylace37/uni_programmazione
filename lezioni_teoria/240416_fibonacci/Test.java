public class Test {

  /**
   * R(n) >= (3/2)^(n-1)
   *
   * <p>Supp. 1 ricorsione: 1 nsec
   *
   * <p>R(100) >= (3/2)^99 = 2.7 * 10^17 nsec = 8.5 anni
   *
   * <p>per n = 0, 1 = R(0) >= (3/2)^(-1) = 2/3
   *
   * <p>per n = 1, 1 = R(1) >= (3/2)^0 = 1
   *
   * <p>per n >= 2, R(n) = 1 + R(n-2) + R(n-1) > (3/2)^(n-3) + (3/2)^(n-2) = (3/2)^(n-2) [2/3 + 1] =
   * (3/2)^(n-2) 5/3 > (3/2)^(n-2) 3/2 = (3/2)^(n-1)
   */
  public static int fib(int n) { // n >= 0
    if (n < 2) {
      return 1;
    } else {
      return fib(n - 2) + fib(n - 1);
    }
  }

  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);
    int r = fib(n);
    System.out.println(r);
  }
}
