(define (cons1 x y)
  (* (expt 2 x) (expt 3 y)))

(define (order-of-factor factor order q r)
  (cond ((> r 0) (- order 1))
        ((= q 1) order)
        ((= q 0) (error "Should not reach here"))
        (else (order-of-factor factor (+ 1 order) (quotient q factor) (remainder q factor)))))

(define (car1 z)
  (order-of-factor 2 0 z 0))
(define (cdr1 z)
  (order-of-factor 3 0 z 0))
