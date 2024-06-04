public class Test {
  public static int mul(int m, int n) {
    int x = m, y = n;
    int z = 0;

    while (y > 0) {
      if (y % 2 == 1) {
        z += x;
      }
      x *= 2;
      y /= 2;
    }
    return z;
  }

  public static int sqr(int n) { // Pre: n naturale (n intero, n >=0)
    int x = 0;
    int y = 0;
    int z = 1;

    while (x != n) {
      //	while ( x < n ) {
      x = x + 1;
      y = y + z;
      z = z + 2;
    }
    return y;
  } // Post y = n^2

  /** Minimo comune multiplo */
  public static int lcm(int m, int n) { // Pre:  m, n > 0
    int x = m;
    int y = n;

    while (x != y) {
      if (x < y) {
        x = x + m;
      } else {
        y = y + n;
      }
    }
    return x; // Post:  x = mcm(m,n)
  }

  public static int[] fattorizzazione(int n) { // Pre:  n >= 2
    int f[] = new int[n + 1];
    for (int i = 0; i <= n; i = i + 1) {
      f[i] = 0;
    }

    int x = n;
    int p = 2;
    while (x > 1) {
      if ((x % p) == 0) {
        f[p] = f[p] + 1;
        x = x / p;
      } else {
        p = p + 1;
      }
    }

    return f;
  } // Post:  f rappresenta una fattorizzazione di n; n = \Pi_{k=2}^{n} k^{f[k]}

  public static void main(String[] args) {
    double r = mul(13, 83);
    System.out.println(r);
  }
}
