#lang scheme

;; Algoritmo del "contadino russo" per la moltiplicazione.
;;
;; 4.1. A proposito della procedura "mul"...
;;
;;      - La procedura "mul" e' una variante della tecnica di calcolo
;;        del prodotto nota come "moltiplicazione del contadino russo";
;;
;;      - La definizione di "mul" al punto 1.1 in realta'
;;        non va molto bene per fare i conti a mente: basta provare!
;;
;; 4.2. Il "vero" algoritmo del contadino russo puo' essere modellato
;;      da ricorsioni di coda e consente il calcolo "ricordando" solo
;;      tre dati (parametri m, n, p) da un passo a quello successivo:
;;
;;        (define mul              ; valore: intero
;;          (lambda (m n)          ; m, n: interi non negativi
;;            (mul-rec m n 0)
;;            ))
;;
;;        (define mul-rec          ; valore: intero
;;          (lambda (m n p)        ; m, n, p: interi non negativi
;;            (cond ((= n 0)   p)
;;                  ((even? n) (mul-rec (* 2 m) (quotient n 2) p))
;;                  (else      (mul-rec (* 2 m) (quotient n 2) (+ p m)))
;;                  )))
;;
;; 4.3. L'ordine delle operazioni e' in realta' diverso, rispetto alla
;;      versione precedente, ma il risultato  e' corretto in virtu'
;;      delle proprieta' associativa e commutativa della somma...
;;
;; 4.4. Esempio di trasformazione da ricorsione a iterazione:
;;      moltiplicazione del contadino russo.

;; (define mul      ; val: intero
;;   (lambda (m n)  ; m, n: interi non negativi
;;     (cond ((= n 0) 0)
;;           ((even? n) (mul (* 2 m) (quotient n 2)))
;;           (else ; n dispari
;;            (+ m (mul (* 2 m) (quotient n 2)))
;;            )
;;           )
;;     ))

(define mul      ; val: intero
  (lambda (m n)  ; m, n: interi non negativi
    (mul-rec m n 0)
    ))

(define mul-rec    ; val: intero
  (lambda (m n p)  ; m, n, p: interi non negativi
    (cond ((= n 0) p)
          ((even? n) (mul-rec (* 2 m) (quotient n 2) p))
          (else ; n dispari
           (mul-rec (* 2 m) (quotient n 2) (+ m p))
           )
          )
    ))

(mul 4 5)

;; 2. Note a margine - logica di "gcd":
;;    Algoritmo di Euclide per il Massimo Comun Divisore (MCD).
;;
;;    - Euclide risolve il problema formulandolo e giustificandolo
;;      in termini geometrici: Elementi, VII libro, circa 300 a.C.
;;      (vedi appunti nelle pagine del corso);
;;
;;    - Tecnica di calcolo probabilmente gia' nota nel V sec. a.C.
;;
;;    - Proprieta' catturate dalla definizione ricorsiva:
;;
;;        MCD( x, x ) = x
;;        MCD( x, y ) = MCD( x, y-x )      se x < y
;;        MCD( x, y ) = MCD( x-y, y )      se x > y
;;
;;      oppure in termini di resto della divisione
;;      ("ovvero detraggo il minore dal maggiore per fino a tanto che posso",
;;      traduzione degli Elementi dovuta a Tartaglia, XVI secolo):
;;
;;        MCD( x, y ) = y                  se x mod y = 0
;;        MCD( x, y ) = MCD( y, x mod y )  altrimenti
;;
;;      [ x mod y : resto della divisione intera di x per y ]
(define mcd      ; val: intero
  (lambda (x y)  ; x, y: interi positivi
    (cond ((= x y) x)
          ((< x y) (mcd x (- y x)))
          (else (mcd (- x y) y))
          )
    ))

