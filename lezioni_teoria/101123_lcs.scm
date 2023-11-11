#lang scheme

;; 1. Problema della sottosequenza comune piu' lunga (LCS).
;;
;;    1.1. Preambolo:
;;
;;         - Problema interessante e significativo anche
;;           dal punto di vista applicativo (in diversi ambiti);
;;
;;         - Allineamento del DNA
;;           (Francis Crick & James Watson; schede di Alberto Policriti);
;;
;;         - Smith & Waterman (i volti dell'informatica).
;;
;;    1.2. Definizione del problema e ambito applicativo.
;;
;;         - Confronto fra catene di nucleotidi per conoscere le informazioni
;;           comuni (pattern matching nell'ambito della biologia molecolare):
;;
;;             A G A C T G A A C A T A C
;;               | |  /   \ \  |  / / /
;;               G A T C C G A C T A C
;;
;;           oppure:
;;
;;             A G A C T G A A C A T A C
;;               | |  \   \ \  |  / / /
;;               G A T C C G A C T A C
;;
;;           (ecc.)
;;
;;         - Problemi come l'allineamento del DNA (catene di nucleotidi), attuali
;;           nell'ambito della ricerca in biologia, non si risolvono "a mano":
;;           dimensioni del DNA umano dell'ordine dei miliardi di nucleotidi!
;;           (Genoma umano: > 3 miliardi di coppie di basi.)
;;
;;         - LCS e' un problema di elaborazione non numerica interessante sia
;;           per l'analisi ricorsiva, sia dal punto di vista applicativo.
;;
;; 2. Problema della sottosequenza comune piu' lunga: lunghezza delle soluzioni (LLCS).
;;
;;    2.1. Lunghezza della sottosequenza comune piu' lunga (LLCS)
;;         - Analisi del problema e impostazione della soluzione:
;;
;;           llcs("",v) = llcs(u,"") = 0
;;
;;           llcs(au,av) = 1 + llcs(u,v)
;;
;;           llcs(au,bv) = max( llcs(u,bv), llcs(au,v) )  se a <> b
;;
;;    2.2. Codifica della procedura "llcs".
;;
;;         - Struttura ricorsiva;
;;
;;         - Ricorsione ad albero (terza classe di casi).
;;
;; 3. Problema della sottosequenza comune piu' lunga: soluzioni (LCS).
;;
;;    3.1. Calcolo della LCS a partire dalla struttura di "llcs"
;;         (qui '+' rappresenta la giustapposizione di stringhe):
;;
;;           lcs("",v) = lcs(u,"") = ""
;;
;;           lcs(au,av) = a + lcs(u,v)
;;
;;           lcs(au,bv) = longer( lcs(u,bv), lcs(au,v) )  se a <> b
;;
;;    3.2. Codifica della procedura "lcs".
;;
;;         - Schema basato sulla struttura di "llcs";
;;
;;         - E' univoca la soluzione?
;;
;;             lcs( "ATG", "TAG" ) = ...
;;
;;         - Codifica della procedura di supporto "longer"
;;           (versione non deterministica!);

(define llcs
  (lambda (s1 s2)
    (cond
      ((or (= (string-length s1) 0) (= (string-length s2) 0)) 0)
      ((char=? (string-ref s1 0) (string-ref s2 0))
       (+ 1 (llcs (substring s1 1) (substring s2 1)))
       )
      (else
       (max (llcs (substring s1 1) s2) (llcs s1 (substring s2 1)))
       ))
    ))

(llcs "AGACTGAACATAC" "GATCCGACTAC")

(define lcs
  (lambda (s1 s2)
    (cond
      ((or (= (string-length s1) 0) (= (string-length s2) 0)) "")
      ((char=? (string-ref s1 0) (string-ref s2 0))
       (string-append (substring s1 0 1) (lcs (substring s1 1) (substring s2 1)))
       )
      (else
       (longer-string (lcs (substring s1 1) s2) (lcs s1 (substring s2 1)))
       ))
    ))

(define longer-string
  (lambda (s1 s2)
    (let ((s1l (string-length s1)) (s2l (string-length s2)))
      (cond
        ((> s1l s2l) s1)
        ((< s1l s2l) s2)
        ((= (random 2) 0) s1)
        (else s2)
        )
      ))
  )

(lcs "AGACTGAACATAC" "GATCCGACTAC")
(lcs "AGACTGAACATAC" "GATCCGACTAC")
(lcs "AGACTGAACATAC" "GATCCGACTAC")
(lcs "AGACTGAACATAC" "GATCCGACTAC")
(lcs "AGACTGAACATAC" "GATCCGACTAC")
(lcs "AGACTGAACATAC" "GATCCGACTAC")
(lcs "AGACTGAACATAC" "GATCCGACTAC")

