(load "../test.scm")
(load "2.46.scm")

(define (test)
  (let ((v1 (make-vect 1 2))
        (v2 (make-vect 3 4)))
    (let ((add-v (add-vect v1 v2))
          (sub-v (sub-vect v2 v1))
          (scale-v (scale-vect 3 v1)))
      (begin (assert-eq 4 (xcor-vect add-v) "Failed to add x")
             (assert-eq 6 (ycor-vect add-v) "Failed to add y")
             (assert-eq 2 (xcor-vect sub-v) "Failed to sub x")
             (assert-eq 2 (ycor-vect sub-v) "Failed to sub y")
             (assert-eq 3 (xcor-vect scale-v) "Failed to scale x")
             (assert-eq 6 (ycor-vect scale-v) "Failed to scale y")))))
(test)
