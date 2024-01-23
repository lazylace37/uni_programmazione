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
