#lang scheme

(define mul
  (lambda (m n)
    (mul-tr m n 0)
    ))

(define mul-tr
  (lambda (m n p)
    (cond
      ((= n 0) p)
      (((even?) n) (mul-tr (* 2 m) (quotient n 2) p))
      (else (mul-tr (* 2 m) (quotient n 2) (+ m p)))
      )
    ))

