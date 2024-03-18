public class Btr {
  // (define btr-val                                               ; valore: intero
  //   (lambda (btr)                                               ; btr: stringa non vuota di -/./+
  //     (let ((k (- (string-length btr) 1))
  //           )
  //       (let ((pre (substring btr 0 k))                         ; pre = prefix
  //             (lsd (string-ref btr k))                          ; lsd = least significant digit
  //             )                                                 ; per facilitare la leggibilita'
  //         (if (= k 0)
  //             (btd-val lsd)
  //             (+ (* 3 (btr-val pre)) (btd-val lsd))
  //             )))
  //     ))
  //
  // (define btd-val                                               ; valore: [-1, 0, 1]
  //   (lambda (btd)                                               ; d: carattere -/./+
  //     (cond ((char=? btd #\-) -1)
  //           ((char=? btd #\.)  0)
  //           ((char=? btd #\+) +1)
  //           )
  //     ))

  public static int btrVal(String btr) {
    int k = btr.length();
    int v = 0;

    for (int i = 0; i < k; i++) {
      v = 3 * v + btdVal(btr.charAt(i));
    }

    return v;
  }

  public static int btdVal(char c) {
    switch (c) {
      case '-':
        return -1;
      case '.':
        return 0;
      case '+':
        return 1;
      default:
        return 0;
    }
  }
}
