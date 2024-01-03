#lang scheme

;; 1

(define f ; val: intero
  (lambda (u v x y) ; u, v, x, y ≥ 0 interi
    (cond ((and (= x u) (= y v)) 0)
          ((= x 0) (if (= u 0) 0 1))
          ((= y 0) (if (= v 0) 0 1))
          (else (+ (f u v (- x 1) y) (f u v x (- y 1))))
          )))

(f 2 1 6 0)
(f 2 0 6 0)
(f 0 4 1 6)
(f 0 0 2 2)
(f 1 1 2 2)
(f 1 1 4 5)
(f 1 1 5 4)
(f 1 1 5 5)

;; 2

(define lower-first ; val: lista di stringhe
  (lambda (lst)     ; val: lista di stringhe
    (map
     (lambda (word) (lower-first-char word))
     lst
     )
    ))

(define lower-first-char
  (lambda (word)
    (string-append
     (string (lower-char (string-ref word 0)))
     (substring word 1)
     )
    ))

(define lower-char
  (lambda (c)
    (if
     (and (> (char->integer c) (char->integer #\a)) (< (char->integer c) (char->integer #\z)))
     c
     (integer->char (- (char->integer c) u-l-offset))
     )
    ))

(define u-l-offset (- (char->integer #\A) (char->integer #\a)))

(lower-first '("Abete" "Betulla" "Faggio" "Quercia" "Tiglio")) ; ("abete" "betulla" "faggio" "quercia" "tiglio")
(lower-first '("BiancoSpino" "pervinca" "Primula" "RODODENDRO" "Viola")) ; ("biancoSpino" "pervinca" "primula" "rODODENDRO" "viola")

;; 3

(define ted-val
  (lambda (t)
    (cond ((char=? t #\0) 0)
          ((char=? t #\1) 1)
          ((char=? t #\2) 2)
          )
    ))

(define ter-val-tr ; val: intero
  (lambda (ter) ; ter: stringa di 0 / 1 / 2
    (ter-val-rec ter 0)
    ))

(define ter-val-rec
  (lambda (ter val )
    (let ((k (string-length ter))
          )
      (if (= k 0)
          val
          (let ((q (substring ter 1 k))
                (t (string-ref ter 0))
                )
            (ter-val-rec q (+ (* 3 val) (ted-val t)))
            )))
    ))

(ter-val-tr "1120") ; 42

;; 5

(define sequences ; val: lista di stringhe
  (lambda (n j) ; n, j: interi non negativi
    (if (> n 0)
        (let ((u (sequences (- n 1) j))
              (v (if (> j 0)
                     (sequences (- n 1)(- j 1))
                     ;; (sequences (- n 1) j)
                     null
                     ;; (cons "+" null)
                     ))
              )
          (append
           (map (lambda (x) (string-append "-" x)) v)
           (map (lambda (x) (string-append "+" x)) u)
           ))
        ;; (if (> j 0) (list "") null)
        (list "")
        )))

(sequences 3 0) ; ("+++")
(sequences 3 2) ; ("--+" "-+-" "-++" "+--" "+-+" "++-" "+++")
(sequences 3 5) ; ("---" "--+" "-+-" "-++" "+--" "+-+" "++-" "+++")

