(load "../test.scm")
(load "2.18.scm")

(define (test)
  (let ((l1 (list 1 2 3 4 5 6)))
    (begin (assert-pair-eq (list 6 5 4 3 2 1) (reverse l1) "Failed"))))
(test)
