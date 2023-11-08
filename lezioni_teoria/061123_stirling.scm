#lang scheme

(define st      ; val: intero
  (lambda (n k) ; 1 <= k <= n interi
    (if (or (= k 1) (= k n))
        1
        (+ (st (- n 1) (- k 1)) (* k (st (- n 1) k)))
        )
    ))

(st 6 3)
(st 2 2)
(st 3 2)
(st 4 2)
(st 5 2)
(st 4 3)
(st 5 3)

