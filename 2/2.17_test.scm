(load "../test.scm")
(load "2.17.scm")

(define (test)
  (let ((l1 (list 1 2 3 17 29 9))
        (l2 (list 1)))
    (begin (assert-pair-eq (list 9) (last-pair l1) "Failed")
           (assert-pair-eq (list 1) (last-pair l2) "Failed"))))
(test)
