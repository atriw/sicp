(load "test.scm")
(load "3/3.80.scm")

(define (test)
  (let ((s ((RLC 1 1 0.2 0.1) 10 0)))
    (display-stream (car s) 10)
    (newline)
    (display-stream (cdr s) 10)))
(test)
