#lang scheme

;; 3

(define powers-of-two
  (lambda (n)
    (cond
      ((= n 0) '())
      ((= n 1) '(1))
      (else
       (let ((p (find-power n 1)))
         (cons p (powers-of-two (- n p)))
         )
       )
      )
    ))

(define find-power
  (lambda (n p)
    (let ((next-power (* p 2)))
      (cond
        ((= next-power n) next-power)
        ((> next-power n) p)
        (else (find-power n next-power))
        )
      )
    ))

(powers-of-two 0) ; ()
(powers-of-two 1) ; (1)
(powers-of-two 5) ; (4 1)
(powers-of-two 8) ; (8)
(powers-of-two 26) ; (16 8 2)
(powers-of-two 45) ; (32 8 4 1)

;; 4

(define manhattan-var ; val: intero
  (lambda (i j k) ; i, j, k: interi non negativi tali che k ≤ i e k ≤ j
    (let (
          (x (if (= i k) 0 (manhattan-var (- i 1) j k)))
          (y (if (= j k) 0 (manhattan-var i (- j 1) k)))
          (z (if (= k 0) 0 (manhattan-var (- i 1) (- j 1) (- k 1))))
          )
      (if (and (> i 0) (> j 0))
          (+ x y z)
          1
          ))
    ))

(manhattan-var 3 2 0) ; 10
(manhattan-var 3 2 2) ; 3
(manhattan-var 2 2 2) ; 1
