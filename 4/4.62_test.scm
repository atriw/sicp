(load "test.scm")
(load "4/4.62.scm")
(load "logic-evaluator_test.scm")

(define (test)
  (define (test-fn eval)
    (for-each
      (lambda (rule)
        (eval (list 'assert! rule)))
      last-pair)
    (assert-stream (eval '(last-pair (3) ?x))
                   '((last-pair (3) (3)))
                   "Failed last-pair 1")
    (assert-stream (eval '(last-pair (1 2 3) ?x))
                   '((last-pair (1 2 3) (3)))
                   "Failed last-pair 2")
    (assert-stream (eval '(last-pair (2 ?x) (3)))
                   '((last-pair (2 3) (3)))
                   "Failed last-pair 3"))
  (setup-test test-fn))
(test)