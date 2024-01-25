#lang scheme

;; 2

(define standard-form
  (lambda (lst)
    (map
     (lambda (x) (upper-word x))
     lst
     )
    ))

(define upper-word
  (lambda (w)
    (let ((x (string-ref w 0)))
      (if (and (char>=? x #\a) (char<=? x #\z))
          (string-append
           (string
            (integer->char (+ (char->integer x) lo-up-offset))
            )
           (substring w 1)
           )
          w
          )
      )
    ))

(define lo-up-offset (- (char->integer #\A) (char->integer #\a)))

(standard-form '("abete" "betulla" "faggio" "quercia" "tiglio")) ; ("Abete" "Betulla" "Faggio" "Quercia" "Tiglio")
(standard-form '("biancoSpino" "Pervinca" "primula" "RODODENDRO" "viola")) ; ("BiancoSpino" "Pervinca" "Primula" "RODODENDRO" "Viola")

;; 3

(define btd-val
  (lambda (t)
    (cond ((char=? t #\-) -1)
          ((char=? t #\.) 0)
          ((char=? t #\+) +1)
          )
    ))

(define btr-val-tr ; val: intero
  (lambda (btr) ; btr: stringa di – / . / +
    (btr-val-rec btr 0)
    ))

(define btr-val-rec
  (lambda (btr val)
    (displayln (list btr val))
    (let ((k (string-length btr))
          )
      (if (= k 0)
          val
          (let ((q (substring btr 1))
                (t (string-ref btr 0))
                )
            (btr-val-rec q (+ (* 3 val) (btd-val t)))
            )))
    ))

(btr-val-tr "-+-+.")

;; 5

(define combinations ; val: lista di stringhe
  (lambda (k n) ; k, n: interi non negativi
    (if (= n 0)
        (list "")
        (let ((u (if (= k 0)
                     null
                     (combinations (- k 1) (- n 1))
                     ))
              (v (combinations k (- n 1)))
              )
          (append
           (map (lambda (x) (string-append "1" x)) u)
           (map (lambda (x) (string-append "0" x)) v)
           )))
    ))

(combinations 0 3) ; ("000")
(combinations 2 3) ; ("110" "101" "100" "011" "010" "001" "000")
(combinations 5 3) ; ("111" "110" "101" "100" "011" "010" "001" "000")
