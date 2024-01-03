#lang scheme

(define check-pattern
  (lambda (p s)
    (let ((s-len (string-length s)) (p-len (string-length p)))
      (cond
        ((string=? s "") p)
        ((< s-len p-len) "")
        ((string=? p (substring s 0 p-len))
         (check-pattern p (substring s p-len))
         )
        (else "")
        )
      )
    ))

(define cyclic-pattern
  (lambda (s k)
    (if (< (string-length s) k)
        ""
        (check-pattern (substring s 0 k) (substring s k))
        )
    ))

(cyclic-pattern "" 3) ; ""
(cyclic-pattern "abcabcab" 3) ; ""
(cyclic-pattern "abc" 3) ; "abc"
(cyclic-pattern "abcabcacb" 3) ; ""
(cyclic-pattern "abcabcabc" 3) ; "abc"
(cyclic-pattern "abcabcabc" 2) ; ""

;; 2

(define tess-1x-2
  (lambda (n)
    (cond
      ((= n 1) 1)
      ((= n 2) 1)
      ((= n 3) 2)
      (else
       (+ (tess-1x-2 (- n 2))
          (tess-1x-2 (- n 3))
          )
       )
      )
    ))

(tess-1x-2 1)
(tess-1x-2 2)
(tess-1x-2 3)
(tess-1x-2 4)
(tess-1x-2 5)
(tess-1x-2 6)
(tess-1x-2 7)
(tess-1x-2 8)

;; 3

(define paths ; val: lista di stringhe
  (lambda (i j k) ; i, j, k: interi non negativi
    (paths-rec i j k k)
    ))

(define paths-rec
  (lambda (i j k v)
    (cond
      ((= i 0)
       (if (> j v) null (list(make-string j #\1)))
       )
      ((= j 0)
       (list (make-string i #\0))
       )
      ((= v 0)
       (map (lambda (x) (string-append "0" x))
            (paths-rec (- i 1) j k k)))
      (else
       (append
        (map (lambda (x) (string-append "0" x))
             (paths-rec (- i 1) j k k))
        (map (lambda (x) (string-append "1" x))
             (paths-rec i (- j 1) k (- v 1))
             )
        )
       )
      )
    ))

(paths 5 1 2) ; ("000001" "000010" "000100" "001000" "010000" "100000")
(paths 1 5 2) ; ()
(paths 2 2 1) ; ("0101" "1001" "1010")

