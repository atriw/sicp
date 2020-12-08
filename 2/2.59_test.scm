(load "../test.scm")
(load "2.59.scm")

(define (test)
  (let ((set1 (list 1 2 3 4))
        (set2 (list 2 4 5 6)))
    (begin (assert-eq #t (element-of-set? 3 set1) "Failed element-of-set?")
           (assert-eq #f (element-of-set? 1 set2) "Failed element-of-set?")
           (assert-eq (list 5 1 2 3 4) (adjoin-set 5 set1) "Failed adjoin-set")
           (assert-eq (list 2 4) (intersection-set set1 set2) "Failed intersection-set")
           (assert-eq (list 1 3 2 4 5 6) (union-set set1 set2) "Failed union-set"))))
(test)
