(load "test.scm")
(load "3/3.25.scm")

(define (test)
  (let ((table (make-table)))
    (let ((insert! (table 'insert!))
          (lookup (table 'lookup)))
      (insert! 1 2)
      (insert! (list 1 2) 3)
      (insert! (list 2 1 3) 4)
      (insert! (list 1 2 3) 5)
      (insert! 'a 'x)
      (assert-eq 2 (lookup 1) "Failed 1 dim lookup")
      (assert-eq 3 (lookup (list 1 2)) "Failed 2 dim lookup")
      (assert-eq 4 (lookup (list 2 1 3)) "Failed 3 dim lookup 1")
      (assert-eq 5 (lookup (list 1 2 3)) "Failed 3 dim lookup 2")
      (assert-eq #f (lookup 2) "Failed 1 dim false lookup")
      (assert-eq #f (lookup (list 2 1)) "Failed 2 dim false lookup")
      (assert-eq #f (lookup (list 2 3 1)) "Failed 3 dim false lookup")
      (assert-eq 'x (lookup 'a) "Failed symbol lookup")
      (assert-eq #f (lookup 'b) "Failed symbol false lookup"))))
(test)