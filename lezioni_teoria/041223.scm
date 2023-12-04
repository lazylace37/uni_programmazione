#lang scheme

(define ufo      ; val: intero
  (lambda (x)    ; x: intero non negativo
    (cond ((= x 1) 1)
          ((even? x) (- (* 2 (ufo (quotient x 2))) 1))
          (else (+ (* 2 (ufo (quotient x 2))) 1))
          )
    ))

;; se x = 2^k => ufo(x) = 1
;; ufo(x) è dispari
;; se x = 2^(k+1) - 1 => ufo(x) = 2^(k+1) - 1
;; se n != 2^k => ufo(n) = ufo(n - 1) + 2

;; ufo(n) <= n

