#lang scheme

(define crittazione    ; val: stringa
  (lambda (msg rgl)    ; msg: stringa, rgl: procedura [ char -> char ]
    (if (string=? msg "")
        ""
        (string-append (string (rgl (string-ref msg 0))) (crittazione (substring msg 1) rgl))
        )
    ))

(define aA (char->integer #\A))
(define aZ (char->integer #\Z))

(define reg-cesare    ; val: char
  (lambda (c)         ; c: char (lettera maiuscola)
    (let ((a (+ (char->integer c) 3)))
      (if (<= a aZ) (integer->char a) (integer->char (- a 26)))
      )
    ))

(crittazione "ALEAIACTAEST" reg-cesare)

;; Esercizio: alfabeto latino ABCDEFGHILMNOPQRSTVX

;; Cifrario di Cesare

(define cifr-cesare  ; val: procedura [ char -> char]
  (lambda (rot)      ; rot: intero non negativo
    (lambda (c)      ; c: char (lettera maiuscola)
      (let ((a (+ (char->integer c) rot)))
        (if (<= a aZ) (integer->char a) (integer->char (- a 26)))
        )
      )
    ))

(crittazione "ALEAIACTAEST" (cifr-cesare 3))

;; Argomenti e valori procedurali

(define reg-decrittazione    ; val: procedura [ char -> char]
  (lambda (rgl)              ; rgl: procedura [ char -> char]
    (let ((rot (- (char->integer (rgl #\A)) aA)))
      (cifr-cesare (- 26 rot))
      )
    ))

(crittazione
 (crittazione "ALEAIACTAEST" (cifr-cesare 6))
 (reg-decrittazione (cifr-cesare 6))
 )

; Ottaviano

(define regola-ottaviano (cifr-cesare 1))
(define regola-inversa-ottaviano (reg-decrittazione regola-ottaviano))
(crittazione
 (crittazione "OTTAVIANO" regola-ottaviano)
 regola-inversa-ottaviano
 )

;; Generalizzata

(define ricerca        ; val: carattere
  (lambda (rgl c a)    ; rgl: procedura [ char -> char ] biiettiva, c: carattere, a: intero (ASCII)
    (if (char=? (rgl (integer->char a)) c)
        (integer->char a)
        (ricerca rgl c (+ a 1))
        )
    ))

(define reg-decrittazione-gen    ; val: procedura [ char -> char]
  (lambda (rgl)                  ; rgl: procedura [ char -> char] biiettiva
    (lambda (c) ; c: carattere
      (ricerca rgl c aA)
      )
    ))

(define regola (cifr-cesare 7))
(define regola-inversa (reg-decrittazione-gen regola))
(crittazione
 (crittazione "PROGRAMMAZIONE" regola)
 regola-inversa
 )

