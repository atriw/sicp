(load "test.scm")
(load "2/2.27.scm")

(define (test)
  (let ((x (list (list 1 2) (list 3 4)))
        (want (list (list 4 3) (list 2 1))))
    (assert-eq want (deep-reverse x) "Failed")))
(test)
