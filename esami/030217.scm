#lang scheme

(define btr-val-tail
  (lambda (s)
    (btr-val-tail-rec s 0)
    ))

(define btr-val-tail-rec
  (lambda (s acc)
    (if (string=? s "")
        acc
        (btr-val-tail-rec
         (substring s 1)
         (+ (* 3 acc) (btd-val (string-ref s 0)))
         )
        )
    ))

(define btd-val
  (lambda (t)
    (cond ((char=? t #\-) -1)
          ((char=? t #\.) 0)
          ((char=? t #\+) +1)
          )
    ))

(btr-val-tail "-+-+.")
