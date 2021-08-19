(load "evaluator.scm")
(load "syntax.scm")
(load "environment.scm")

(define (start)
  (let ((env-model (make-environment-model))
        (syntax (make-syntax)))
    (let ((evaluator (make-evaluator syntax env-model)))
      (let ((loop (make-driver-loop evaluator env-model)))
        (loop)))))

(define (setup-test
          modify-syntax ; lambda (syntax) -> syntax
          mock) ; lambda (evaluator syntax) -> ()
  (define syntax
    (if (not (null? modify-syntax))
      (modify-syntax (make-syntax))
      (make-syntax)))
  (define env-model (make-environment-model))
  (define env ((env-model 'setup-environment)))
  (define evaluator (make-evaluator syntax env-model))
  (define eval (evaluator 'eval))
  (define (test fn) ; fn: lambda (eval env) -> ()
    (fn eval env))
  (if (not (null? mock)) (mock evaluator syntax))
  test)
