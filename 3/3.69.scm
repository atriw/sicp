(load "stream.scm")

(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-map
        (lambda (pair) (cons (stream-car s) pair))
        (stream-cdr (pairs t u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define pythagorean-triples
  (stream-filter
    (lambda (x) (= (+ (square (car x)) (square (cadr x))) (square (caddr x))))
    (triples integers integers integers)))

