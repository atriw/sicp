(load "test.scm")
(load "4/4.11.scm")
(load "evaluator_test.scm")

(define (test)
  (define test-suite
    (setup-test '()
                new-evironment-model
                '()))
  (define (test-fn eval env)
    (assert-eq 56 (eval '(((lambda (x y z)
                         (define (f u v w)
                           (+ (* x u) (* y v) (* z w)))
                         f) 2 3 4) 5 6 7)
                     env) "Failed new-evironment-model"))
  (test-suite test-fn))
(test)
