(load "../test.scm")
(load "2.32.scm")

(define (test)
  (let ((set (list 1 2 3))
        (want (list '() (list 3) (list 2) (list 2 3) (list 1) (list 1 3) (list 1 2) (list 1 2 3))))
    (assert-eq want (subsets set) "Failed")))
(test)
