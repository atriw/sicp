(define (assert op want got msg)
  (if (op want got)
    (begin (display "Test pass.") (newline))
    (error msg
           (error-irritant/noise ". want: ")
           want
           (error-irritant/noise ", got: ")
           got)))

(define (assert-eq want got msg)
  (assert equal? want got msg))

(define (assert-error fn msg)
  (if (condition/error? (ignore-errors fn))
    (begin (display "Test pass.") (newline))
    (error msg
           "Should have error.")))
