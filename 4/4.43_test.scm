(load "test.scm")
(load "4/4.43.scm")
(load "evaluator_test.scm")
(load "stream.scm")
(load "debug.scm")

(define (test)
  (define (test-fn ambeval env)
    (ambeval yacht-daughter env nop-succeed nop-fail)
    (let ((result (with-print-time ambeval '(yacht-daughter) env nop-succeed nop-fail)))
      (display result)
      (assert-eq 'colonel-downing (car (cadr (caddr result))) "Failed yacht-daughter"))
    (ambeval yacht-daughter-modified env nop-succeed nop-fail)
    (assert-eq 2 (drain-amb ambeval '(yacht-daughter-modified) env) "Failed yacht-daughter-modified")
    )
  (full-feature-amb-suite test-fn))
(test)
