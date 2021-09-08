(load "test.scm")
(load "4/4.58.scm")
(load "logic-evaluator_test.scm")

(define (test)
  (define (test-fn eval)
    (eval (list 'assert! big-shot))
    (assert-stream (eval '(big-shot ?x))
                   '((big-shot (scrooge eben))
                     (big-shot (warbucks oliver))
                     (big-shot (bitdiddle ben)))
                   "Failed big-shot"))
  (setup-test test-fn))
(test)