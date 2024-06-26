#lang scheme

;; Definisci in Scheme una procedura bin-rep->number che, data una stringa in notazione binaria, restituisce il valore
;; razionale che questa rappresenta. A tal fine converrà organizzare il programma in procedure specializzate in compiti
;; specifici, in particolare: la determinazione del segno, l’individuazione della posizione del punto (se presente), il calcolo
;; della parte intera e della parte frazionaria (o, in alternativa, il calcolo del numero intero rappresentato da tutte le cifre,
;; trascurando il punto, che va quindi diviso per un’opportuna potenza di due, determinata dalla posizione del punto).

;; Procedura che ritorna 1 se il segno del numero binario (stringa) è positivo
;; (anche se omesso), -1 se negativo
(define sign    ; val: 1 se positivo, -1 se negativo
  (lambda (s)   ; s: stringa con almeno 1 carattere
    (if (char=? (string-ref s 0) #\-) -1 1)
    ))

;; Procedura che ritorna la posizione del punto (se presente)
(define dot-position  ; val: intero, posizione del punto
  (lambda (s cnt)     ; s: stringa, cnt: contatore
    (cond
      ((= (string-length s) 0) cnt)
      ((char=? (string-ref s 0) #\.) (+ cnt 1))
      (else
       (dot-position (substring s 1) (+ cnt 1))
       )
      )
    ))

;; Procedura che calcola il numero intero rappresentato da tutte le cifre,
;; quindi questa procedura ignora il segno e il punto della stringa binaria.
(define binary-conv  ; val: valore intero in base 10
  (lambda (s cnt)    ; s: stringa numero binario, cnt: contatore
    (cond
      ((= (string-length s) 0) cnt)
      ((not (char-numeric? (string-ref s 0)))  ; se trovo un carattere non numerico, lo salto
       (binary-conv (substring s 1) cnt)
       )
      (else (binary-conv                       ; se trovo un carattere numerico, moltiplico il cnt * 2 e ci sommo il carattere. Poi chiamo la funzione ricorsiva con la sottostringa rimantente
             (substring s 1)
             (+ (* cnt 2) (string->number (substring s 0 1)))
             ))
      )
    ))

;; Procedura che, data una stringa in notazione binaria, restituisce il valore razionale che questa rappresenta
(define bin-rep->number  ; val: numero razionale in base 10
  (lambda (s)            ; s: stringa
    (/
     (* (binary-conv s 0) (sign s))                       ; moltiplico il numero intero per 1 o -1 in base al segno
     (expt 2 (- (string-length s) (dot-position s 0)))    ; divido il numero intero per la potenza di due data dalla lunghezza della stringa - la posizione del punto
     )
    ))

(display "Punto 1:\n")
(bin-rep->number "+1101")
(bin-rep->number "0")
(bin-rep->number "10110.011")
(bin-rep->number "-0.1101001")

;; Definisci in Scheme una procedura rep->number che, date due stringhe contenenti una sequenza di b cifre e una
;; notazione numerica in base b, restituisce il valore razionale rappresentato dal secondo argomento. Le cifre convenute
;; sono rappresentate dai b caratteri riportati dalla prima stringa in ordine di valore (della cifra corrispondente) crescente;
;; conseguentemente, la seconda stringa può utilizzare solo quelle cifre, ed eventualmente un segno e/o un punto per
;; separare la parte frazionaria. Gli esempi riportati sotto illustrano i ruoli dei due argomenti di rep->number.

;; Procedura che converte un carattere nell'alfabeto specificato in numero intero in base 10
;; NOTA: potevo anche generalizzare la procedura del punto 1 che trovava la posizione del punto, così da poter trovare la posizione di un carattere qualsiasi in una stringa
(define char->val
  (lambda (alfabeto c cnt)    ; alfabeto: stringa di caratteri dell'alfabeto in ordine di valore crescente, c: carattere da convertire, cnt: intero
    (if (char=? c (string-ref alfabeto 0))
        cnt
        (char->val (substring alfabeto 1) c (+ cnt 1))
        )
    ))

;; Procedura che calcola il numero intero rappresentato da tutte le cifre,
;; quindi questa procedura ignora il segno e il punto della stringa binaria.
(define base-conv             ; val: valore intero in base 10
  (lambda (alfabeto s cnt)    ; alfabeto: string, s: string, cnt: contatore
    (cond
      ((= (string-length s) 0) cnt)
      ((or (char=? (string-ref s 0) #\+) (char=? (string-ref s 0) #\-) (char=? (string-ref s 0) #\.)) ; se trovo un carattere non dell'alfabeto, lo salto
       (base-conv alfabeto (substring s 1) cnt)
       )
      (else (base-conv        ; se trovo un carattere dell'alfabeto, moltiplico il cnt * la base e ci sommo il carattere. Poi chiamo la funzione ricorsiva con la sottostringa rimantente
             alfabeto
             (substring s 1)
             (+ (* cnt (string-length alfabeto)) (char->val alfabeto (string-ref s 0) 0))
             ))
      )
    ))

;; Procedura che ritorna il numero razionale della stringa s nell'alfabeto specificato
(define rep->number     ; val: valore intero in base 10
  (lambda (alfabeto s)  ; alfabeto: stringa di caratteri dell'alfabeto in ordine di valore crescente
    (/
     (* (base-conv alfabeto s 0) (sign s))
     (expt (string-length alfabeto) (- (string-length s) (dot-position s 0)))
     )
    ))

(display "\nPunto 2:\n")
(rep->number "zu" "-uuzz")
(rep->number "0123" "+21.1")
(rep->number "01234" "-10.02")
(rep->number "0123456789ABCDEF" "0.A")
(rep->number "0123456789ABCDEF" "1CF.0")

