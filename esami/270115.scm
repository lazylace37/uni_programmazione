#lang scheme

;; 3

(define factors->number
  (lambda (primes expts)
    (if (null? primes)
        1
        (* (expt (car primes) (car expts))
           (factors->number (cdr primes) (cdr expts)))
        )
    ))

(factors->number '(5) '(1)) ; 5
(factors->number '(2) '(3)) ; 8
(factors->number '(2 3) '(2 2)) ; 36
(factors->number '(2 5) '(2 1)) ; 20
(factors->number '(2 3 5) '(2 2 1)) ; 180
(factors->number '(2 5 11) '(1 2 1)) ; 550
