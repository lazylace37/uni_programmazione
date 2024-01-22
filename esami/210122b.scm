#lang scheme

(define cyclic-number
  (lambda (s k)
    (cond
      ((< (string-length s) k) 0)
      (else
       (cyclic-number-rec (substring s 0 k) (substring s k) 1)
       )
      )
    ))

(define cyclic-number-rec
  (lambda (p s l)
    (cond
      ((< (string-length s) (string-length p)) l)
      ((string=? p (substring s 0 (string-length p)))
       (cyclic-number-rec p (substring s (string-length p)) (+ l 1))
       )
      (else l)
      )
    ))

(cyclic-number "" 3) ; 0
(cyclic-number "ab" 3) ; 0
(cyclic-number "abc" 3) ; 1
(cyclic-number "abcabcabc" 3) ; 3
(cyclic-number "abcabcabc" 2) ; 1
(cyclic-number "abcabcacb" 3) ; 2

;

(define tess-1-2x
  (lambda (n)
    (cond
      ((= n 0) 0)
      ((= n 1) 1)
      ((= n 2) 2)
      ((= n 3) 3)
      (else
       (+ (tess-1-2x (- n 1)) (tess-1-2x (- n 3)))
       )
      )
    ))

(displayln "Esercizio 2")
(tess-1-2x 4)
(tess-1-2x 5)

;;

(define paths ; val: lista di stringhe
  (lambda (i j k) ; i, j, k: interi non negativi
    (paths-rec i j k k)
    ))

(define paths-rec
  (lambda (i j k u)
    (displayln (list i j k u))
    (cond ((= i 0)
           (list (make-string j #\1)))
          ((= j 0)
           (if (< u i) null (list (make-string i #\0)))
           )
          ((= u 0)
           (map (lambda (x) (string-append "1" x))
                (paths-rec i (- j 1) k k)))
          (else
           (append
            (map (lambda (x) (string-append "0" x))
                 (paths-rec (- i 1) j k (- u 1)))
            (map (lambda (x) (string-append "1" x))
                 (paths-rec i (- j 1) k k))))
          )
    ))

(paths 5 1 2) ; ()
(paths 1 5 2) ; ("011111" "101111" "110111" "111011" "111101" "111110")
(paths 2 2 1) ; ("0101" "0110" "1010")

