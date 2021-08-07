(load "test.scm")
(load "2/2.58b.scm")

(define (test)
  (assert-eq
    4
    (deriv '(x + 3 * (x + y + 2)) 'x)
    "Failed"))
(test)
