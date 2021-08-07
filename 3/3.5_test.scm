(load "test.scm")
(load "3/3.5.scm")

(define (test)
  (define (unit-circle x y)
    (<= (+ (square (- x 1)) (square (- y 1))) 1))
  (define (unit-square x y)
    (and (>= x 0) (<= x 1) (>= y 0) (<= y 1)))
  (define (eq-with-error err)
    (lambda (x y) (< (abs (- x y)) err)))
  (begin (assert (eq-with-error 0.01)
                 1
                 (estimate-integral unit-square 0 1 0 1 10000)
                 "Failed estimate-integral unit-square")
         (assert (eq-with-error 0.03)
                 3.14
                 (estimate-integral unit-circle 0.0 2.0 0.0 2.0 10000)
                 "Failed estimate-integral pi")))
(test)
