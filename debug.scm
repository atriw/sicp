(define (debug f . args)
  (newline) (display "Applying ") (display f) (display " to ") (display args)
  (let ((result (apply f args)))
    (newline) (display "Result: ") (display result) (newline)
    result))

