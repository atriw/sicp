(load "../test.scm")
(load "2.54.scm")

(define (test)
  (assert-eq #f (equal? '(this is a list) '(this (is a) list)) "Failed"))
(test)
