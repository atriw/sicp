(load "evaluator.scm")
(load "syntax.scm")
(load "environment.scm")
(load "integral-evaluator.scm")
(load "amb-evaluator.scm")

(define (make-driver-loop evaluator environment-model lazy? extent?)
  (define input-prompt
    (cond ((and lazy? (not extent?))  ";;; L-Eval input:")
          ((and lazy? extent?) ";;; L-E-Eval input:")
          (else ";;; M-Eval input:")))
  (define output-prompt
    (cond ((and lazy? (not extent?))  ";;; L-Eval value:")
          ((and lazy? extent?) ";;; L-E-Eval value:")
          (else ";;; M-Eval value:")))
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
    (define quit? #f)
    (prompt-for-input input-prompt)
    (let ((input (read)))
      (if (equal? input '(EXIT))
        (begin (set! quit? #t) 'quit)
        (let ((output (eval input the-global-environment)))
          (announce-output output-prompt)
          (user-print output))))
    (if quit?
      'quit
      (driver-loop)))
  driver-loop)

(define (make-amb-driver-loop evaluator environment-model)
  (define input-prompt ";;; Amb-Eval input:")
  (define output-prompt ";;; Amb-Eval value:")
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
  (define ambeval (evaluator 'ambeval))
  (define the-global-environment (setup-environment environment-model))
  (define (driver-loop)
    (define (internal-loop try-again)
      (prompt-for-input input-prompt)
      (let ((input (read)))
        (if (eq? input 'try-again)
          (try-again)
          (begin
            (newline) (display ";;; Starting a new problem ")
            (ambeval
              input
              the-global-environment
              (lambda (val next-alternative)
                (announce-output output-prompt)
                (user-print val)
                (internal-loop next-alternative))
              (lambda ()
                (announce-output
                  ";;; There are no more values of")
                (user-print input)
                (driver-loop)))))))
    (internal-loop
      (lambda ()
        (newline) (display ";;; There is no current problem")
        (driver-loop))))
  driver-loop)

(define (start)
  (start-option #f #f))
(define (start-lazy)
  (start-option #t #f))
(define (start-lazy-extent)
  (start-option #t #t))
(define (start-option lazy? extent?)
  (let ((env-model (make-environment-model))
        (syntax (make-syntax)))
    (let ((evaluator (make-evaluator syntax env-model)))
      (if lazy? ((evaluator 'switch-normal-order) #t))
      (if extent? ((evaluator 'switch-extent-normal-order) #t))
      (let ((loop (make-driver-loop evaluator env-model lazy? extent?)))
        (loop)))))

(define (start-amb)
  (let ((env-model (make-environment-model))
        (syntax (make-syntax)))
    (let ((evaluator (make-amb-evaluator syntax env-model)))
      (let ((loop (make-amb-driver-loop evaluator env-model)))
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
(define (setup-test-amb
          modify-syntax
          modify-env-model
          mock)
  (let ((suite (setup-test-internal make-amb-evaluator
                                    modify-syntax
                                    modify-env-model
                                    mock)))
    (suite (lambda (eval env)
             (eval '(define (require p) (if (not p) (amb))) env)))
    suite))

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
