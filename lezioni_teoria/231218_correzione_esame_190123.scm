#lang scheme

;; 1
;; Il prodotto scalare fra due vettori con lo stesso numero di elementi, talvolta
;; raffigurato come prodotto riga-colonna, è definito dalla somma dei prodotti
;; delle coppie di elementi corrispondenti (vedi illustrazione a lato).
;; La procedura scalar-product, riportata qui sotto, determina il prodotto
;; scalare di due vettori rappresentati da liste della stessa lunghezza.
;;
;; Se A è una matrice di m righe ed n colonne e b è un vettore colonna di n elementi, allora il prodotto matrice-vettore Ab
;; è il vettore colonna c di m elementi il cui elemento i-imo è dato dal prodotto scalare della riga i-ima di A per b. Detto
;; altrimenti, c è il vettore dei prodotti scalari di ciascuna riga di A per b.
;; Assumendo che una matrice m x n sia rappresentata in Scheme da una lista di m righe, a loro volta liste numeriche della
;; stessa lunghezza n, e che anche un vettore sia rappresentato da una lista numerica di lunghezza appropriata, definisci
;; una procedura matrix-vector-product per realizzare il prodotto matrice-vettore (utilizzando dove opportuno la
;; procedura scalar-product).

(define scalar-product ; val: numero
  (lambda (u v) ; u, v: liste numeriche
    (if (null? u)
        0
        (+ (* (car u) (car v)) (scalar-product (cdr u) (cdr v)))
        )))

(define matrix-vector-product   ; val: vettore m
  (lambda (A b)                 ; A: matrice m x n, b: vettore n
    (map (lambda (x) (scalar-product x b)) A)
    ))

(matrix-vector-product '((0.8 0.5 0.2) (0.1 1.0 0.4) (0.5 0.5 0.4))  '(4.0 6.2 5.5) ) ; (7.4 8.8 7.3)

;; 2
;; La procedura scs, impostata nel riquadro, calcola una soprasequenza comune più corta di due sequenze di caratteri u e
;; v rappresentate da stringhe. La soluzione trae ispirazione dall’algoritmo ricorsivo per il calcolo della sottosequenza
;; comune più lunga (LCS), ma in questo caso siamo interessati a determinare una sequenza s, la più corta possibile, di cui
;; sia u che v siano sottosequenze, ovvero si possano ottenere da s, indipendentemente, cancellando alcuni caratteri di s. In
;; generale il risultato non è univoco, per cui scs restituisce una delle possibili soprasequenze più corte
(define scs ; val: stringa
  (lambda (u v) ; u, v: stringhe
    (cond ((string=? u "")
           v)
          ((string=? v "")
           u
           )
          ((char=? (string-ref u 0) (string-ref v 0))
           (string-append
            (substring u 0 1)
            (scs (substring u 1) (substring v 1))
            )
           )
          (else
           (let ((x (scs (substring u 1) v))
                 (y (scs u (substring v 1)))
                 )
             (if (< (string-length x) (string-length y))
                 (string-append (substring u 0 1) x)
                 (string-append (substring v 0 1) y)
                 )))
          )))

(scs "arto" "atrio") ; "atrito"
(scs "arco" "ocra") ; "ocrarco"
(scs "archetipo" "") ; "archetipo"
(scs "copia" "copia") ; "copia"

;; 3
;; Il programma impostato nel riquadro della pagina seguente permette di conoscere tutte le possibili tassellazioni di un
;; cordolo di lunghezza n ≥ 0, dove n misura un numero intero di unità prefissate. Per coprire il cordolo si intende
;; utilizzare due tipi di piastrelle rettangolari, il cui lato maggiore, da allineare al cordolo, misura rispettivamente 2 e 3
;; unità (anziché 1 e 2 unità come nel caso del problema simile discusso in classe). Le tassellazioni sono rappresentate
;; dalla lista delle piastrelle che le costituiscono, secondo l’ordine in cui sono collocate lungo il cordolo, dove ciascuna
;; piastrella è codificata dal numero che ne indica la unghezza del lato maggiore del rettangolo, cioè 2 o 3.
;; La procedura 2-3-tessellations restituisce la lista di tutte le tassellazioni, rappresentata quindi da una lista di liste
;; di interi. Completa il programma inserendo espressioni appropriate negli spazi indicati.

(define 2-3-tessellations  ; val: lista di liste
  (lambda (n)              ; n: intero non negativo
    (cond ((= n 0)
           (list null))
          ((= n 1)
           null)
          ((= n 2)
           (list '(2)))
          (else
           (append
            (map (add-leftmost-tile 2)
                 (2-3-tessellations (- n 2)) )
            (map (add-leftmost-tile 3)
                 (2-3-tessellations (- n 3)) )
            ))
          )))

(define add-leftmost-tile  ; val: procedura [ liste num -> liste num ]
  (lambda (tile)           ; tile: intero (2 o 3)
    (lambda (x) (cons tile x))
    ))

(2-3-tessellations 11)
;; ( (2 2 2 2 3) (2 2 2 3 2) (2 2 3 2 2)
;; (2 3 2 2 2) (2 3 3 3) (3 2 2 2 2)
;; (3 2 3 3) (3 3 2 3) (3 3 3 2) )

;; 4
;; La procedura cube, riportata qui sotto, calcola l’elevamento al cubo di un intero non negativo utilizzando solo somme
;; e confronti. Il programma è sostanzialmento basato sulla procedura ricorsiva di coda cube-rec.

(define cube ; n^3
  (lambda (n) ; n ≥ 0 intero
    (cube-rec n n 0 1 6)
    ))

(define cube-rec ; x + k·( y + (k–1)·(z/2 + k–2) )
  (lambda (k n x y z) ; k, n, x, y, z ≥ 0 interi
    (if (= k 0)
        x
        (cube-rec (- k 1) n
                  (+ x y) (+ y z) (+ z 6))
        )))

;; Proprietà generale
; per ogni k, n, x, y, z naturali . (cube-rec k n x y z) → x + k·( y + (k–1)·(z/2 + k–2) )

;; Caso base
; per ogni n, x, y, z naturali . (cube-rec 0 n x y z) → x + 0·( y + (0–1)·(z/2 + 0–2) )

;; Proprietà da dimostrare come passo induttivo
; Per il k considerato nell'ipotesi induttiva, dimostro
; per ogni n, x, y, z naturali . (cube-rec (k+1 n x y z) → x + (k-1)·( y + (k)·(z/2 + k–1) )

;; Passo induttivo

