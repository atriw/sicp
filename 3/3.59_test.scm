(load "test.scm")
(load "3/3.59.scm")

(define (test)
  (assert-stream exp-series
                 (list 1 1 (/ 1 2) (/ 1 6) (/ 1 24))
                 "Failed exp series")
  (assert-stream cosine-series
                 (list 1 0 (/ -1 2) 0 (/ 1 24))
                 "Failed cosine-series")
  (assert-stream sine-series
                 (list 0 1 0 (/ -1 6) 0 (/ 1 120))
                 "Failed sine-series"))
(test)
