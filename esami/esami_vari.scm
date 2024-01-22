#lang scheme

(define parity-check ; val : stringa binaria
  (lambda (w) ; w : lista non vuota di stringhe binarie della stessa lunghezza
    (parity-rec (cdr w) (car w))
    ))
(define parity-rec ; val : stringa binaria
  (lambda (w p) ; w : lista di stringhe binarie, p : stringa binaria
    (if (null? w)
        p
        (parity-rec (cdr w) (match (car w) p))
        )))

(define match ; val : stringa binaria
  (lambda (q p) ; w : stringa binaria, p : stringa binaria
    (if (or (string=? q "") (string=? p "")) ""
        (let
            ((cq (substring q 0 1)) (cp (substring p 0 1)))
          (if (string=? cq cp)
              (string-append "0" (match (substring q 1) (substring p 1)))
              (string-append "1" (match (substring q 1) (substring p 1)))
              )
          )
        )
    ))

(parity-check '("00101011" "11000011" "10110101")) ; "01011101"

;;

(define tessellations ; val : intero
  (lambda (n) ; n : intero non negativo
    (cond ((= n 0) (list ""))
          ((= n 1) (list "B" "G"))
          (else
           (let ((u (tessellations (- n 2)))
                 (v (tessellations (- n 1)))
                 )
             (append (map (lambda (x) (string-append "RB" x)) u)
                     (map (lambda (x) (string-append "RG" x)) u)
                     (map (lambda (x) (string-append "B" x)) v)
                     (map (lambda (x) (string-append "G" x)) v)
                     ))
           ))
    ))

(tessellations 3)

;;

(define clean-up
  (lambda (u)
    (clean-up-rec u null)
    ))

(define clean-up-rec
  (lambda (u lst)
    (if (null? u)
        lst
        (if (in-list (car u) lst)
            (clean-up-rec (cdr u) lst)
            (clean-up-rec (cdr u) (cons (car u) lst))
            )
        )
    ))

(define in-list
  (lambda (el lst)
    (if (null? lst)
        false
        (if (string=? el (car lst))
            true
            (in-list el (cdr lst))
            )
        )
    ))

(clean-up '("rosa" "garofano" "pervinca" "ciclamino"
                   "genziana" "pervinca" "fiordaliso" "rosa"))
; ("garofano" "ciclamino" "genziana" "pervinca" "fiordaliso" "rosa")

;;

(define pattern-count ; val : intero
  (lambda (pattern text) ; pattern ≠ "", text : stringhe
    (let (
          (k (string-length pattern))
          (n (string-length text))
          )
      (let ((subtetxts
             (map (lambda (x) (display x) (display "\n") (substring text x (+ x k)))
                  (index-range 0 (- n k))))
            )
        (list-sum
         (map (lambda (x) (display x) (display "\n") (if (string=? pattern x) 1 0))
              subtetxts
              ))
        ))
    ))
(define index-range
  (lambda (inf sup)
    (if (> inf sup)
        null
        (cons inf (index-range (+ inf 1) sup))
        )))
(define list-sum
  (lambda (nums)
    (if (null? nums)
        0
        (+ (car nums) (list-sum (cdr nums)))
        )))

(pattern-count "nihil" "ex nihilo nihil")

;;

(define lscs ; val: intero
  (lambda (u v) ; u, v: stringhe
    (cond ((string=? u "")
           (string-length v)
           )
          ((string=? v "")
           (string-length u)
           )
          ((char=? (string-ref u 0) (string-ref v 0))
           (+ 1 (lscs (substring u 1) (substring v 1)))
           )
          (else
           (let ((x (lscs (substring u 1) v))
                 (y (lscs u (substring v 1)))
                 )
             (if (> x y) (+ 1 y) (+ 1 x))
             ))
          )))

(lscs "arto" "atrio") ; 6
(lscs "arco" "ocra") ; 7
(lscs "archetipo" "") ; 9
(lscs "copia" "copia") ; 5

;;

(define R-B-tessellations ; val: lista di liste
  (lambda (n) ; n: intero non negativo
    (cond ((= n 0)
           (list '())
           )
          ((= n 1)
           (list (list #\R) (list #\B))
           )
          (else
           (append
            (map (add-leftmost-tiles (list #\R #\B))
                 (R-B-tessellations (- n 2))
                 )
            (map (add-leftmost-tiles (list #\B))
                 (R-B-tessellations (- n 1))
                 )
            ))
          )))
(define add-leftmost-tiles
  (lambda (tiles) ; tiles: lista di caratteri
    (lambda (lst)
      (append tiles lst)
      )


    ))

(R-B-tessellations 4) ; ( (#\R #\B #\R #\B) (#\R #\B #\B #\R) (#\R #\B #\B #\B)
; (#\B #\R #\B #\R) (#\B #\R #\B #\B) (#\B #\B #\R #\B)
; (#\B #\B #\B #\R) (#\B #\B #\B #\B) )

;;

(define merge
  (lambda (u v)
    (cond
      ((null? u) v)
      ((null? v) u)
      (else (merge-aux u v))
      )
    ))

(define merge-aux
  (lambda (lst acc)
    (cond
      ((null? lst) acc)
      ((in-list? (car lst) acc) (merge-aux (cdr lst) acc))
      (else (merge-aux (cdr lst) (cons (car lst) acc)))
      )
    ))

(define in-list?
  (lambda (el lst)
    (cond
      ((null? lst) false)
      ((string=? el (car lst)) true)
      (else (in-list el (cdr lst)))
      )
    ))

(merge '("rosa" "garofano" "pervinca" "ciclamino")
       '("genziana" "pervinca" "fiordaliso" "rosa"))
;  '("garofano" "ciclamino" "genziana" "pervinca" "fiordaliso" "rosa"))

