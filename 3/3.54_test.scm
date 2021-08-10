(load "test.scm")
(load "3/3.54.scm")

(define (test)
  (assert-eq 1 (stream-ref factorials 0) "Failed factorials 1")
  (assert-eq 2 (stream-ref factorials 1) "Failed factorials 2")
  (assert-eq 120 (stream-ref factorials 4) "Failed factorials 5")
  (assert-eq 3628800 (stream-ref factorials 9) "Failed factorials 10"))
(test)
