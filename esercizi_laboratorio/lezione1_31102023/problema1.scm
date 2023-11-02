#lang scheme

(define (assert-string= s1 s2)
  (let (
        (pass-string (string-append "Test passed!\n" "'" s1 "'" " matches " "'" s2 "'\n\n"))
        (fail-string (string-append "Test failed!\n" "'" s1 "'" " does not match " "'" s2 "'\n\n"))
        )
    (if (string=? s1 s2) (display pass-string) (error fail-string))
    ))

;; Get last char (as string) of a string
(define last-char-string (lambda (s) (substring s (- (string-length s) 1))))

(define articolo-sostantivo (                    ; return: string articolo del sostantivo
                             lambda (sostantivo) ; sostantivo: string
                              (let (
                                    (term-sost (last-char-string sostantivo))
                                    )
                                (cond
                                  ((string=? term-sost "o") "il")
                                  ((string=? term-sost "i") "i")
                                  ((string=? term-sost "a") "la")
                                  ((string=? term-sost "e") "le")
                                  (else (error (string-append "Sostantivo '" sostantivo "' non supportato" )))
                                  )
                                )
                              ))

(define declinazione-verbo (                        ; return: string verbo declinato
                            lambda (verbo soggetto) ; verbo: string, soggetto: string
                             ( let (
                                    (radice-verbo (substring verbo 0 (- (string-length verbo) 3)))
                                    (suff-verbo (substring verbo (- (string-length verbo) 3)))
                                    (term-sost (last-char-string soggetto))
                                    )
                                (cond
                                  ((string=? suff-verbo "are") (
                                                                if (or (string=? term-sost "o") (string=? term-sost "a"))
                                                                   (string-append radice-verbo "a")
                                                                   (string-append radice-verbo "ano")
                                                                   ))
                                  ((string=? suff-verbo "ere") (
                                                                if (or (string=? term-sost "o") (string=? term-sost "a"))
                                                                   (string-append radice-verbo "e")
                                                                   (string-append radice-verbo "ono")
                                                                   ))
                                  ((string=? suff-verbo "ire") (
                                                                if (or (string=? term-sost "o") (string=? term-sost "a"))
                                                                   (string-append radice-verbo "e")
                                                                   (string-append radice-verbo "ono")
                                                                   ))
                                  (else (error (string-append "Verbo '" verbo "' ha una declinazione errata." )))
                                  )
                                )
                             ))

(define frase (                                    ; return: string frase completa
               lambda (soggetto verbo complemento) ; soggetto: string, verbo: string, complemento: string
                (string-append (articolo-sostantivo soggetto) " " soggetto " " (declinazione-verbo verbo soggetto) " " (articolo-sostantivo complemento) " " complemento)
                ))

(assert-string=
 (frase "gatto" "cacciare" "topi")
 "il gatto caccia i topi"
 )
(assert-string=
 (frase "mucca" "mangiare" "fieno")
 "la mucca mangia il fieno"
 )
(assert-string=
 (frase "sorelle" "leggere" "novella")
 "le sorelle leggono la novella"
 )
(assert-string=
 (frase "bambini" "amare" "favole")
 "i bambini amano le favole"
 )
(assert-string=
 (frase "musicisti" "suonare" "pianoforti")
 "i musicisti suonano i pianoforti"
 )
(assert-string=
 (frase "cuoco" "friggere" "patate")
 "il cuoco frigge le patate"
 )
(assert-string=
 (frase "camerieri" "servire" "clienti")
 "i camerieri servono i clienti"
 )
(assert-string=
 (frase "mamma" "chiamare" "figlie")
 "la mamma chiama le figlie"
 )
