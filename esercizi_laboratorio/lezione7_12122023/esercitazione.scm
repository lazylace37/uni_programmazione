#lang scheme

;; 1
;; Completa la procedura match che, date due stringhe di lettere u e v, restituisce la stringa delle corrispondenze w così
;; definita: w ha la lunghezza della stringa più corta (fra u e v); se in una certa posizione u e v contengono la stessa lettera,
;; allora anche w contiene quella lettera nella posizione corrispondente; se invece u e v contengono lettere diverse, w
;; contiene il simbolo “asterisco” nella posizione corrispondente. Per esempio, il valore dell’espressione Scheme
;; (match "astrazione" "estremi") è rappresentato dalla stringa delle corrispondenze "*str**i".

(define match
  (lambda (u v)
    (if (or (string=? u "") (string=? v ""))
        ""
        (let ((uh (string-ref u 0)) (vh (string-ref v 0))
                                    (s (match (substring u 1) (substring v 1)))
                                    )
          (if (char=? uh vh)
              (string-append (string uh) s)
              (string-append "*" s)
              )
          )
        )
    ))

(match "astrazione" "estremi")

;; 2
;; Completa il programma increment, che calcola l’incremento di un numero naturale rappresentato come stringa di
;; cifre in una base compresa fra 2 e 10. Gli argomenti sono num, la stringa numerica, e base, di tipo intero; il valore
;; restituito è una stringa numerica. Per esempio, il valore dell’espressione (increment "1011" 2) è "1100", dove
;; le stringhe rappresentano rispettivamente 11 e 12 in base 2.

(define offset (char->integer #\0))

(define last-digit
  (lambda (base) (integer->char (+ (- base 1) offset)) ))

(define next-digit
  (lambda (dgt) (string (integer->char (+ (char->integer dgt) 1))) ))

(define increment
  (lambda (num base) ; 2 <= base <= 10
    (let ((digits (string-length num)))
      (if (= digits 0)
          "1"
          (let ((dgt (string-ref num (- digits 1))))
            (if (char=? dgt (last-digit base))
                (string-append (increment (substring num 0 (- digits 1)) base)
                               "0")
                (string-append (substring num 0 (- digits 1)) (next-digit dgt))
                ))
          ))))

(increment "1011" 2)

;; 3
;; Date le stringhe u, v, la procedura lcs calcola una soluzione del problema della sottosequenza comune più lunga. Il
;; risultato è rappresentato da una lista di terne, ciascuna delle quali contiene le posizioni in u e in v di un carattere
;; comune che fa parte della sottosequenza più lunga, numerate a partire da 1, e la stringa costituita dal solo carattere
;; comune. Esempi:
;; (lcs "pino" "pino") → ((1 1 "p") (2 2 "i") (3 3 "n") (4 4 "o"))
;; (lcs "pelo" "peso") → ((1 1 "p") (2 2 "e") (4 4 "o"))
;; (lcs "ala" "palato") → ((1 2 "a") (2 3 "l") (3 4 "a"))
;; (lcs "arto" "atrio") → ((1 1 "a") (3 2 "t") (4 5 "o"))
;; In particolare, nell’ultimo esempio (3 2 "t") contiene le posizioni di 't' rispettivamente in "arto" e "atrio".
;; Completa il programma riportato nel riquadro introducendo opportune espressioni negli appositi spazi.

(define lcs ; valore: lista di terne
  (lambda (u v) ; u, v: stringhe
    (lcs-rec 0 u 0 v)
    ))

(define lcs-rec
  (lambda (i u j v)
    (cond ((or (string=? u "") (string=? v ""))
           null)
          ((char=? (string-ref u 0) (string-ref v 0))
           (cons (list (+ i 1) (+ j 1) (string-ref u 0))
                 (lcs-rec (+ i 1) (substring u 1) (+ j 1) (substring v 1)) ))
          (else
           (better (lcs-rec (+ i 1) (substring u 1) j v)
                   (lcs-rec i u (+ j 1) (substring v 1))))
          )))

(define better
  (lambda (x y)
    (if (< (length x) (length y)) y x)
    ))

(lcs "pino" "pino") ; ((1 1 "p") (2 2 "i") (3 3 "n") (4 4 "o"))
(lcs "pelo" "peso") ; ((1 1 "p") (2 2 "e") (4 4 "o"))
(lcs "ala" "palato") ; ((1 2 "a") (2 3 "l") (3 4 "a"))
(lcs "arto" "atrio") ; ((1 1 "a") (3 2 "t") (4 5 "o"))

