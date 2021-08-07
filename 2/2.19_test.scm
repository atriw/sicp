(load "test.scm")
(load "2/2.19.scm")

(define (test)
  (begin (assert-eq 292 (cc 100 us-coins) "Failed")
         (assert-eq 292 (cc 100 (reverse us-coins)) "Failed reverse")))
(test)
