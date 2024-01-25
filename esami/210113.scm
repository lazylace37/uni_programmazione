#lang scheme

(define xtessellations
  (lambda (n k)
    (cond
      ((= k 0) 1)
      ((= n 1) 1)
      ((= n 2) 2)
      (else (+ (xtessellations (- n 1) k)
               (xtessellations (- n 2) (- k 1))
               )
            )
      )
    ))

(xtessellations 5 0) ; 1
(xtessellations 5 1) ; 5
(xtessellations 5 2) ; 8
(xtessellations 5 3) ; 8
(xtessellations 7 1) ; 7
(xtessellations 7 2) ; 17

