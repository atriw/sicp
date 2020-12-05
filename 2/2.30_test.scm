(load "../test.scm")
(load "2.30.scm")

(define tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(define want (list 1 (list 4 (list 9 16) 25) (list 36 49)))

(define (test)
    (assert-eq want (square-tree tree) "Failed"))
(test)

(define (test-map)
  (assert-eq want (square-tree-map tree) "Failed map"))
(test-map)
