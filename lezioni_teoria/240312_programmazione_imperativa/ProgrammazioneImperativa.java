public class ProgrammazioneImperativa {

  // (define mcd      ; val: intero
  //   (lambda (x y)  ; x, y: interi positivi
  //     (cond ((= x y) x)
  //           ((< x y) (mcd x (- y x)))
  //           (else (mcd (- x y) y))
  //           )
  //     ))
  public static int mcd(int x, int y) { // x, y > 0
    while (x != y) {
      if (x < y) {
        y = y - x;
      } else {
        x = x - y;
      }
    }
    return x;
  }

  public static int mcm(int x, int y) { // x, y > 0
    int m = x;

    while (m % y > 0) {
      m += x;
    }

    return m;
  }

  // (define primo?   ; val: boolean
  //   (lambda (n)    ; n >= 2 intero
  //     (if (even? n)
  //         (= n 2)
  //         (not (divisori-in? n 3 (sqrt n)))
  //         )
  //     ))
  //
  // (define divisori-in?   ; val: boolean
  //   (lambda (n inf sup)  ; n, inf, sup: interi positivi
  //     (cond
  //       ((> inf sup) false)
  //       ((= (remainder n inf) 0) true)
  //       (else (divisori-in? n (+ inf 2) sup))
  //       )
  //     ))
  public static boolean isPrimo(int n) { // n >= 2
    if (n % 2 == 0) return n == 2;
    else if (n == 3) return true;
    else {
      int k = 3;
      while ((n % k > 0) && (k <= Math.sqrt(n))) {
        k += 2;
      }
      return n % k > 0;
    }
  }

  public static void listaPrimi(int sup) {
    for (int n = 2; n <= sup; n++) {
      if (ProgrammazioneImperativa.isPrimo(n)) {
        System.out.print(" " + n);
      }
    }
    System.out.println();
  }
}
