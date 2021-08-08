(load "test.scm")
(load "3/3.35.scm")

(define (test)
  (let ((a (make-connector))
        (b (make-connector)))
    (probe "a" a)
    (probe "b" b)
    (squarer a b)
    (set-value! a 3 'user)
    (assert-eq 9 (get-value b) "Failed square")
    (forget-value! a 'user)
    (set-value! b 16 'user)
    (assert-eq 4 (get-value a) "Failed sqrt")))
(test)
