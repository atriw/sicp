(load "test.scm")
(load "4/4.57.scm")
(load "logic-evaluator_test.scm")

(define (test)
  (define (test-fn eval)
    (eval (list 'assert! can-replace))
    (assert-stream (eval '(can-replace ?x (Fect Cy D)))
                   '((can-replace (bitdiddle ben) (fect cy d))
                     (can-replace (hacker alyssa p) (fect cy d)))
                   "Failed can-replace")
    (assert-stream (stream-map (lambda (q)
                                 (cons (cadr (caddr q))
                                       (cadr (cadr q))))
                               (eval can-replace-higher-salary))
                   (list (cons '(aull dewitt) '(warbucks oliver))
                         (cons '(fect cy d) '(hacker alyssa p)))
                   "Failed can-replace-higher-salary"))
  (setup-test test-fn))
(test)