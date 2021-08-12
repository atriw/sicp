(load "test.scm")
(load "3/3.72.scm")

(define (test)
  (let ((s (sum-of-two-square-in-three-different-ways)))
    (assert-stream s
                   (list (list 325 (list 1 18) (list 6 17) (list 10 15))
                         (list 425 (list 5 20) (list 8 19) (list 13 16))
                         (list 650 (list 5 25) (list 11 23) (list 17 19))
                         (list 725 (list 7 26) (list 10 25) (list 14 23))
                         (list 845 (list 2 29) (list 13 26) (list 19 22)))
                   "Failed sum-of-two-square-in-three-different-ways")))
(test)

