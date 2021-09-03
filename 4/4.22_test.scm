(load "test.scm")
(load "4/4.22.scm")
(load "evaluator_test.scm")

(define (test)
  (define test-suite
    (setup-test-analyzing new-let-syntax '() '()))
  (define (test-fn eval env)
    (assert-eq 7
               (eval '(let ((x 3) (y 4)) false (+ x y)) env)
               "Failed let->combination"))
  (test-suite test-fn))
(test)
