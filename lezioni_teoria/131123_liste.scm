#lang scheme

;; 2.1. Costanti e operazioni primitive "irriducibili" sulle liste:
;;
;;      - Costante lista vuota "null";
;;
;;      - Costruzione di liste via via piu' lunghe: "cons";
;;
;;      - Predicato per verificare se una lista e' vuota: "null?";
;;
;;      - Operazioni per acquisire informazioni
;;        sulle componenti di una liste: "car" e "cdr";
;;
;;      - Punto di vista relativo alle liste nei linguaggi funzionali:
;;        La struttura della lista
;;
;;          (1 2 3 4 5)
;;
;;        si caratterizza attraverso coppie ( elemento . lista ):
;;
;;          (1 . (2 3 4 5))
;;
;;          (1 . (2 . (3 4 5)))
;;
;;            ...   ...
;;
;;          (1 . (2 . (3 . (4 . (5 . null)))))
;;
;;        e risulta comunque costruita a partire dall'interno
;;        (ultimo elemento) verso l'esterno (primo elemento):
;;
;;          (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 null)))))
;;

;;      - Punto di vista privilegiato: primo elemento della lista;

null             ; lista vuota
(cons 1 null)
(list 1 2 3 4 5)

(display "\n\n")
(define my-list (list 1 2 3 4 5))

(car my-list)
(cdr my-list)
(display "\n")

(length my-list)
(list-ref my-list 0)
(append my-list (list 6 7 8 9 10))
(reverse my-list)
(display "\n")

;; 3.1. Elemento in posizione k di una lista:
;;      Definizione della procedura "list-ref" in termini di operazioni primitive.
;;
;;      - L'elemento di indice 0 della lista L e' (car L);
;;
;;      - Assumo di conoscere l'elemento t con indice k-1 in (cdr L),
;;        allora l'elemento t ha indice k nella lista L.
(define lista-ref
  (lambda (lis i)  ; lis: lista, i: intero
    (if (= i 0) (car lis) (lista-ref (cdr lis) (- i 1)))
    ))
(lista-ref my-list 4)

;; 3.3. Procedura "append" di una coppia di liste L1 e L2:
;;      Definizione della procedura in termini di operazioni primitive.
;;
;;      - Esempio:  (append '(1 2 3) '(4 5 6 7))  -*->  '(1 2 3 4 5 6 7)
;;
;;      - Se L1 e' vuota, allora la la lista risultante e' L2;
;;
;;      - Assumo di conoscere la soluzione L per (cdr L1) e L2,
;;        allora la lista risultante e' (cons (car L1) L);
;;
;;      - Trattamento 'asimmetrico' di L1 e L2.
(define lista-append
  (lambda (l1 l2)
    (if (null? l1) l2 (cons (car l1) (lista-append (cdr l1) l2)))
    ))
(lista-append (list 1 2 3 4 5) (list 6 7 8 9 10))

;; 3.4. Procedura "reverse" per 'rovesciare' una lista.
;;      - versione inefficiente basata su "append":
(define lista-reverse
  (lambda (l)
    (if (null? l) null (append (lista-reverse (cdr l)) (cons (car l) null)))
    ))
(lista-reverse my-list)

;;      - versione piu' efficiente realizzata attraverso
;;        l'introduzione di un parametro aggiuntivo (lista):
(define lista-reverse-rec
  (lambda (l rev)
    (if (null? l) rev (lista-reverse-rec (cdr l) (cons (car l) rev)))
    ))
(lista-reverse-rec my-list null)

