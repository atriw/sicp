(load "../test.scm")
(load "2.22.scm")

(define (test)
  (assert-pair-eq (list 1 4 9 16) (square-list-iter (list 1 2 3 4)) "Failed"))
(test)
