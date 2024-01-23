#lang scheme

;; 2

(define palindrome-lev
  (lambda (s)
    (let ((k (string-length s)))
      (cond
        ((= k 0) 0)
        ((= k 1) 1)
        ((char=? (string-ref s 0) (string-ref s (- k 1)))
         (+ 1 (palindrome-lev (substring s 1 (- k 1))))
         )
        (else
         (palindrome-lev (substring s 1 (- k 1)))
         )
        )
      )
    ))

(palindrome-lev "") ; 0
(palindrome-lev "a") ; 1
(palindrome-lev "nono") ; 0
(palindrome-lev "esose") ; 3
(palindrome-lev "erodere") ; 3
(palindrome-lev "ilredevevederli") ; 8

;; 3

(define xlcs ; val: stringa
  (lambda (s t) ; s, t: stringhe
    (cond ((string=? s "") t)
          ((string=? t "")
           (string-append "/"(xlcs (substring s 1) t)))
          ((char=? (string-ref s 0) (string-ref t 0))
           (string-append "*" (xlcs (substring s 1) (substring t 1))))
          (else
           (better (string-append "/" (xlcs (substring s 1) t))
                   (string-append (substring t 0 1) (xlcs s (substring t 1)))
                   ))
          )))

(define better
  (lambda (u v)
    (if (< (stars u) (stars v))
        v
        u
        )))

(define stars
  (lambda (q)
    (if (string=? q "")
        0
        (let ((n (stars (substring q 1))))
          (if (char=? (string-ref q 0) #\*) (+ n 1) n)
          ))))

(xlcs "" "") ; ""
(xlcs "" "ma") ; "ma"
(xlcs "ma" "") ; "//"
(xlcs "ma" "ma") ; "**"
(xlcs "arto" "atrio") ; "*/*ri*"
(xlcs "atrio" "arto") ; "*/*/t*"
(xlcs "flora" "lira") ; "/*/i**"
(xlcs "cincia" "piani") ; "/p*a*/*/"
