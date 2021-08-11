(load "test.scm")
(load "3/3.67.scm")

(define (test)
  (assert-stream (all-pairs integers integers)
                 (list '(1 1) '(1 2) '(2 2) '(2 1) '(2 3) '(1 3) '(3 3) '(3 1) '(3 2))
                 "Failed all-pairs"))
(test)
