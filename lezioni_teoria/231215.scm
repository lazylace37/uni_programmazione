#lang scheme

;; map

(map (lambda (x) (* x 2)) (list 1 2 3))

(define mappa
  (lambda (f lst)
    (if (null? lst)
        null
        (cons (f (car lst)) (mappa f (cdr lst)))
        )
    ))

;; map applicato a lcs

(define all-lcs      ; val: lista di stringhe
  (lambda (s1 s2)    ; s1, s2: stringhe
    (cond
      ((or (= (string-length s1) 0) (= (string-length s2) 0)) (list ""))
      ((char=? (string-ref s1 0) (string-ref s2 0))
       (map
        (lambda (s) (string-append (substring s1 0 1) s))
        (all-lcs (substring s1 1) (substring s2 1))
        )
       )
      (else
       (all-longer-string (all-lcs (substring s1 1) s2) (all-lcs s1 (substring s2 1)))
       ))
    ))

(define all-longer-string    ; val: lista di stringhe
  (lambda (l1 l2)            ; l1, l2: liste di stringhe
    (let ((s1l (string-length (car l1))) (s2l (string-length (car l2))))
      (cond
        ((> s1l s2l) l1)
        ((< s1l s2l) l2)
        (else (append l1 l2))
        )
      ))
  )

(all-lcs "arto" "atrio")

;; Composizione funzionale: f: E -> H, g: D -> E    f.g: D -> H  f(g(x))

(define comp       ; val: f.g: D -> H
  (lambda (f g)    ; f: E -> H, g: D -> E
    (lambda (x) (f (g x)))
    ))

(define h (comp (lambda (x) (+ x 1)) (lambda (x) (* x 2))))
(h 5)

(define iter       ; val: D -> D
  (lambda (f i)    ; f: D -> D, i: intero non negativo
    (lambda (x)
      (if (= i 0)
          x
          (f ((iter f (- i 1)) x))
          )
      )
    ))

(define dub (lambda (x) (* x 2)))
((iter dub 5) 1)

(define iter-identita     ; val: D -> D
  (lambda (f i)           ; f: D -> D, i: intero non negativo
    (if (= i 0)
        id
        (comp f (iter f (- i 1)))
        )
    ))
(define id (lambda (x) x))
((iter-identita dub 5) 1)

