(load "../test.scm")
(load "2.38.scm")

(define (test)
  (begin (assert-eq (/ 3 2) (fold-right / 1 (list 1 2 3)) "Failed fold-right /")
         (assert-eq (/ 1 6) (fold-left / 1 (list 1 2 3)) "Failed fold-left /")
         (assert-eq (list 1 (list 2 (list 3 '()))) (fold-right list '() (list 1 2 3)) "Failed fold-right list")
         (assert-eq (list (list (list '() 1) 2) 3) (fold-left list '() (list 1 2 3)) "Failed fold-left list")))
(test)
