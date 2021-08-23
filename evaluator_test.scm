(load "evaluator.scm")
(load "syntax.scm")
(load "environment.scm")
(load "integral-evaluator.scm")

(define (make-driver-loop evaluator environment-model lazy?)
  (define input-prompt
    (if lazy?
      ";;; L-Eval input:"
      ";;; M-Eval input:"))
  (define output-prompt
    (if lazy?
      ";;; L-Eval value:"
      ";;; M-Eval value:"))
  (define (prompt-for-input string)
    (newline) (newline) (display string) (newline))
  (define (announce-output string)
    (newline) (display string) (newline))
  (define (user-print object)
    (if ((environment-model 'compound-procedure?) object)
      (display (list 'compound-procedure
                     ((environment-model 'procedure-parameters) object)
                     ((environment-model 'procedure-body) object)
                     '<procedure-env>))
      (display object)))
  (define eval (evaluator 'eval))
  (define the-global-environment (setup-environment environment-model))
  (define (driver-loop)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (let ((output (eval input the-global-environment)))
        (announce-output output-prompt)
        (user-print output)))
    (driver-loop))
  driver-loop)

(define (start)
  (start-option-lazy #f))
(define (start-lazy)
  (start-option-lazy #t))
(define (start-option-lazy lazy?)
  (let ((env-model (make-environment-model))
        (syntax (make-syntax)))
    (let ((evaluator (make-evaluator syntax env-model)))
      (if lazy? ((evaluator 'switch-normal-order) #t))
      (let ((loop (make-driver-loop evaluator env-model lazy?)))
        (loop)))))

(define (setup-test
          modify-syntax
          modify-env-model
          mock)
  (setup-test-internal make-evaluator
                       modify-syntax
                       modify-env-model
                       mock))
(define (setup-integral-test
          modify-syntax
          modify-env-model
          mock)
  (setup-test-internal make-integral-evaluator
                       modify-syntax
                       modify-env-model
                       mock))

(define (setup-test-internal make-evaluator
                             modify-syntax ; lambda (syntax) -> syntax
                             modify-env-model; lambda (env-model) -> env-model
                             mock) ; lambda (evaluator syntax env-model) -> ()
  (define syntax
    (if (not (null? modify-syntax))
      (modify-syntax (make-syntax))
      (make-syntax)))
  (define env-model
    (if (not (null? modify-env-model))
      (modify-env-model (make-environment-model))
      (make-environment-model)))
  (define env (setup-environment env-model))
  (define evaluator (make-evaluator syntax env-model))
  (define eval (evaluator 'eval))
  (define (test fn) ; fn: lambda (eval env) -> ()
    (fn eval env))
  (if (not (null? mock)) (mock evaluator syntax env-model))
  test)
