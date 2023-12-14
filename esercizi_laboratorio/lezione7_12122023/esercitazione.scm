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

