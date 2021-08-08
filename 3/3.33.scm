(load "constrain-system.scm")

(define (averager a b c)
  (let ((n (make-connector))
        (u (make-connector)))
    (adder a b u)
    (multiplier n c u)
    (constant 2 n)
    'ok))
