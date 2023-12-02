#lang scheme

;; 1. Innanzitutto, definisci in Scheme una procedura belong? che, dati un intero x e una lista ordinata di interi S,
;; verifica se x è un elemento di S.
(define belong?     ; val: (bool) true se è un elemento della lista
  (lambda (x S)     ; x: (intero), S: (lista di interi)
    (cond
      ((null? S) #f)
      ((= (car S) x) #t)
      (else (belong? x (cdr S)))
      )
    ))

(display "Punto 1\n")
(belong? 18 '())
(belong? 18 '(5 7 10 18 23))
(belong? 18 '(5 7 10 12 23))

;; 2. Successivamente, definisci in Scheme una procedura position che, dati un intero x e una lista ordinata di interi
;; senza ripetizioni S, restituisce la posizione (indice) di x in S. A tal fine, assumi che x sia un elemento di S.
(define position-aux   ; val: interi: indice di x in S
  (lambda (x S acc)    ; x: intero, S: lista ordinata di interi contenente s, acc: intero per conteggio posizione
    (cond
      ((= (car S) x) acc)
      (else (position-aux x (cdr S) (+ acc 1)))
      )
    ))

(define position   ; val: interi: indice di x in S
  (lambda (x S)    ; x: intero, S: lista ordinata di interi contenente s
    (position-aux x S 0)
    ))

(display "\nPunto 2\n")
(position 7 '(7 8 24 35 41))
(position 35 '(7 8 24 35 41))
(position 41 '(7 8 24 35 41))

;; 3. Definisci quindi una procedura sorted-ins che, dati un intero x e una lista ordinata di interi senza ripetizioni S,
;; restituisce la lista ordinata e senza ripetizioni che contine x e tutti gli elementi di S.
(define sorted-ins    ; val: lista di interi ordinata e senza ripetizioni
  (lambda (x S)       ; x: intero da inserire nella lista, S: lista di interi senza ripetizioni
    (cond
      ((null? S) (cons x null))
      ((< (car S) x) (cons (car S) (sorted-ins x (cdr S))))
      ((= (car S) x) (sorted-ins x (cdr S)))
      (else (cons x S))
      )
    ))

(display "\nPunto 3\n")
(sorted-ins 24 '())
(sorted-ins 5 '(7 8 24 35 41))
(sorted-ins 24 '(7 8 24 35 41))
(sorted-ins 27 '(7 8 24 35 41))

;; 4. Infine, applica sorted-ins per definire una procedura sorted-list che, data una lista di interi S, restituisce la
;; lista ordinata e senza ripetizioni S' che contine tutti e soli gli interi di S.
(define sorted-list  ; val: lista ordinata e senza ripetizioni dei valori di S
  (lambda (S)        ; S: lista di interi
    (cond
      ((null? S) null)
      (else (sorted-ins (car S) (sorted-list (cdr S))))
      )
    ))

(display "\nPunto 4\n")
(sorted-list '(35 8 41 24 7))
(sorted-list '(35 24 8 41 24 7))

