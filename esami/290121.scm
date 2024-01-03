#lang scheme

(define pair
  (lambda (x y)
    (let
        ((avg (/ (+ x y) 2))
         (s-diff (/ (magnitude (- x y) ) 2))
         )
      (list avg s-diff)
      )
    ))

(define pair-list
  (lambda (a b)
    (cond
      ((or (null? a) (null? b)) null)
      (else
       (cons
        (pair (car a) (car b))
        (pair-list (cdr a) (cdr b))
        )
       )
      )
    ))

(pair 4.8 1.2) ; (3.0 1.8)
(pair 3.5 5.7) ; (4.6 1.1)
(pair 8.1 0.3) ; (4.2 3.9)
(pair 5.0 3.0) ; (4.0 1.0)
(pair-list '(4.8 3.5 8.1) '(1.2 5.7 0.3)) ; ((3.0 1.8) (4.6 1.1) (4.2 3.9))
(pair-list '(5.3 4.3 3.3) '(2.5 4.5 6.5)) ; ((3.9 1.4) (4.4 0.1) (4.9 1.6))

;; 2

(define lcs-align ; val: coppia di liste di caratteri
  (lambda (u v) ; u, v: stringhe
    (let ((m (string-length u)) (n (string-length v))
                                )
      (cond ((or (= m 0) (= n 0))
             (list (string->list u) (string->list v))
             )
            ((char=? (string-ref u 0) (string-ref v 0))
             (lcs-align (substring u 1) (substring v 1))
             )
            (else
             (let ((du (lcs-align (substring u 1) v))
                   (dv (lcs-align u (substring v 1)))
                   )
               ;; (display (list du dv))
               ;; (display "\n")
               (if (> (+ (length (car du)) (length (cadr du)))
                      (+ (length (car dv)) (length (cadr dv)))
                      )
                   (list (car dv) (cons (string-ref v 0) (cadr dv)))
                   (list (cons (string-ref u 0) (car du)) (cadr du))
                   )
               )
             )
            )
      )))

(lcs-align "ac" "bc") ; ((#\a) (#\b))
;; (lcs-align "atrio" "arto") ; ((#\t #\i) (#\t))
;; (lcs-align "epico" "esilio") ; ((#\p #\c) (#\s #\l #\i))

;; 4
(define parity-check? ; val: booleano
  (lambda (words) ; words: lista non vuota di stringhe di 0/1 della stessa lunghezza
    (rec-check? words 0 (string-length (car words)))
    ))
(define rec-check?
  (lambda (words k n)
    (if (< k n)
        (let ((kths (map (bit k) words))) ; kths: lista dei valori dei bit in posizione k nelle parole di words
          (display kths)
          (display "\n")
          (if (even? (count-ones kths))
              (rec-check? words (+ k 1) n)
              false
              ))
        true
        )))

(define bit
  (lambda(k)
    (lambda (word) (if (char=? (string-ref word k) #\0) 0 1))
    ))

(define count-ones
  (lambda (cs)
    (if (null? cs)
        0
        (+ (car cs) (count-ones (cdr cs)))
        )))

(parity-check? '("0110" "1000" "1011" "0101")) ; true
(parity-check? '("0110" "1100" "1011" "0101")) ; false

