(load "stream.scm")

(define (integrate-series s)
  (stream-map
    (lambda (x y) (/ x y))
    s
    integers))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
