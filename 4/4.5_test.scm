(load "test.scm")
(load "4/4.5.scm")
(load "evaluator_test.scm")

(define (test)
  (define test-suite
    (setup-test new-cond-if-syntax '() '()))
  (define (test-fn eval env)
    (assert-eq 4
               (eval '(cond (false 1)
                            ((car (cons (cons 3 4) (cons 5 6))) => cdr)
                            (else 5))
                     env)
               "Failed cond recipient"))
  (test-suite test-fn))
(test)
