#lang scheme

(define scalar-product ; val: numero
  (lambda (u v) ; u, v: liste numeriche
    (if (null? u)
        0
        (+ (* (car u) (car v)) (scalar-product (cdr u) (cdr v)))
        )))

(define matrix-vector-product
  (lambda (A b)
    (if (null? A)
        null
        ;; (append
        (map (lambda (x) (scalar-product x b) )
             A)
        ;; (matrix-vector-product (cdr A) b)
        ;; )
        )
    ))

(matrix-vector-product
 '((0.8 0.5 0.2) (0.1 1.0 0.4) (0.5 0.5 0.4))
 '(4.0 6.2 5.5) ) ; (7.4 8.8 7.3)

;; 2

(define scs ; val: stringa
  (lambda (u v) ; u, v: stringhe
    (cond ((string=? u "")
           v )
          ((string=? v "")
           u
           )
          ((char=? (string-ref u 0) (string-ref v 0))
           (string-append
            (substring u 0 1)
            (scs (substring u 1) (substring v 1))
            )
           )
          (else
           (let ((x (scs (substring u 1) v))
                 (y (scs u (substring v 1)))
                 )
             (if (< (string-length x) (string-length y))
                 (string-append (substring u 0 1) x)
                 (string-append (substring v 0 1) y)
                 )))
          )))

(scs "arto" "atrio") ; "atrito"
(scs "arco" "ocra") ; "ocrarco"
(scs "archetipo" "") ; "archetipo"
(scs "copia" "copia") ; "copia"

; 3

(define 2-3-tessellations ; val: lista di liste
  (lambda (n) ; n: intero non negativo
    (cond ((= n 0)
           null
           )
          ((= n 1)
           null
           )
          ((= n 2)
           (list '(2))
           )
          (else
           (append
            (map (add-leftmost-tile 2)
                 (2-3-tessellations (- n 2)) )
            (map (add-leftmost-tile 3)
                 (2-3-tessellations (- n 3)) )
            ))
          )))

(define add-leftmost-tile
  (lambda (tile) ; tile: intero (2 o 3)
    (lambda (x)
      (cons tile x)
      )
    ))

(2-3-tessellations 11) ; ( (2 2 2 2 3) (2 2 2 3 2) (2 2 3 2 2)
; (2 3 2 2 2) (2 3 3 3) (3 2 2 2 2)
; (3 2 3 3) (3 3 2 3) (3 3 3 2) )
