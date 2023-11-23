;; Questo problema affronta la somma di interi utilizzando la Rappresentazione Ternaria Bilanciata (BTR). Un numero
;; intero in notazione BTR è rappresentato da una stringa di cifre - / . / + , i cui valori sono, rispettivamente, –1, 0 e +1.
;; Dati due interi in notazione BTR, si vuole determinare la rappresentazione BTR della somma.
;; L’obiettivo è dunque definire una procedura btr-sum i cui argomenti e il cui valore sono stringhe BTR. Ti è richiesto
;; inoltre di perseguire questo obiettivo attraverso elaborazioni formali dei simboli, cioè operando direttamente su stringhe
;; e caratteri, senza passare per le conversioni da stringhe BTR a interi e viceversa — conversioni che risulteranno invece
;; utili per verificare i risultati ottenuti. In altri termini, si tratta di applicare una logica analoga a quella che può aver
;; seguito Brusentsov per progettare l’unità aritmetica del suo computer Setun, basato sul sistema ternario bilanciato.

#lang scheme

(define btr-carry                        ; val:     carattere +/./-
  (lambda (u v c)                        ; u, v, c: caratteri +/./-
    (cond ((char=? u #\-)                ; u v c
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; - - -
                         #\.)
                        ((char=? c #\.)  ; - - .
                         #\+)
                        ((char=? c #\+)  ; - - +
                         #\-)))
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; - . -
                         #\+)
                        ((char=? c #\.)  ; - . .
                         #\-)
                        ((char=? c #\+)  ; - . +
                         #\.)))
                 ((char=? v #\+)         ; - + c
                  c)))
          ((char=? u #\.)
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; . - -
                         #\+)
                        ((char=? c #\.)  ; . - .
                         #\-)
                        ((char=? c #\+)  ; . - +
                         #\.)))
                 ((char=? v #\.)         ; . . c
                  c)
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; . + -
                         #\.)
                        ((char=? c #\.)  ; . + .
                         #\+)
                        ((char=? c #\+)  ; . + +
                         #\-)))))
          ((char=? u #\+)
           (cond ((char=? v #\-)         ; + - c
                  c)
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; + . -
                         #\.)
                        ((char=? c #\.)  ; + . .
                         #\+)
                        ((char=? c #\+)  ; + . +
                         #\-)))
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; + + -
                         #\+)
                        ((char=? c #\.)  ; + + .
                         #\-)
                        ((char=? c #\+)  ; + + +
                         #\.)))))
          )))

;; Somma di tre cifre nel sistema ternario bilanciato (caratteri):
;; - u, v rappresentano le cifre "incolonnate",
;; - c rappresenta il riporto "in entrata";
;; - la cifra restituita rappresenta la cifra "incolonnata"
;;   con u, v nel risultato.
;;
;; Il riporto va considerato a parte,
;; definendo una procedura "carry" con analoga struttura per casi.


(define btr-digit-sum                    ; val:     carattere +/./-
  (lambda (u v c)                        ; u, v, c: caratteri +/./-
    (cond ((char=? u #\-)                ; u v c
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; - - -
                         #\.)
                        ((char=? c #\.)  ; - - .
                         #\+)
                        ((char=? c #\+)  ; - - +
                         #\-)))
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; - . -
                         #\+)
                        ((char=? c #\.)  ; - . .
                         #\-)
                        ((char=? c #\+)  ; - . +
                         #\.)))
                 ((char=? v #\+)         ; - + c
                  c)))
          ((char=? u #\.)
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; . - -
                         #\+)
                        ((char=? c #\.)  ; . - .
                         #\-)
                        ((char=? c #\+)  ; . - +
                         #\.)))
                 ((char=? v #\.)         ; . . c
                  c)
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; . + -
                         #\.)
                        ((char=? c #\.)  ; . + .
                         #\+)
                        ((char=? c #\+)  ; . + +
                         #\-)))))
          ((char=? u #\+)
           (cond ((char=? v #\-)         ; + - c
                  c)
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; + . -
                         #\.)
                        ((char=? c #\.)  ; + . .
                         #\+)
                        ((char=? c #\+)  ; + . +
                         #\-)))
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; + + -
                         #\+)
                        ((char=? c #\.)  ; + + .
                         #\-)
                        ((char=? c #\+)  ; + + +
                         #\.)))))
          )))

(define head    ; val: stringa
  (lambda (s)   ; s: stringa
    (cond
      ((string=? s "") "")
      (else (substring s 0 (- (string-length s) 1)))
      )
    ))

(define lsd
  (lambda (s)
    (if (string=? s "") #\. (string-ref s (- (string-length s) 1)))
    ))

(define normalized-btr
  (lambda (s)
    (cond
      ((string=? s "") s)
      ((char=? (string-ref s 0) #\.) (normalized-btr (substring s 1)))
      (else s)
      )
    ))

(define btr-carry-sum
  (lambda (u v c)        ; u v: stringhe BTR, c: carattere carry
    (if (and (string=? u "") (string=? v ""))
        ""
        (string-append (btr-digit-sum (lsd u) (lsd v) c) (btr-carry-sum (head u) (head v) #\0))
        )
    ))

(define btr-sum    ; val: stringa somma
  (lambda (u v)  ; u, v: stringhe addendi
    (btr-carry-sum u v #\0)
    ))

;; (btr-sum "-+--" "+")
(btr-sum "-+--" "-")
;; (btr-sum "+-.+" "-+.-")
;; (btr-sum "-+--+" "-.--")
;; (btr-sum "-+-+." "-.-+")
;; (btr-sum "+-+-." "+.+-")
