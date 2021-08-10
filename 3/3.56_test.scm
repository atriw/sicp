(load "test.scm")
(load "3/3.56.scm")

(define (test)
  (assert-stream S (list 1 2 3 4 5 6 8 9 10 12 15 16 18 20) "Failed S"))
(test)
