#lang scheme

;; Definisci in Scheme una procedura bin-rep->number che, data una stringa in notazione binaria, restituisce il valore
;; razionale che questa rappresenta. A tal fine converrà organizzare il programma in procedure specializzate in compiti
;; specifici, in particolare: la determinazione del segno, l’individuazione della posizione del punto (se presente), il calcolo
;; della parte intera e della parte frazionaria (o, in alternativa, il calcolo del numero intero rappresentato da tutte le cifre,
;; trascurando il punto, che va quindi diviso per un’opportuna potenza di due, determinata dalla posizione del punto).

(define sign    ; val: 1 se positivo, -1 se negativo
  (lambda (s)   ; s: stringa con almeno 1 carattere
    (if (char=? (string-ref s 0) #\-) -1 1)
    ))

(define dot-position  ; val: intero, posizione del punto
  (lambda (s acc)     ; s: stringa, acc: accumulatore
    (cond
      ((= (string-length s) 0) acc)
      ((char=? (string-ref s 0) #\.) (+ acc 1))
      (else
       (dot-position (substring s 1) (+ acc 1))
       )
      )
    ))

(define binary-conv  ; val: valore intero in base 10
  (lambda (s acc)    ; s: string, acc: accumulator
    (cond
      ((= (string-length s) 0) acc)
      ((not (char-numeric? (string-ref s 0)))
       (binary-conv (substring s 1) acc)
       )
      (else (binary-conv
             (substring s 1)
             (+ (* acc 2) (string->number (substring s 0 1)))
             ))
      )
    ))

(define bin-rep->number  ; val: numero in base 10
  (lambda (s)            ; s: stringa
    (/
     (* (binary-conv s 0) (sign s))
     (expt 2 (- (string-length s) (dot-position s 0)))
     )
    ))

(bin-rep->number "+1101")
(bin-rep->number "0")
(bin-rep->number "10110.011")
(bin-rep->number "-0.1101001")
(display "\n\n")

;; Definisci in Scheme una procedura rep->number che, date due stringhe contenenti una sequenza di b cifre e una
;; notazione numerica in base b, restituisce il valore razionale rappresentato dal secondo argomento. Le cifre convenute
;; sono rappresentate dai b caratteri riportati dalla prima stringa in ordine di valore (della cifra corrispondente) crescente;
;; conseguentemente, la seconda stringa può utilizzare solo quelle cifre, ed eventualmente un segno e/o un punto per
;; separare la parte frazionaria. Gli esempi riportati sotto illustrano i ruoli dei due argomenti di rep->number.

(define char->val
  (lambda (alfabeto c acc)
    (if (string=? c (substring alfabeto 0 1))
        acc
        (char->val (substring alfabeto 1) c (+ acc 1))
        )
    ))

(define base-conv             ; val: valore intero in base 10
  (lambda (alfabeto s acc)    ; alfabeto: string, s: string, acc: accumulator
    (cond
      ((= (string-length s) 0) acc)
      ((or (char=? (string-ref s 0) #\+) (char=? (string-ref s 0) #\-) (char=? (string-ref s 0) #\.))
       (base-conv alfabeto (substring s 1) acc)
       )
      (else (base-conv
             alfabeto
             (substring s 1)
             (+ (* acc (string-length alfabeto)) (char->val alfabeto (substring s 0 1) 0))
             ))
      )
    ))

(define rep->number     ; val: valore intero in base 10
  (lambda (alfabeto s)  ; alfabeto: stringa caratteri alfabeto in ordine di valore crescente, s: stringa
    (/
     (* (base-conv alfabeto s 0) (sign s))
     (expt (string-length alfabeto) (- (string-length s) (dot-position s 0)))
     )
    ))

(rep->number "zu" "-uuzz")
(rep->number "0123" "+21.1")
(rep->number "01234" "-10.02")
(rep->number "0123456789ABCDEF" "0.A")
(rep->number "0123456789ABCDEF" "1CF.0")

