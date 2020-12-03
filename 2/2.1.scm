(define (make-rat n d)
  (cond ((or (and (< n 0) (< d 0)) (and (> n 0) (< d 0))) (cons (- 0 n) (- 0 d)))
        (else (cons n d))))

(define numer car)
(define denom cdr)
