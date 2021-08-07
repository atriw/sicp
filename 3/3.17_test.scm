(load "test.scm")
(load "3/3.17.scm")

(define (test)
  (define cycle
    (let ((cycle (list 1 2 3)))
      (set-cdr! (last-pair cycle) cycle)
      cycle))
  (define three (list 1 2 3))
  (define four
    (let ((one (list 3)))
      (let ((two (cons one one)))
        (cons 1 two))))
  (define seven
    (let ((one (list 3)))
      (let ((two (cons one one)))
        (cons two two))))
  (begin (assert-eq 3 (count-pairs cycle) "Failed count cycle")
         (assert-eq 3 (count-pairs three) "Failed count three")
         (assert-eq 3 (count-pairs four) "Failed count four")
         (assert-eq 3 (count-pairs seven) "Failed count seven")))
(test)
