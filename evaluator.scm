(define (make-evaluator syntax environment-model)
  ; exp ::= self-evaluating
  ;         | variable
  ;         | quote
  ;         | assignment
  ;         | definition
  ;         | if
  ;         | lambda
  ;         | begin
  ;         | cond
  ;         | application
  (define self-evaluating? (syntax 'self-evaluating?))
  (define variable? (syntax 'variable?))
  (define quote? (syntax 'quote?))
  (define text-of-quotation (syntax 'text-of-quotation))
  (define assignment? (syntax 'assignment?))
  (define definition? (syntax 'definition?))
  (define if? (syntax 'if?))
  (define lambda? (syntax 'lambda?))
  (define lambda-parameters (syntax 'lambda-parameters))
  (define lambda-body (syntax 'lambda-body))
  (define begin? (syntax 'begin?))
  (define begin-actions (syntax 'begin-actions))
  (define cond? (syntax 'cond?))
  (define cond->if (syntax 'cond->if))
  (define application? (syntax 'application?))
  (define operator (syntax 'operator))
  (define operands (syntax 'operands))
  (define no-operands? (syntax 'no-operands?))
  (define first-operand (syntax 'first-operand))
  (define rest-operands (syntax 'rest-operands))
  (define if-predicate (syntax 'if-predicate))
  (define if-consequent (syntax 'if-consequent))
  (define if-alternative (syntax 'if-alternative))
  (define last-exp? (syntax 'last-exp?))
  (define first-exp (syntax 'first-exp))
  (define rest-exps (syntax 'rest-exps))
  (define assignment-variable (syntax 'assignment-variable))
  (define assignment-value (syntax 'assignment-value))
  (define definition-variable (syntax 'definition-variable))
  (define definition-value (syntax 'definition-value))

  ; Added by Exercise 4.4
  (define and? (syntax 'and?))
  (define or? (syntax 'or?))
  ; operands, no-operands?, first-operand, rest-operands are the same as application
  ; Added by Exercise 4.6
  (define let? (syntax 'let?))
  (define let->combination (syntax 'let->combination))
  ; Added by Exercise 4.7
  (define let*? (syntax 'let*?))
  (define let*->nested-lets (syntax 'let*->nested-lets))
  ; Added by Exercise 4.20
  (define letrec? (syntax 'letrec?))
  (define letrec->combination (syntax 'letrec->combination))
  ; Added by Exercise 4.24
  (define not? (syntax 'not?))
  (define not->if (syntax 'not->if))

  (define true? (environment-model 'true?))
  (define make-procedure (environment-model 'make-procedure))
  (define compound-procedure? (environment-model 'compound-procedure?))
  (define procedure-parameters (environment-model 'procedure-parameters))
  (define procedure-body (environment-model 'procedure-body))
  (define procedure-environment (environment-model 'procedure-environment))
  (define primitive-procedure? (environment-model 'primitive-procedure?))
  (define apply-primitive-procedure (environment-model 'apply-primitive-procedure))
  (define extend-environment (environment-model 'extend-environment))
  (define lookup-variable-value (environment-model 'lookup-variable-value))
  (define set-variable-value! (environment-model 'set-variable-value!))
  (define define-variable! (environment-model 'define-variable!))

  (define (eval exp env)
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (lookup-variable-value exp env))
          ((quote? exp) (text-of-quotation exp))
          ((assignment? exp) (eval-assignment exp env))
          ((definition? exp) (eval-definition exp env))
          ((if? exp) (eval-if exp env))
          ((lambda? exp) (make-procedure (lambda-parameters exp)
                                         (lambda-body exp)
                                         env))
          ((begin? exp)
           (eval-sequence (begin-actions exp) env))
          ((cond? exp) (eval (cond->if exp) env))
          ((let? exp) (eval (let->combination exp) env))
          ((let*? exp) (eval (let*->nested-lets exp) env))
          ((letrec? exp) (eval (letrec->combination exp) env))
          ((and? exp) (eval-and (operands exp) env))
          ((or? exp) (eval-or (operands exp) env))
          ((not? exp) (eval (not->if exp) env))
          ((application? exp)
           (cond ((and normal-order? (not extent-normal-order?))
                  (apply-normal-order (actual-value (operator exp) env)
                                      (operands exp)
                                      env))
                 ((and normal-order? extent-normal-order?)
                  (apply-normal-order-extent (actual-value (operator exp) env)
                                             (operands exp)
                                             env))
                 (else (apply (eval (operator exp) env)
                              (list-of-values (operands exp) env)))))
          (else
            (error "Unknown expression type: EVAL" exp))))
  (define (apply procedure arguments)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure procedure arguments))
          ((compound-procedure? procedure)
           (eval-sequence
             (procedure-body procedure)
             (extend-environment
               (procedure-parameters procedure)
               arguments
               (procedure-environment procedure))))
          (else
            (error "Unknown procedure type: APPLY" procedure))))
  (define (list-of-values exps env)
    (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))
  (define (eval-if exp env)
    (if (true? (actual-value (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))
  (define (eval-sequence exps env)
    (cond ((last-exp? exps)
           (eval (first-exp exps) env))
          (else
            (eval (first-exp exps) env)
            (eval-sequence (rest-exps exps) env))))
  (define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env)
    'ok)
  (define (eval-definition exp env)
    (define-variable! (definition-variable exp)
                      (eval (definition-value exp) env)
                      env)
    'ok)
  (define (mock-list-of-values double) (set! list-of-values double))

  ; Delay evaluation implementation
  (define normal-order? #f)
  (define (switch-normal-order switch) (set! normal-order? switch))

  (define (actual-value exp env)
    (force-it (eval exp env)))
  (define (force-it obj)
    (cond ((thunk? obj)
           (let ((result (actual-value (thunk-exp obj)
                                       (thunk-env obj))))
             (set-car! obj 'evaluated-thunk)
             (set-car! (cdr obj)
                       result)
             (set-cdr! (cdr obj)
                       '())
             result))
          ((not-memoized-thunk? obj) (actual-value (thunk-exp obj) (thunk-env obj)))
          ((evaluated-thunk? obj) (thunk-value obj))
          (else obj)))
  (define (tagged-list? exp tag)
    (if (pair? exp)
      (eq? (car exp) tag)
      #f))
  (define (delay-it exp env)
    (list 'thunk exp env))
  (define (delay-it-not-memoized exp env)
    (list 'not-memoized-thunk exp env))
  (define (thunk? obj)
    (tagged-list? obj 'thunk))
  (define (thunk-exp thunk) (cadr thunk))
  (define (thunk-env thunk) (caddr thunk))
  (define (evaluated-thunk? obj)
    (tagged-list? obj 'evaluated-thunk))
  (define (thunk-value evaluated-thunk)
    (cadr evaluated-thunk))
  (define (not-memoized-thunk? obj)
    (tagged-list? obj 'not-memoized-thunk))

  (define (apply-normal-order procedure arguments env)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure
             procedure
             (list-of-arg-values arguments env)))
          ((compound-procedure? procedure)
           (eval-sequence
             (procedure-body procedure)
             (extend-environment
               (procedure-parameters procedure)
               (list-of-delayed-args arguments env)
               (procedure-environment procedure))))
          (else
            (error "Unknown procedure type: APPLY" procedure))))
  (define (list-of-arg-values exps env)
    (if (no-operands? exps)
      '()
      (cons (actual-value (first-operand exps)
                          env)
            (list-of-arg-values (rest-operands exps)
                                env))))
  (define (list-of-delayed-args exps env)
    (if (no-operands? exps)
      '()
      (cons (delay-it (first-operand exps)
                      env)
            (list-of-delayed-args (rest-operands exps)
                                  env))))

  ; Selective delayed and memoized arguments
  (define extent-normal-order? #f)
  (define (switch-extent-normal-order switch) (set! extent-normal-order? switch))
  (define (parameter-delayed? p)
    (and (pair? p) (eq? (cadr p) 'delay)))
  (define (parameter-delayed-memo? p)
    (and (pair? p) (eq? (cadr p) 'delay-memo)))
  (define (actual-parameter p)
    (if (pair? p)
      (car p)
      p))
  (define (apply-normal-order-extent procedure arguments env)
    (define (list-of-args-by-param-types params args env)
      (if (no-operands? args)
        '()
        (let ((rest (list-of-args-by-param-types (rest-operands params) (rest-operands args) env))
              (first-param (first-operand params))
              (first-arg (first-operand args)))
          (cond ((parameter-delayed? first-param)
                 (cons (delay-it-not-memoized first-arg env) rest))
                ((parameter-delayed-memo? first-param)
                 (cons (delay-it first-arg env) rest))
                (else
                  (cons (actual-value first-arg env) rest))))))
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure
             procedure
             (list-of-arg-values arguments env)))
          ((compound-procedure? procedure)
           (eval-sequence
             (procedure-body procedure)
             (extend-environment
               (map actual-parameter (procedure-parameters procedure))
               (list-of-args-by-param-types (procedure-parameters procedure) arguments env)
               (procedure-environment procedure))))
          (else
            (error "Unknown procedure type: APPLY" procedure))))

  ; Added by Exercise 4.4
  (define (eval-and exps env) (error "Not implemented: EVAL-AND"))
  (define (eval-or exps env) (error "Not implemented: EVAL-OR"))
  (define (implement-eval-and impl) (set! eval-and impl))
  (define (implement-eval-or impl) (set! eval-or impl))
  (define (dispatch m)
    (cond ((eq? m 'eval) actual-value)
          ((eq? m 'mock-list-of-values) mock-list-of-values)
          ((eq? m 'implement-eval-and) implement-eval-and)
          ((eq? m 'implement-eval-or) implement-eval-or)
          ((eq? m 'switch-normal-order) switch-normal-order)
          ((eq? m 'switch-extent-normal-order) switch-extent-normal-order)
          (else
            (error "Unknown operation" m))))
  dispatch)
