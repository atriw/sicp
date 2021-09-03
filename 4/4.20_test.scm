(load "test.scm")
(load "4/4.20.scm")
(load "evaluator_test.scm")
(load "4/4.16.scm") ; lookup-variable-value '*unassigned*
(load "4/4.6.scm") ; let

(define (test)
  (define test-suite
    (setup-test (lambda (syntax) (new-letrec-syntax (new-let-syntax syntax)))
                (lambda (env-model) (new-environment-model env-model (new-let-syntax (make-syntax))))
                '()))
  (define (test-fn eval env)
    (let ((f1 '(define (f1 x)
                 (letrec
                   ((even? (lambda (n)
                             (if (= n 0) true (odd? (- n 1)))))
                    (odd? (lambda (n)
                            (if (= n 0) false (even? (- n 1))))))
                   (if (even? x)
                     (* 2 x)
                     (* 3 x)))))
          (f2 '(define (f2 x)
                 (letrec
                   ((fact (lambda (n)
                            (if (= n 1) 1 (* n (fact (- n 1)))))))
                   (fact x)))))
      (eval f1 env)
      (eval f2 env)
      (assert-eq 4 (eval '(f1 2) env) "Failed letrec f1")
      (assert-eq 120 (eval '(f2 5) env) "Failed letrec f2")))
  (test-suite test-fn))
(test)
