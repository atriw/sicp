(load "test.scm")
(load "3/3.60.scm")
(load "3/3.59.scm")

(define (test)
  (let ((one (add-streams (mul-series cosine-series cosine-series) (mul-series sine-series sine-series))))
    (assert-stream one (list 1 0 0 0 0 0 0 0) "Failed mul-series")))
(test)
