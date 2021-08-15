(load "test.scm")
(load "3/3.79.scm")

(load "3/3.78_test.scm")

(test (genaral-solve-2nd (lambda (dy y) (- (* 4 dy) (* 5 y))) dt 1 3))
