(load "test.scm")
(load "2/2.2.scm")

(define (test)
  (let ((p1 (make-point 1 2))
        (p2 (make-point 5 6)))
    (let ((s1 (make-segment p1 p2)))
      (let ((mid-point (midpoint-segment s1)))
        (begin (assert-eq 3 (x-point mid-point) "Failed mid-point x")
               (assert-eq 4 (y-point mid-point) "Failed mid-point y"))))))
(test)
