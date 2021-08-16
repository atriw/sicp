(define (rand-update x)
  (remainder (+ 31 (* x 17)) 10000))

(define rand-init 1)

(define (random-numbers requests)
  (define random-stream
    (cons-stream
      rand-init
      (stream-map
        (lambda (req x)
          (cond ((eq? req 'generate) (rand-update x))
                ((eq? req 'reset) rand-init)
                (else
                  (error "Unknown request" req))))
        requests
        random-stream)))
  random-stream)
