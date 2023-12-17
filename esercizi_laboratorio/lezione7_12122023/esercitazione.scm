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

;; 4
;; Definisci formalmente una procedura cyclic-string in Scheme che, dati come argomenti una stringa pattern e un
;; numero naturale length, assuma come valore la stringa di lunghezza length risultante dalla ripetizione ciclica di pattern,
;; eventualmente troncata a destra. Per esempio, nel caso dell’espressione (cyclic-string "abcd" n) il risultato
;; della valutazione per n = 0, 1, 2, 4, 5, 11 deve essere, rispettivamente: "", "a", "ab", "abcd", "abcda",
;; "abcdabcdabc".

(define cyclic-string
  (lambda (pattern l)
    (if (= l 0)
        ""
        (let ((ci (modulo (- l 1) (string-length pattern))))
          (string-append
           (cyclic-string pattern (- l 1))
           (string (string-ref pattern ci))
           )
          )
        )
    ))

(cyclic-string "abcd" 0)
(cyclic-string "abcd" 1)
(cyclic-string "abcd" 2)
(cyclic-string "abcd" 4)
(cyclic-string "abcd" 5)
(cyclic-string "abcd" 11)

;; 5
;; Definisci una procedura av in Scheme che, data una lista non vuota (x1 x2 ... xn) i cui n elementi xi appartengono
;; all’insieme {–1, 0, 1}, restituisca la lista (y1 y2 ... yn–1) di n–1 elementi dello stesso insieme tale che yi = –1 se
;; xi + xi+1 < 0, yi = 0 se xi + xi+1 = 0 e yi = 1 se xi + xi+1 > 0.
(define av      ; val: lista di interi -1, 0, 1
  (lambda (lst) ; lst: lista di interi
    (if (= (length (cdr lst)) 0)
        null
        (let ((sum (+ (car lst) (car (cdr lst)))))
          (let (
                (y (cond ((< sum 0) -1) ((> sum 0) 1) (else 0)))
                )
            (cons y (av (cdr lst)))
            )
          )
        )
    ))

(av '(0 0 -1 -1 1 0 0 1 0)) ; (0 -1 -1 0 1 0 1 1)

;; 6
;; Definisci una procedura shared in Scheme che, date due liste u, v (strettamente) ordinate di numeri interi positivi,
;; restituisca la lista ordinata degli elementi comuni a u e v.

(define shared    ; val: lista di interi
  (lambda (u v)   ; u, v: liste (strettamente) ordinate di interi
    (if (or (null? u) (null? v))
        null
        (let ((eu (car u)) (ev (car v)))
          (cond
            ((> eu ev) (shared u (cdr v)))
            ((< eu ev) (shared (cdr u) v))
            (else
             (cons eu (shared (cdr u) (cdr v)))
             )
            )
          )
        )
    ))

(shared '(1 3 5 6 7 8 9 10) '(0 1 2 3 4 5 7 9)) ; (1 3 5 7 9)

;; 7
;; Una parola binaria, cioè una stringa composta esclusivamente dai simboli 0 e 1, supera il controllo di parità se il
;; numero di occorrenze di 1 è pari. Data una lista di parole binarie, la procedura parity-check-failures restituisce
;; la lista delle posizioni delle parole che non superano il controllo di parità.

(define parity-check?
  (lambda (word acc)
    (cond
      ((string=? word "") (= (remainder acc 2) 0))
      ((char=? (string-ref word 0) #\0) (parity-check? (substring word 1) (+ acc 1)))
      (else (parity-check? (substring word 1) acc))
      )
    ))

(define parity-check-failures-aux
  (lambda (lst idx)
    (cond
      ((null? lst) null)
      (else
       (let
           ((pass (parity-check? (car lst) 0)))
         (if pass
             (parity-check-failures-aux (cdr lst) (+ idx 1))
             (cons idx (parity-check-failures-aux (cdr lst) (+ idx 1)))
             )
         )
       )
      )
    ))

(define parity-check-failures
  (lambda (lst)
    (parity-check-failures-aux lst 0)
    ))

(parity-check-failures '("0111" "1001" "0000" "1010")) ; '(0)
(parity-check-failures '("0110" "1101" "0000" "1011")) ; '(1 3)
(parity-check-failures '("0111" "1011" "0100" "1110")) ; '(0 1 2 3)
(parity-check-failures '("0110" "1001" "0000" "1010")) ; '()

;; 8
;; Scrivi un programma in Scheme basato sulla procedura sorted-char-list che, data una stringa, restituisce la lista
;; dei caratteri che vi compaiono, ordinata in ordine alfabetico e senza ripetizioni.

(define update-char-list
  (lambda (c lst)
    (cond
      ((null? lst) (cons c null))
      ((char<? c (car lst)) (cons c lst))
      ((char>? c (car lst)) (cons (car lst) (update-char-list c (cdr lst))))
      (else lst)
      )
    ))

(define acc-char-list
  (lambda (word lst)
    (if (string=? word "")
        lst
        (acc-char-list (substring word 1) (update-char-list (string-ref word 0) lst))
        )
    ))

(define sorted-char-list
  (lambda (word)
    (acc-char-list word null)
    ))

(sorted-char-list "")  ; ()
(sorted-char-list "abc")  ; (#\a #\b #\c)
(sorted-char-list "cba")  ; (#\a #\b #\c)
(sorted-char-list "list of chars that occur in this text")  ; (#\space #\a #\c #\e #\f #\h #\i #\l #\n #\o #\r #\s #\t #\u #\x)

;; 9
;; Data una lista di stringhe u, la procedura clean-up restituisce la lista di tutti gli elementi di u, ma in cui ciascun
;; elemento occorre una volta sola (senza eventuali ripetizioni).

(define in-list?
  (lambda (el lst)
    (cond
      ((null? lst) false)
      ((string=? el (car lst)) true)
      (else (in-list? el (cdr lst)))
      )
    ))

(define clean-up-aux
  (lambda (lst unique-lst)
    (cond
      ((null? lst) unique-lst)
      ((equal? (in-list? (car lst) unique-lst) false)
       (clean-up-aux (cdr lst) (cons (car lst) unique-lst))
       )
      (else
       (clean-up-aux (cdr lst) unique-lst)
       )
      )
    ))

(define clean-up
  (lambda (lst)
    (clean-up-aux lst null)
    ))

(clean-up '("rosa" "garofano" "pervinca" "ciclamino" "genziana" "pervinca" "fiordaliso" "rosa")) ; ("garofano" "ciclamino" "genziana" "pervinca" "fiordaliso" "rosa")

