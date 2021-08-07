(load "test.scm")
(load "2/2.41.scm")

(define (test)
  (let ((want (list (list 5 4 2) (list 6 3 2) (list 6 4 1) (list 7 3 1) (list 8 2 1))))
    (assert-eq want (three-sum 10 11) "Failed three-sum")))
(test)
