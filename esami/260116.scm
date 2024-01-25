#lang scheme

(define word-count
  (lambda (w)
    (if (string=? w "") 0
        (word-count-rec w (not (is-separator (string-ref w 0))) 0)
        )
    ))

(define word-count-rec
  (lambda (w is-word tot)
    (if (string=? w "") tot
        (if (is-separator (string-ref w 0))
            (if is-word
                (word-count-rec (substring w 1) false (+ tot 1))
                (word-count-rec (substring w 1) false tot)
                )
            (word-count-rec (substring w 1) true
                            tot)
            )
        )
    ))

(define is-separator
  (lambda (c)
    (and
     (or
      (char<? c #\a)
      (char>? c #\z)
      )
     (or
      (char<? c #\A)
      (char>? c #\Z)
      )
     (or
      (char<? c #\0)
      (char>? c #\9)
      )
     )
    ))

(word-count "") ; 0
(word-count " ... ?; ") ; 0
(word-count "3o esercizio della prova scritta di PROGRAMMAZIONE.") ; 7
(word-count " --- film: L'albero degli zoccoli (1978) / regista: E. Olmi ") ; 9

;; 5

(define s-list
  (lambda (u v w)
    (let (
          (x (if (= u 0) null (s-list (- u 1) v w)))
          (y (if (= v 0) null (s-list u (- v 1) w)))
          (z (if (= w 0) null (s-list u v (- w 1))))
          )
      (if (= (+ u v w) 0)
          '("")
          (append
           (map (add-l "a") x)
           (map (add-l "b") y)
           (map (add-l "c") z)
           )
          )
      )
    ))

(define add-l
  (lambda (letter)
    (lambda (el)
      (string-append letter el)
      )
    ))

(s-list 0 5 0) ; ("bbbbb")
(s-list 3 0 1) ; ("aaac" "aaca" "acaa" "caaa")
(s-list 1 1 1) ; ("abc" "acb" "bac" "bca" "cab" "cba")
