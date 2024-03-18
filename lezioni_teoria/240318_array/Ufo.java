public class Ufo {
  // (define ufo      ; val: intero
  //   (lambda (x)    ; x: intero positivo
  //     (cond ((= x 1) 1)
  //           ((even? x) (- (* 2 (ufo (quotient x 2))) 1))
  //           (else (+ (* 2 (ufo (quotient x 2))) 1))
  //           )
  //     ))

  public static int ufo(int n) { // n > 0
    int[] u = new int[n + 1];

    u[1] = 1;

    for (int x = 2; x <= n; x++) {
      if (x % 2 == 0) {
        u[x] = (2 * u[x / 2]) - 1;
      } else {
        u[x] = (2 * u[x / 2]) + 1;
      }
    }
    return u[n];
  }

  // Soluzione "top-down"
  public static int ufoTopDown(int x) { // x > 0
    int dim = (int) (Math.log(x) / Math.log(2)) + 1;
    int[] s = new int[dim];

    int t = 0; // Prima posizione utile
    while (x > 0) {
      s[t] = x;
      t++;
      x /= 2;
    }

    t -= 1; // Qui c'è 1
    int y = 1; // y = ufo(s[t])
    while (t > 0) {
      t--;
      if (s[t] % 2 == 0) {
        y = 2 * y - 1;
      } else {
        y = 2 * y + 1;
      }
    }

    return y;
  }
}
