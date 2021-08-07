(load "test.scm")
(load "2/2.39.scm")

(define (test)
  (let ((items (list 1 2 3 4))
        (want (list 4 3 2 1)))
    (begin (assert-eq want (reverse-left items) "Failed reverse-left")
           (assert-eq want (reverse-right items) "Failed reverse-right"))))
(test)
