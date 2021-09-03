(load "test.scm")
(load "4/4.8.scm")
(load "evaluator_test.scm")

(define (test)
  (define test-suite
    (setup-test new-named-let-syntax '() '()))
  (define (test-fn eval env)
    (eval '(define (fib n)
             (let fib-iter ((a 1)
                            (b 0)
                            (count n))
               (if (= count 0)
                 b
                 (fib-iter (+ a b) a (- count 1)))))
          env)
    (assert-eq 13 (eval '(fib 7) env) "Failed named let"))
  (test-suite test-fn))
(test)
