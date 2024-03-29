(load "test.scm")
(load "2/2.6.scm")

(define (test)
  (let ((f (lambda (x) (+ 1 x)))
        (x 3))
    (begin (assert-eq 3 ((zero f) x) "Failed zero")
           (assert-eq 4 ((one f) x) "Failed one")
           (assert-eq 5 ((two f) x) "Failed two")
           (assert-eq 7 ((four f) x) "Failed four")
           (assert-eq 11 ((eight f) x) "Failed eight"))))
(test)
