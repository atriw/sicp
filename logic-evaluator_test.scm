(load "logic-evaluator.scm")
(load "sample-database.scm")

(define (start)
  (construct-sample-database add-assertion! add-rule! query-syntax-process)
  (query-driver-loop))

(define (setup-test test-fn) ; lambda (eval) -> (), eval: lambda (exp) -> instantiated stream
  (define (eval exp)
    (let ((q (query-syntax-process exp)))
      (cond ((assertion-to-be-added? q)
             (add-rule-or-assertion! (add-assertion-body q))
             'done)
            (else
              (stream-map
                (lambda (frame)
                  (instantiate
                    q
                    frame
                    (lambda (v f)
                      (contract-question-mark v))))
                (qeval q (singleton-stream '())))))))
  (construct-sample-database add-assertion! add-rule! query-syntax-process)
  (test-fn eval))
