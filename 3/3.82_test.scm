(load "test.scm")
(load "3/3.82.scm")
(load "stream.scm")

(define (test)
  (define (unit-circle x y)
    (<= (+ (square (- x 1)) (square (- y 1))) 1))
  (define (unit-square x y)
    (and (>= x 0) (<= x 1) (>= y 0) (<= y 1)))
  (let ((s1 (estimate-integral-stream unit-square 0 1 0 1))
        (s2 (estimate-integral-stream unit-circle 0.0 2.0 0.0 2.0)))
    (assert-eq-tolerance
      0.01
      1
      (stream-ref s1 10000)
      "Failed estimate-integral-stream unit-square")
    (assert-eq-tolerance
      0.03
      3.14
      (stream-ref s2 10000)
      "Failed estimate-integral-stream pi")))
(test)
