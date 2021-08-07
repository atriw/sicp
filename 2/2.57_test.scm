(load "test.scm")
(load "2/2.57.scm")

(define (test)
  (assert-eq
    '(+ (* x y) (* y (+ x 3)))
    (deriv '(* x y (+ x 3)) 'x)
    "Failed"))
(test)
