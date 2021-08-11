(load "test.scm")
(load "3/3.65.scm")

(define (test)
  (let ((acc-stream (accelerated-sequence euler-transform ln2-stream)))
    (display-stream acc-stream 8)
    (assert (lambda (x y) (< (abs (- x y)) 0.0000001))
            0.693147180559945309
            (stream-ref acc-stream 8)
            "Failed ln2-stream")))
(test)
