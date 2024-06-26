#lang scheme

;; Parte 1

(define alfabeto-latino "ABCDEFHIKLMNOPQRSTVX")
(define alfabeto-latino-length 20)
(define position-in-string
  (lambda (s c)
    (cond
      ((string=? s "") 0)
      ((char=? (string-ref s 0) c) 0)
      (else (+ 1 (position-in-string (substring s 1) c)))
      )
    ))

(define crittazione
  (lambda (s f)
    (if (string=? s "")
        ""
        (string-append (string (f (string-ref s 0))) (crittazione (substring s 1) f))
        )
    ))

(define cesare-crypt-func
  (lambda (n)
    (lambda (c)
      (let
          ((char-pos (position-in-string alfabeto-latino c)))
        (if (< (+ char-pos n) alfabeto-latino-length)
            (string-ref alfabeto-latino (+ char-pos n))
            (string-ref alfabeto-latino (- (+ char-pos n) alfabeto-latino-length))
            )
        )
      )
    ))

(crittazione "STVX" (cesare-crypt-func 2))

;; Parte 2

(define H
  (lambda (f g)
    (lambda (m n)
      (if (= n 0)
          (f m)
          (g m ((H f g) m (- n 1)))
          )
      )
    ))

(define succ (lambda (_ v) (+ v 1)))
(define add (H (lambda (x) x) succ))
(define mul (H (lambda (_) 0) add))
(define pow (H (lambda (_) 1) mul))

(add 19 0)
(add 19 1)
(add 19 10)

(mul 19 0)
(mul 19 1)
(mul 19 2)
(mul 19 10)

(pow 19 0)
(pow 19 1)
(pow 2 2)
