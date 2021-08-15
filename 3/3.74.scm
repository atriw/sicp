(load "stream.scm")

(define (sign-change-detector cur last)
  (cond ((and (or (> last 0) (= last 0)) (< cur 0)) -1)
        ((and (< last 0) (or (> cur 0) (= cur 0))) +1)
        (else 0)))

(define (make-zero-crossings input-stream last-value)
  (if (stream-null? input-stream) the-empty-stream
    (cons-stream
      (sign-change-detector (stream-car input-stream) last-value)
      (make-zero-crossings (stream-cdr input-stream) (stream-car input-stream)))))

(define (list->stream lst)
  (cond ((null? lst) the-empty-stream)
        (else
          (cons-stream (car lst) (list->stream (cdr lst))))))

(define sense-data
  (list->stream (list 1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4)))

(define zero-crossings-ref
  (make-zero-crossings sense-data 0))

(define zero-crossings
  (stream-map sign-change-detector
              sense-data
              (cons-stream 0 sense-data)))

