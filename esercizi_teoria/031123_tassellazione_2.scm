#lang scheme

;; - tassellazione di un cordolo con tre tipi di piastrelle: 1x1,
;;   2x1 e 3x1 -- in quanti modi diversi? (attenzione ai casi base!)

(define tassellazione
  (lambda (l)
    (cond
      ((= l 3) 4)
      ((= l 2) 2)
      ((= l 1) 1)
      (else (+ (tassellazione (- l 1)) (tassellazione (- l 2)) (tassellazione (- l 3))))
      )
    )
  )

(tassellazione 2)
(tassellazione 3)
(tassellazione 4)
(tassellazione 5)
(tassellazione 6)
(tassellazione 7)
(tassellazione 8)
(tassellazione 9)
(tassellazione 10)

