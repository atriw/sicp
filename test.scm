(define (test-pass)
  (newline) (display "Test pass") (newline))

(define (assert op want got msg)
  (if (op want got)
    (test-pass)
    (error msg
           (error-irritant/noise ". want: ")
           want
           (error-irritant/noise ", got: ")
           got)))

(define (assert-eq want got msg)
  (assert equal? want got msg))

(define (assert-eq-tolerance tolerance want got msg)
  (assert (lambda (x y) (< (abs (- x y)) tolerance)) want got msg))

(define (assert-error fn msg)
  (if (condition/error? (ignore-errors fn))
    (test-pass)
    (error msg
           "Should have error.")))

(define (assert-stream s l msg)
  (cond ((null? l) (test-pass))
        (else
          (let ((sv (stream-car s))
                (sl (car l)))
            (if (equal? sv sl)
              (assert-stream (stream-cdr s) (cdr l) msg)
              (error msg
                     (error-irritant/noise " Stream not equal list, sv: ")
                     sv
                     (error-irritant/noise " sl: ")
                     sl))))))
