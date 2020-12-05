(define (same-parity first . remain)
  (cons first (filter (lambda (x) (= (remainder x 2) (remainder first 2))) remain)))
