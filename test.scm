(define (assert op want got msg)
  (if (op want got)
    (begin (display "Test pass.") (newline))
    (error msg)))

(define (assert-eq want got msg)
  (assert = want got msg))

(define (assert-neq want got msg)
  (assert (lambda (x y) (not (= x y))) want got msg))

(define (assert-pair-eq want got msg)
  (assert (lambda (x y) (and (= (car x) (car y)) (= (cdr x) (cdr y)))) want got msg))
