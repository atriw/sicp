(load "test.scm")
(load "4/4.4.scm")
(load "evaluator_test.scm")

(define probe-and-shortcut-procedure
  '((lambda () (define accessed false) (and false (set! accessed true)) accessed)))
(define probe-or-shortcut-procedure
  '((lambda () (define accessed false) (or true (set! accessed true)) accessed)))

(define (test new-syntax make-impl)
  (define test-suite
    (setup-test
      new-syntax
      '()
      (lambda (evaluator syntax env-model)
        (let ((impl (make-impl evaluator syntax env-model)))
          ((evaluator 'implement-eval-and) (car impl))
          ((evaluator 'implement-eval-or) (cdr impl))))))
  (define (test-fn eval env)
    (assert-eq #t (eval '(and) env) "Failed empty and")
    (assert-eq #f (eval '(or) env) "Failed empty or")
    (assert-eq #f (eval probe-and-shortcut-procedure env) "Failed and shortcut")
    (assert-eq #f (eval probe-or-shortcut-procedure env) "Failed or shortcut")
    (assert-eq 3 (eval '(and true 2 (- 4 1)) env) "Failed and value")
    (assert-eq #f (eval '(or (= 1 2) false false) env) "Failed or false"))
  (test-suite test-fn))
(test new-and-or-syntax make-and-or-implementation)
(test new-derived-and-or-syntax make-derived-and-or-implementation)
