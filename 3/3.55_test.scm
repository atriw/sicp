(load "test.scm")
(load "3/3.55.scm")

(define (test)
  (let ((ps (partial-sums integers))
        (ps1 (partial-sums1 integers)))
    (assert-stream ps (list 1 3 6 10 15) "Failed partial-sums")
    (assert-stream ps1 (list 1 3 6 10 15) "Failed partial-sums")))
(test)
