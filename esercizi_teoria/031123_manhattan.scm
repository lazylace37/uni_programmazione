#lang scheme

;; 2. Ricorsione ad albero: Percorsi di Manhattan.
;;
;;    - Formulazione del problema ed esemplificazione:
;;      Quartiere stile "Manhattan", dove gli incroci A e B distano
;;      fra loro i isolati verticalmente e j isolati orizzontalmente
;;
;;         A     A'
;;           .---.---.---.---.---.---.---.
;;           |   |   |   |   |   |   |   |
;;        A" .---.---.---.---.---.---.---.
;;           |   |   |   |   |   |   |   |
;;           .---.---.---.---.---.---.---.
;;           |   |   |   |   |   |   |   |
;;           .---.---.---.---.---.---.---.
;;           |   |   |   |   |   |   |   |
;;           .---.---.---.---.---.---.---.
;;           |   |   |   |   |   |   |   |
;;           .---.---.---.---.---.---.---.
;;                                         B
;;      
;;      In quanti modi diversi posso camminare dall'incrocio A
;;      all'incrocio B senza fare piu' strada del necessario?
;;
;;    - Quanti sono i percorsi nel caso 2 x 2 ? E nel caso 3 x 3 ?
;;
;;    - Riduzioni ricorsive (vedi incroci A' e A") e casi base;
;;
;;    - Codifica dello schema ricorsivo in Scheme;
;;
;;    - Caratterizzazione della "ricorsione ad albero" (tree recursion);
;;
;;    - Si e' visto qualche altro esempio di ricorsione ad albero?

(define manhattan
  (lambda (i j)
    (cond
      ((= j 0) 1)
      ((= i 0) 1)
      ((or (= i 1) (= j 1)) 3)

      (else (+ (manhattan (- i 1) j) (manhattan i (- j 1))))
      )
    )
  )

(manhattan 3 3)

