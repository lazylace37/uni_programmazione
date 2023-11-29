#lang scheme

;; Definisci in Scheme una procedura manhattan-3d che, dati tre interi non negativi i, j e k, restituisca il numero di
;; percorsi diversi di lunghezza minima attraverso un reticolo tridimensionale fra punti che distano i, j e k unità lungo le
;; tre direzioni (perpendicolari fra di loro) dei collegamenti.
(define manhattan-3d   ; val: numero percorsi, intero non negativo
  (lambda (i j k)      ; i, j, k: interi non negativi
    (cond
      ; casi base: una sola possibilità
      ((and (<= i 0) (<= j 0)) 1)
      ((and (<= j 0) (<= k 0)) 1)
      ((and (<= i 0) (<= k 0)) 1)

      ; caso ricorsivo: sommo le 2 strade possibili
      ((= i 0) (+ (manhattan-3d 0 (- j 1) k) (manhattan-3d 0 j (- k 1))))
      ((= j 0) (+ (manhattan-3d (- i 1) 0 k) (manhattan-3d i 0 (- k 1))))
      ((= k 0) (+ (manhattan-3d (- i 1) j 0) (manhattan-3d i (- j 1) 0)))

      ; caso ricorsivo: sommo le 3 strade possibili
      (else
       (+
        (manhattan-3d (- i 1) j k)
        (manhattan-3d i (- j 1) k)
        (manhattan-3d i j (- k 1))
        )
       )
      )
    ))

(manhattan-3d 0 0 7)
(manhattan-3d 2 0 2)
(manhattan-3d 1 1 1)
(manhattan-3d 1 1 5)
(manhattan-3d 2 3 1)
(manhattan-3d 2 3 3)

