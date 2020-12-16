(load "../test.scm")
(load "2.65.scm")

(define tree1 (list->tree (list 1 2 4 6 8 9)))
(define tree2 (list->tree (list 1 2 3 4 5 6)))

(define (test)
  (let ((set-union (union-set tree1 tree2))
        (want-union-list (list 1 2 3 4 5 6 8 9))
        (set-intersection (intersection-set tree1 tree2))
        (want-intersection-list (list 1 2 4 6)))
    (begin (assert-eq want-union-list (tree->list-2 set-union) "Failed union-set")
           (assert-eq want-intersection-list (tree->list-2 set-intersection) "Failed intersection-set"))))
(test)
