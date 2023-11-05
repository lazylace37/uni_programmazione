#lang scheme

;; Tassellazione di un cordolo di lunghezza n e altezza 1

; - A. Utilizzando piastrelle 2x1 e 1x1;
(define tassellaz-giallo  ; val: intero
  (lambda(n)              ; n > 0 intero
    (cond
      ((= n 1) 1)
      ((= n 2) 2)
      (else ; n > 2
       (+
        (tassellaz-giallo (- n 1))
        (tassellaz-giallo (- n 2))
        )
       )
      )
    ))

(tassellaz-giallo 3)
(tassellaz-giallo 12)
(tassellaz-giallo 13)

; B. Utilizzando piastrelle 1x1 di colore rosso e blu, con l'ulteriore
;    vincolo che le piastrelle rosse non possono essere adiacenti;
(define tassellaz-blu-rosso  ; val: intero
  (lambda(n)                 ; n > 0 intero
    (cond
      ((= n 1) 2)
      ((= n 2) 3)
      (else ; n > 2
       (+
        (tassellaz-blu-rosso (- n 1))
        (tassellaz-blu-rosso (- n 2))
        )
       )
      )
    ))

(tassellaz-blu-rosso 3)
(tassellaz-blu-rosso 11)
(tassellaz-blu-rosso 12)

