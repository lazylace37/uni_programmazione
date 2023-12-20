#lang scheme

;; 1. Ricorsione mutua: Numeri di Fibonacci.
;;
;;    - Problema della crescita di una popolazione ideale di conigli
;;      discussa da Leonardo Pisano nel "Liber Abaci" (1202):
;;
;;      * L'ambiente e' chiuso (situazione sperimentale!);
;;      * All'istante iniziale t=0 c'e' una coppia di conigli fertile;
;;      * Una coppia di conigli fertile all'istante t da' alla luce una
;;        nuova coppia di conigli ad ogni mese successivo t+1, t+2, ...
;;      * I conigli nati all'istante t diventano fertili esattamente dopo
;;        un mese, all'istante t+1;
;;      * I conigli non muoiono nell'intervallo di tempo considerato;
;;      * I conigli nascono sempre a coppie: un maschio e una femmina.
;;
;;      (Le ultime due ipotesi non sono esplicitamente enunciate.)

(define adulti   ; val: intero (numero coppie)
  (lambda (t)    ; t: intero non negativo
    (if (= t 0)
        1
        (+ (adulti (- t 1)) (cuccioli (- t 1)))
        )
    ))

(define cuccioli
  (lambda (t)
    (if (= t 0)
        0
        (adulti (- t 1))
        )
    ))

(+ (adulti 12) (cuccioli 12))

;; 2.2. Verifica: procedura per calcolare la lista dei numeri primi
;;      nell'intervallo [m, n].

(define primo?   ; val: boolean
  (lambda (n)    ; n >= 2 intero
    (not (divisori-in? n 2 (- n 1)))
    ))

(define divisori-in?   ; val: boolean
  (lambda (n inf sup)  ; n, inf, sup: interi positivi
    (cond
      ((> inf sup) false)
      ((= (remainder n inf) 0) true)
      (else (divisori-in? n (+ inf 1) sup))
      )
    ))

(define lista-primi   ; val: lista di interi
  (lambda (a b)       ; a, b: interi >= 2
    (cond
      ((> a b) null)
      ((primo? a) (cons a (lista-primi (+ a 1) b)))
      (else (lista-primi (+ a 1) b))
      )
    ))

(lista-primi 2 50)

;; 2.3. Raffinamenti del programma (I):
;;
;;      - Fra i "candidati" divisori di n, e' sufficiente considerare
;;        quelli dispari (ad eccezione di 2);
;;
;;      - Verifica ricondotta all'esistenza di divisori DISPARI
;;        nell'intervallo [3, n-1].
;;
;; 2.4. Raffinamenti del programma (II):
;;
;;      - Fra i "candidati" divisori di n, e' sufficiente considerare
;;        quelli minori o uguali alla radice di n [ sqrt(n) ];
;;
;;      - Se  n = pq  e  p > sqrt(n),  allora  q < sqrt(n);
;;
;;      - Verifica ricondotta all'esistenza di divisori dispari
;;        nell'intervallo [3, floor(sqrt(n))];
;;
;;      - floor(x) e' la parte intera di x.

(define primo-opt?   ; val: boolean
  (lambda (n)    ; n >= 2 intero
    (if (even? n)
        (= n 2)
        (not (divisori-in-opt? n 3 (sqrt n)))
        )
    ))

(define divisori-in-opt?   ; val: boolean
  (lambda (n inf sup)  ; n, inf, sup: interi positivi
    (cond
      ((> inf sup) false)
      ((= (remainder n inf) 0) true)
      (else (divisori-in-opt? n (+ inf 2) sup))
      )
    ))

(define lista-primi-opt ; val: lista di interi
  (lambda (a b)         ; a, b: interi >= 2
    (cond
      ((> a b) null)
      ((primo-opt? a) (cons a (lista-primi-opt (+ a 1) b)))
      (else (lista-primi-opt (+ a 1) b))
      )
    ))

(lista-primi-opt 2 50)

