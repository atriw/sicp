(load "test.scm")
(load "3/3.19.scm")

(define (test)
  (define cycle1
    (let ((cycle (list 1 2 3)))
      (set-cdr! (last-pair cycle) cycle)
      cycle))
  (define not-cycle
    (let ((cycle (list 1 2 (cons 1 2) 4 5)))
      (set-cdr! (caddr cycle) cycle)
      cycle))
  (begin (assert-eq #t (cycle? cycle1) "Failed cycle1")
         (assert-eq #f (cycle? not-cycle) "Failed not cycle 1")
         (assert-eq #f (cycle? (list 1 2 3)) "Failed not cycle 2")))
(test)
