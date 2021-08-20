(load "test.scm")
(load "4/4.6.scm")
(load "evaluator_test.scm")

(define (test)
  (define test-suite
    (setup-test new-syntax '()))
  (define (test-fn eval env)
    (assert-eq 7
               (eval '(let ((x 3) (y 4)) false (+ x y)) env)
               "Failed let->combination"))
  (test-suite test-fn))
(test)
