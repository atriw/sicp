(load "test.scm")
(load "3/3.71.scm")

(define (test)
  (let ((s (ramanujan-numbers)))
    (display-stream s 5)
    (assert-stream s (list 1729 4104 13832 20683 32832) "Failed ramanujan-numbers")))
(test)
