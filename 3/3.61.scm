(load "stream.scm")
(load "3/3.60.scm")

(define (invert-unit-series s)
  (cons-stream 1
               (scale-stream
                 (mul-series
                   (stream-cdr s)
                   (invert-unit-series s))
                 -1)))
; X = 1 - Sr * X
;   = 1 + -1 * x * (s1+s2*x...) * X
;   = (cons-stream 1 (scale-stream (mul-series (stream-cdr s) X) -1))
