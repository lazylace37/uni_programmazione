#lang scheme

(define btr-succ ; val: stringa di -/./+
  (lambda (btr) ; btr: stringa di -/./+
    (let ((n (string-length btr))) ; (brt = "." oppure inizia con "+")
      (let ((lsb (string-ref btr (- n 1))))
        (if (= n 1)
            (if (char=? lsb #\+)
                "+-"
                "+")
            (let ((pre (substring btr 0 (- n 1))))
              (if (char=? lsb #\+)
                  (string-append (btr-succ pre) "-")
                  (string-append pre (if (char=? lsb #\-) "." "+"))
                  ))
            )))
    ))

(btr-succ "+") ; "+-"
(btr-succ "+-") ; "+."
(btr-succ "+-+-") ; "+-+."
(btr-succ "-+-++") ; "-+.--"
