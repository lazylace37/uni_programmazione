#lang scheme

;; 1
(define f ; val: intero
  (lambda (x y) ; x, y: interi non negativi
    (if (<= x y)
        1
        (+ (f (- x (+ y 1)) y) (f (- x 1) y))
        )))

(f 4 4)
(f 5 4)
(f 6 4)
(f 4 0)
(f 5 1)
(f 6 0)
(f 7 1)
(f 7 2)

;; 2

(define palindrome?
  (lambda (s)
    (cond
      ((string=? s "") true)
      (else
       (let ((s-len (string-length s)))
         (if (not (char=? (string-ref s 0) (string-ref s (- s-len 1))))
             false
             (palindrome? (get-string-middle s))
             )
         )
       )
      )
    ))

(define get-string-middle
  (lambda (s)
    (let ((right (substring s 1)))
      (if (string=? right "")
          right
          (substring right 0 (- (string-length right) 1))
          )
      )
    ))

(palindrome? "") ; true
(palindrome? "erodere") ; false
(palindrome? "a") ; true
(palindrome? "ilredevevederli") ; true
(palindrome? "nono") ; false
(palindrome? "acetonellenoteca") ; true

;; 3

(define xlcs ; val: stringa
  (lambda (q r) ; q, r: stringhe
    (cond ((string=? r "") q)
          ((string=? q "")
           (string-append "/"(xlcs q (substring r 1))))
          ((char=? (string-ref q 0) (string-ref r 0))
           (string-append "*" (xlcs (substring q 1) (substring r 1))))
          (else
           (better (string-append (substring q 0 1) (xlcs (substring q 1) r))
                   (string-append "/" (xlcs q (substring r 1)))
                   ))
          )))
(define better
  (lambda (u v)
    (if (> (stars u) (stars v))
        u
        v
        )))
(define stars
  (lambda (s)
    (if (string=? s "")
        0
        (let ((n (stars (substring s 1))))
          (if (char=? #\* (string-ref s 0)) (+ n 1) n)
          ))))

(xlcs "" "") ; ""
(xlcs "" "ma") ; "//"
(xlcs "ma" "") ; "ma"
(xlcs "ma" "ma") ; "**"
(xlcs "arto" "atrio") ; "*/*/t*"
(xlcs "atrio" "arto") ; "*/*ri*"
(xlcs "flora" "lira") ; "f*/o**"
(xlcs "cincia" "piani") ;  "/c*/*c*a"

;; 5

(define mh ; val: lista di interi
  (lambda (i j) ; i, j: interi non negativi
    (if (or (= i 0) (= j 0))
        (list 0)
        (append (mx true (- i 1) j) (mx false i (- j 1)))
        )))
(define mx ; down: booleano = true se passo precedente in giù / = false se a destra
  (lambda (down i j)
    (cond ((and (= i 0) (= j 0))
           (list 0))
          ((= i 0)
           (list (if down 1 0)))
          ((= j 0)
           (list (if down 0 1)))
          (down
           (append (mx true (- i 1) j)
                   (map (lambda (x) (+ x 1))(mx false i (- j 1)))
                   ))
          (else
           (append (mx false i (- j 1))
                   (map (lambda (x)(+ x 1)) (mx true (- i 1) j))
                   ))
          )))

(mh 2 2) ; (1 3 2 2 3 1)
(mh 0 5) ; (0)
(mh 4 1) ; (1 2 2 2 1)
