(load "../test.scm")
(load "3.1.scm")

(define (test)
  (let ((acc (make-accumulator 5)))
    (begin (assert-eq 15 (acc 10) "Failed accumulator")
           (assert-eq 25 (acc 10) "Failed accumulator"))))
(test)
