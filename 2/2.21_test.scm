(load "../test.scm")
(load "2.21.scm")

(define (test)
  (let ((items (list 1 2 3 4))
        (want (list 1 4 9 16)))
    (begin (assert-pair-eq want (square-list1 items) "Failed square-list1")
           (assert-pair-eq want (square-list2 items) "Failed square-list2"))))
(test)
