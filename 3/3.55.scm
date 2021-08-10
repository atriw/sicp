(load "stream.scm")

(define (partial-sums s)
  (let ((s0 (stream-car s)))
    (define repeated
      (cons-stream s0 repeated))
    (cons-stream s0
                 (add-streams repeated (partial-sums (stream-cdr s))))))

(define (partial-sums1 s)
  (cons-stream (stream-car s)
               (add-streams (partial-sums1 s)
                            (stream-cdr s))))
