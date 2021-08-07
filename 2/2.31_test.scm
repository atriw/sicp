(load "test.scm")
(load "2/2.31.scm")

(define tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(define want (list 1 (list 4 (list 9 16) 25) (list 36 49)))
(define (square-tree tree) (tree-map square tree))

(define (test)
  (assert-eq want (square-tree tree) "Failed"))
(test)
