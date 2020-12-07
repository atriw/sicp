(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (flatmap proc sequence)
  (accumulate append '() (map proc sequence)))

(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ 1 low) high))))

(define (takef lst pred)
  (if (or (null? lst) (not (pred (car lst))))
    '()
    (cons (car lst) (takef (cdr lst) pred))))
