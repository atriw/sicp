(load "test.scm")
(load "2/2.20.scm")

(define (test)
  (begin (assert-eq (list 1 3 5 7) (same-parity 1 2 3 4 5 6 7) "Failed")
         (assert-eq (list 2 4 6) (same-parity 2 3 4 5 6 7) "Failed")))
(test)
