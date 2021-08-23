(define (with-debug f . args)
  (newline) (display "Applying ") (display f) (display " to ") (display args)
  (let ((result (apply f args)))
    (newline) (display "Result: ") (display result) (newline)
    result))

(define (with-print-time f . args)
  (newline) (display "Applying ") (display f)
  (with-timings
    (lambda () (apply f args))
    (lambda (run-time gc-time real-time)
      (newline) (display "Run time: ") (display (internal-time/ticks->seconds run-time))
      (display "s, GC time: ") (display (internal-time/ticks->seconds gc-time))
      (display "s, Real time: ") (display (internal-time/ticks->seconds real-time)) (display "s.") (newline))))
