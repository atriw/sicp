(load "test.scm")
(load "4/4.42.scm")
(load "evaluator_test.scm")
(load "4/4.4.scm")
(load "4/4.6.scm")
(load "stream.scm")
(load "debug.scm")

(define (test)
  (define test-suite
    (setup-test-amb (lambda (syntax) (new-derived-and-or-syntax (new-syntax syntax)))
                    '()
                    '()))
  (define (test-fn ambeval env)
    (ambeval liars env nop-succeed nop-fail)
    (assert-stream (amb->stream ambeval '(liars) env)
                   (list '((betty 3) (ethel 5) (joan 2) (kitty 1) (mary 4)))
                   "Failed liars")
    )
  (test-suite test-fn))
(test)