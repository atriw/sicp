(load "../test.scm")
(load "2.36.scm")

(define (test)
  (let ((seqs (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
        (want (list 22 26 30)))
    (assert-eq want (accumulate-n + 0 seqs) "Failed")))
(test)
