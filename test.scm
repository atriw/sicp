(define (assert op want got msg)
  (if (op want got)
    (begin (display "Test pass.") (newline))
    (error msg)))

(define (assert-eq want got msg)
  (assert equal? want got msg))

