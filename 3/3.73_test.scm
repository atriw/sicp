(load "test.scm")
(load "3/3.73.scm")

(define (test)
  (define RC1 (RC 5 1 0.5))
  (assert-stream (RC1 ones 1) (list 6 6.5 7. 7.5 8. 8.5) "Failed RC"))
(test)
