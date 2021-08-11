(load "test.scm")
(load "3/3.61.scm")
(load "3/3.59.scm")

(define (test)
  (assert-stream (mul-series (invert-unit-series exp-series) exp-series) (list 1 0 0 0 0 0 0 0) "Failed invert-unit-series")
  (assert-stream (mul-series (invert-unit-series cosine-series) cosine-series) (list 1 0 0 0 0 0 0) "Failed invert-unit-series"))
(test)
