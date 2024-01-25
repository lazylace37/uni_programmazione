#lang scheme

(define factorization
  (lambda (n)
    (factorization-rec n 2 null null 0)
    ))

(define factorization-rec
  (lambda (n f factors exponents cnt)
    ;; (displayln (list n f factors exponents cnt))
    (cond
      ((= n 1) (list (reverse (cons f factors)) (reverse (cons cnt exponents))))
      ((= (remainder n f) 0)
       (factorization-rec (/ n f) f factors exponents (+ cnt 1))
       )
      ((= cnt 0)
       (factorization-rec n (+ f 1) factors exponents 0)
       )
      (else
       (factorization-rec n (+ f 1) (cons f factors) (cons cnt exponents) 0)
       )
      )
    ))

(factorization 5) ; ((5) (1))
(factorization 8) ; ((2) (3))
(factorization 20) ; ((2 5) (2 1))
(factorization 36) ; ((2 3) (2 2))
(factorization 180) ; ((2 3 5) (2 2 1))
(factorization 550) ; ((2 5 11) (1 2 1))
