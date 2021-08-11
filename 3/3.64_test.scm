(load "test.scm")
(load "3/3.64.scm")
(load "stream.scm")

(define (test)
  (define (sqrt x tolerance)
    (stream-limit (sqrt-stream x) tolerance))
  (define tolerance 0.0001)
  (assert (lambda (x y) (< (abs (- x y)) tolerance))
          1.414213562373095048
          (sqrt 2 tolerance)
          "Failed stream-limit"))
(test)
