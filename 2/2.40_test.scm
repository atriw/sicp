(load "test.scm")
(load "2/2.40.scm")

(define (test)
  (let ((want (list (list 2 1) (list 3 1) (list 3 2) (list 4 1) (list 4 2) (list 4 3))))
    (assert-eq want (unique-pairs 4) "Failed unique-pairs")))
(test)
