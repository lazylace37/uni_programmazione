#lang scheme

(require "drawings.ss")

;; Square-Cross Puzzle
;;
;; Hai a disposizione due forme base:
;;
;;   larger-tile
;;
;;   smaller-tile
;;
;; Puoi spostare e combinare le forme con le operazioni:
;;
;;   (shift-down <forma> <passi>)
;;
;;   (shift-right <forma> <passi>)
;;
;;   (quarter-turn-right <forma>)
;;
;;   (quarter-turn-left <forma>)
;;
;;   (half-turn <forma>)
;;
;;   (glue-tiles <forma> <forma>)
;;
;; dove  <forma>  e' una delle due forme base, eventualmente
;; spostata e/o ruotata,  <passi>  e' un numero naturale positivo
;; che rapresenta un'unita' di lunghezza minima dei possibili
;; spostamenti in giu' o a sinistra.
;; Le operazioni consentono, rispettivamente, di spostae in basso,
;; spostare a destra, ruotare di 90 gradi in senso orario, ruotare
;; di 90 gradi in senso antiorario, capovolgere e combinare
;; insieme due forme. ... Si capisce meglio provando!
;;
;; L'obiettivo e' di costruire una croce regolare e un quadrato
;; con il minimo numero di pezzi, corrispondenti alle forme base,
;; opportunamente posizionati e orientati.
;;
;; Quali altre figure si possono costruire?


;; Traslazione unitaria da utilizzare con il puzzle

(set-puzzle-shift-step!)

(define glue-tiles-list
  (lambda args
    (cond
      ((= (length args) 1) (first args))
      (else
       (glue-tiles (first args) (apply glue-tiles-list (list-tail args 1)))
       )
      )
    )
  )

(glue-tiles-list
 (half-turn larger-tile)
 (shift-down (shift-right larger-tile 2) 1)

 (shift-down (shift-right smaller-tile 2) 5)
 (shift-down (shift-right (half-turn smaller-tile) 2) 0)
 )

(glue-tiles-list
 (shift-right  (quarter-turn-right larger-tile) 1)
 (shift-down (quarter-turn-left larger-tile) 2)

 (shift-down (quarter-turn-left smaller-tile) 2)
 (shift-down (shift-right (quarter-turn-right smaller-tile) 5) 2)
 )
