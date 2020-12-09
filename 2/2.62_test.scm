(load "../test.scm")
(load "2.62.scm")

(define (test)
  (let ((set1 (list 1 2 3 4))
        (set2 (list 3 4 5 6)))
    (assert-eq (list 1 2 3 4 5 6) (union-set set1 set2) "Failed")))
(test)
