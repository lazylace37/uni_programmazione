;; Questo problema affronta la somma di interi utilizzando la Rappresentazione Ternaria Bilanciata (BTR). Un numero
;; intero in notazione BTR è rappresentato da una stringa di cifre - / . / + , i cui valori sono, rispettivamente, –1, 0 e +1.
;; Dati due interi in notazione BTR, si vuole determinare la rappresentazione BTR della somma.
;; L’obiettivo è dunque definire una procedura btr-sum i cui argomenti e il cui valore sono stringhe BTR. Ti è richiesto
;; inoltre di perseguire questo obiettivo attraverso elaborazioni formali dei simboli, cioè operando direttamente su stringhe
;; e caratteri, senza passare per le conversioni da stringhe BTR a interi e viceversa — conversioni che risulteranno invece
;; utili per verificare i risultati ottenuti. In altri termini, si tratta di applicare una logica analoga a quella che può aver
;; seguito Brusentsov per progettare l’unità aritmetica del suo computer Setun, basato sul sistema ternario bilanciato.

#lang scheme

;; Questa procedura ritorna il riporto
(define btr-carry                        ; val:     carattere +/./- riporto
  (lambda (u v c)                        ; u, v, c: caratteri +/./-
    (cond ((char=? u #\-)                ; u v c
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; - - -
                         #\-)
                        ((char=? c #\.)  ; - - .
                         #\-)
                        ((char=? c #\+)  ; - - +
                         #\.)))
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; - . -
                         #\-)
                        ((char=? c #\.)  ; - . .
                         #\.)
                        ((char=? c #\+)  ; - . +
                         #\.)))
                 ((char=? v #\+)         ; - + c
                  #\.)))
          ((char=? u #\.)
           (cond ((char=? v #\-)
                  (cond ((char=? c #\-)  ; . - -
                         #\-)
                        ((char=? c #\.)  ; . - .
                         #\.)
                        ((char=? c #\+)  ; . - +
                         #\.)))
                 ((char=? v #\.)         ; . . c
                  #\.)
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; . + -
                         #\.)
                        ((char=? c #\.)  ; . + .
                         #\.)
                        ((char=? c #\+)  ; . + +
                         #\+)))))
          ((char=? u #\+)
           (cond ((char=? v #\-)         ; + - c
                  #\.)
                 ((char=? v #\.)
                  (cond ((char=? c #\-)  ; + . -
                         #\.)
                        ((char=? c #\.)  ; + . .
                         #\.)
                        ((char=? c #\+)  ; + . +
                         #\+)))
                 ((char=? v #\+)
                  (cond ((char=? c #\-)  ; + + -
                         #\.)
                        ((char=? c #\.)  ; + + .
                         #\+)
                        ((char=? c #\+)  ; + + +
                         #\+)))))
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

;; data una rappresentazione BTR (stringa), restituisce la parte che precede l’ultima
;; cifra (stringa) oppure la stringa vuota ("") se l’argomento è la stringa vuota
(define head    ; val: stringa
  (lambda (s)   ; s: stringa
    (cond
      ((string=? s "") "")
      (else (substring s 0 (- (string-length s) 1)))
      )
    ))

;; data una rappresentazione BTR (stringa), restituisce la cifra meno significativa
;; (carattere) oppure zero (#\.) se l’argomento è la stringa vuota
(define lsd     ; val: carattere
  (lambda (s)   ; s: stringa
    (if (string=? s "") #\. (string-ref s (- (string-length s) 1)))
    ))

;; data una rappresentazione BTR (stringa), restituisce la rappresentazione non vuota
;; equivalente in cui le eventuali cifre zero (#\.) in testa, ininfluenti, sono rimosse
(define normalized-btr
  (lambda (s)
    (cond
      ((= (string-length s) 1) s)
      ((char=? (string-ref s 0) #\.) (normalized-btr (substring s 1)))
      (else s)
      )
    ))

;; date le rappresentazioni BTR di due interi (stringhe) e il riporto in entrata (carattere),
;; restituisce la rappresentazione BTR della somma inclusiva del riporto
(define btr-carry-sum
  (lambda (u v c)        ; u v: stringhe BTR, c: carattere carry
    (if (and (string=? u "") (string=? v ""))
        ""
        (string-append
         (btr-carry-sum (head u) (head v) (btr-carry (lsd u) (lsd v) c))
         (string (btr-digit-sum (lsd u) (lsd v) c))
         )
        )
    ))

;; la procedura principale
(define btr-sum    ; val: stringa somma
  (lambda (u v)  ; u, v: stringhe addendi
    (normalized-btr (btr-carry-sum u v #\.))
    ))

(btr-sum "-+--" "+")
(btr-sum "-+--" "-")
(btr-sum "+-.+" "-+.-")
(btr-sum "-+--+" "-.--")
(btr-sum "-+-+." "-.-+")
(btr-sum "+-+-." "+.+-")

