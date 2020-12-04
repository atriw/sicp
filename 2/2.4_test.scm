(load "../test.scm")
(load "2.4.scm")

(define (test)
  (let ((p1 (cons1 1 2)))
    (begin (assert-eq 1 (car1 p1) "Failed car1")
           (assert-eq 2 (cdr1 p1) "Failed cdr1"))))
(test)
