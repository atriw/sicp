(load "test.scm")
(load "2/2.34.scm")

(define (test)
  (assert-eq 79 (horner-eval 2 (list 1 3 0 5 0 1)) "Failed"))
(test)
