(load "stream.scm")
(load "3/3.60.scm")
(load "3/3.61.scm")

(define (div-series num den)
  (let ((den-constant (stream-car den)))
    (if (= 0 den-constant)
      (error "The denominator has zero constant term")
      (mul-series
        num
        (scale-stream (invert-unit-series (scale-stream den (/ 1 den-constant))) (/ 1 den-constant))))))
