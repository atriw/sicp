(load "../test.scm")
(load "2.28.scm")

(define (test)
  (let ((x (list (list 1 2) (list 3 4)))
        (want (list (list 4 3) (list 2 1))))
    (assert-pair-eq want (deep-reverse x) "Failed")))
(test)
