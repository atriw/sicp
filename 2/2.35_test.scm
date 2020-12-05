(load "../test.scm")
(load "2.35.scm")

(define (test)
  (assert-eq 8 (count-leaves (list (list 1 2 (list 3 4)) (list 1 2 (list 3 4)))) "Failed"))
(test)
