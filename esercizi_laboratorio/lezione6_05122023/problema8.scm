#lang scheme

(require "hanoi.ss")

; Procedura che aggiunge un disco all'asticella in base alla
; dimensione del disco e all'iterazione k desiderata
(define hanoi-disks-rec    ; val: configurazione all'iterazione k
  (lambda (n k ds dd dt)   ; n:
    (cond
      ((= n 0) (list ds dd dt))      ; ritorno la configurazione
      ((< k (expt 2 (- n 1)))        ; se k meno della metà di 2^(n-1)
       ; aggiungo un elemento alla pile sorgente
       (hanoi-disks-rec (- n 1) k (cons (car ds) (cons (+ (car (cdr ds)) 1) null)) dt dd)
       )
      (else ; (>= k (- (expt 2 n) 1))
       ; aggiungo un elemento alla pile destinazione
       (hanoi-disks-rec
        (- n 1)
        (if (< k (expt 2 (- n 2))) k (- k (expt 2 (- n 1))))
        dt
        (cons (car dd) (cons (+ (car (cdr dd)) 1) null))
        ds
        )
       )
      )
    ))

; Procedura che restituisce la configurazione della torre di Hanoi
; con n dischi alla k-esima iterazione
(define hanoi-disks    ; val: lista - configurazione alla k mossa
  (lambda (n k)        ; n: intero > 0, k: intero 0 <= k <= 2^n - 1
    (hanoi-disks-rec n k (list 1 0) (list 2 0) (list 3 0))
    ))

(hanoi-disks 3 0) ; '((1 3) (3 0) (2 0))
(hanoi-disks 3 1) ; '((3 0) (2 1) (1 2))
(hanoi-disks 3 2) ; '((2 1) (1 1) (3 1))
(hanoi-disks 3 3) ; '((1 1) (3 2) (2 0))
(hanoi-disks 3 4) ; '((3 2) (2 1) (1 0))
(hanoi-disks 3 5) ; '((2 1) (1 1) (3 1))
(hanoi-disks 3 6) ; '((1 1) (3 0) (2 2))
(hanoi-disks 3 7) ; '((3 0) (2 3) (1 0))
(hanoi-disks 5 13) ; '((3 2) (2 1) (1 2))
(hanoi-disks 15 19705) ; '((3 4) (2 9) (1 2))
(hanoi-disks 15 32767) ; '((3 0) (2 15) (1 0))
(display "\n")

;; (ii) Definisci una procedura hanoi-picture che, dati due interi n, k, con n > 0 e 0 ≤ k ≤ 2n–1, restituisce
;; un’immagine della disposizione dei dischi al termine della k-ima mossa.

; Procedura che aggiunge un disco all'asticella in base alla
; dimensione del disco e all'iterazione k desiderata
(define hanoi-disks-rec-pic
  (lambda (n d k ds dd dt acc-pic)
    (cond
      ((= d 0) acc-pic)
      ((< k (expt 2 (- d 1)))
       (let
           (
            (im (above (disk-image d n (car ds) (car (cdr ds))) acc-pic))
            )
         (hanoi-disks-rec-pic n (- d 1) k (cons (car ds) (cons (+ (car (cdr ds)) 1) null)) dt dd im)
         )
       )
      (else ; (> k (- (expt 2 n) 1))
       (let
           (
            (im (above (disk-image d n (car dd) (car (cdr dd))) acc-pic))
            )
         (hanoi-disks-rec-pic
          n
          (- d 1)
          (if (< k (expt 2 (- d 2))) k (- k (expt 2 (- d 1))))
          dt
          (cons (car dd) (cons (+ (car (cdr dd)) 1) null))
          ds
          im
          )
         )
       )
      )
    ))

(define hanoi-picture
  (lambda (n k)
    (hanoi-disks-rec-pic n n k (list 1 0) (list 2 0) (list 3 0) (towers-background n))
    ))

(hanoi-picture 5 0)
(hanoi-picture 5 13)
(hanoi-picture 5 22)
(hanoi-picture 5 31)
(hanoi-picture 15 19705)

