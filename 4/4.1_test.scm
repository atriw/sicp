(load "test.scm")
(load "4/4.1.scm")
(load "evaluator_test.scm")

(define probe-procedure
  '(define (probe) (define s 1) (+ (begin (set! s (+ s 1)) s)
                                   (begin (set! s (* s 2)) s))))
(define (test make-list-of-values want msg)
  (define test-suite
    (setup-test
      '()
      '()
      (lambda (evaluator syntax env-model)
        ((evaluator 'mock-list-of-values) (make-list-of-values evaluator syntax)))))
  (define (test-fn eval env)
    (eval probe-procedure env)
    (assert-eq want (eval '(probe) env) msg))
  (test-suite test-fn))

(test make-list-of-values-left-to-right 6 "Failed list-of-values left to right")
(test make-list-of-values-right-to-left 5 "Failed list-of-values right to left")
