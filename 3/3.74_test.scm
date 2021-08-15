(load "test.scm")
(load "3/3.74.scm")

(define (test)
  (let ((expect (list 0 0 0 0 0 -1 0 0 0 0 1 0 0)))
    (assert-stream zero-crossings-ref expect "Failed zero-crossings-ref")
    (assert-stream zero-crossings expect "Failed zero-crossings")))
(test)
