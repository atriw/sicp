(load "test.scm")
(load "3/3.62.scm")
(load "3/3.59.scm")

(define (apply-series s x n)
  (define (apply-iter t y m)
    (cond ((< m 0) 0)
          (else
            (+ (* (stream-car t) y)
               (apply-iter (stream-cdr t) (* y x) (- m 1))))))
  (apply-iter s 1 n))

(define pi 3.1415926)

(define tolerant 0.00001)

(define (equal-tolerant x y) (< (abs (- x y)) tolerant))

(define (before-test)
  (assert equal-tolerant -1 (apply-series cosine-series pi 100) "Failed apply-series cosine-series")
  (assert equal-tolerant 0 (apply-series cosine-series (/ pi 2) 100) "Failed apply-series cosine-series")
  (assert equal-tolerant 1 (apply-series sine-series (/ pi 2) 100) "Failed apply-series sine-series")
  (assert equal-tolerant 0 (apply-series sine-series pi 100) "Failed apply-series sine-series"))
(before-test)

(define (test)
  (assert-stream (div-series exp-series exp-series) (list 1 0 0 0 0 0 0) "Failed div-series")
  (let ((tangent-series (div-series sine-series cosine-series)))
    (assert equal-tolerant 1 (apply-series tangent-series (/ pi 4) 100) "Failed apply-series tangent-series")))
(test)

