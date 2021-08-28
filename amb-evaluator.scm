(define (make-amb-evaluator syntax environment-model)
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
  (define quoted? (syntax 'quote?)) ; should be 'quoted?
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

  ; Added by Exercise 4.22
  (define let? (syntax 'let?))
  (define let->combination (syntax 'let->combination))
  (define and? (syntax 'and?))
  (define or? (syntax 'or?))
  (define not? (syntax 'not?))
  (define and->if (syntax 'and->if))
  (define or->if (syntax 'or->if))
  (define not->if (syntax 'not->if))
  ; Added by Exercise 4.51
  (define permanent-assignment? (syntax 'permanent-assignment?))

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

  (define (tagged-list? exp tag)
    (if (pair? exp)
      (eq? (car exp) tag)
      #f))
  (define (amb? exp) (tagged-list? exp 'amb))
  (define (amb-choices exp) (cdr exp))
  (define (ramb? exp) (tagged-list? exp 'ramb))

  (define (ambeval exp env succeed fail)
    ((analyze exp) env succeed fail))

  (define (analyze exp)
    (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
          ((variable? exp) (analyze-variable exp))
          ((quoted? exp) (analyze-quoted exp))
          ((assignment? exp) (analyze-assignment exp))
          ((permanent-assignment? exp) (analyze-permanent-assignment exp))
          ((definition? exp) (analyze-definition exp))
          ((if? exp) (analyze-if exp))
          ((lambda? exp) (analyze-lambda exp))
          ((begin? exp) (analyze-sequence (begin-actions exp)))
          ((let? exp) (analyze (let->combination exp)))
          ((cond? exp) (analyze (cond->if exp)))
          ((and? exp) (analyze (and->if (operands exp))))
          ((or? exp) (analyze (or->if (operands exp))))
          ((not? exp) (analyze (not->if exp)))
          ((amb? exp) (analyze-amb exp))
          ((ramb? exp) (analyze-ramb exp))
          ((application? exp) (analyze-application exp))
          (else
            (error "Unknown expression type: ANALYZE" exp))))
  ; Simple expressions
  (define (analyze-self-evaluating exp)
    (lambda (env succeed fail)
      (succeed exp fail)))
  (define (analyze-quoted exp)
    (let ((qval (text-of-quotation exp)))
      (lambda (env succeed fail)
        (succeed qval fail))))
  (define (analyze-variable exp)
    (lambda (env succeed fail)
      (succeed (lookup-variable-value exp env) fail)))
  (define (analyze-lambda exp)
    (let ((vars (lambda-parameters exp))
          (bproc (analyze-sequence (lambda-body exp))))
      (lambda (env succeed fail)
        (succeed (make-procedure vars bproc env) fail))))
  ; Conditionals and sequences
  (define (analyze-if exp)
    (let ((pproc (analyze (if-predicate exp)))
          (cproc (analyze (if-consequent exp)))
          (aproc (analyze (if-alternative exp))))
      (lambda (env succeed fail)
        (pproc env
               (lambda (pred-value fail2)
                 (if (true? pred-value)
                   (cproc env succeed fail2)
                   (aproc env succeed fail2)))
               fail))))
  (define (analyze-sequence exps)
    (define (sequentially a b)
      (lambda (env succeed fail)
        (a env
           (lambda (a-value fail2)
             (b env succeed fail2))
           fail)))
    (let ((procs (map analyze exps)))
      (if (null? procs) (error "Empty sequence: ANALYZE"))
      (fold-left sequentially (car procs) (cdr procs))))
  ; Definitions and assignments
  (define (analyze-definition exp)
    (let ((var (definition-variable exp))
          (vproc (analyze (definition-value exp))))
      (lambda (env succeed fail)
        (vproc env
               (lambda (val fail2)
                 (define-variable! var val env)
                 (succeed 'ok fail2))
               fail))))
  (define (analyze-assignment exp)
    (let ((var (assignment-variable exp))
          (vproc (analyze (assignment-value exp))))
      (lambda (env succeed fail)
        (vproc env
               (lambda (val fail2)
                 (let ((old-value
                         (lookup-variable-value var env)))
                   (set-variable-value! var val env)
                   (succeed 'ok
                            (lambda ()
                              (set-variable-value!
                                var old-value env)
                              (fail2)))))
               fail))))
  ; Procedure applications
  (define (analyze-application exp)
    (let ((fproc (analyze (operator exp)))
          (aprocs (map analyze (operands exp))))
      (lambda (env succeed fail)
        (fproc env
               (lambda (proc fail2)
                 (get-args aprocs
                           env
                           (lambda (args fail3)
                             (execute-application
                               proc args succeed fail3))
                           fail2))
               fail))))
  (define (get-args aprocs env succeed fail)
    (if (null? aprocs)
      (succeed '() fail)
      ((car aprocs)
       env
       (lambda (arg fail2)
         (get-args
           (cdr aprocs)
           env
           (lambda (args fail3)
             (succeed (cons arg args) fail3))
           fail2))
       fail)))
  (define (execute-application proc args succeed fail)
    (cond ((primitive-procedure? proc)
           (succeed (apply-primitive-procedure proc args)
                    fail))
          ((compound-procedure? proc)
           ((procedure-body proc)
            (extend-environment
              (procedure-parameters proc)
              args
              (procedure-environment proc))
            succeed
            fail))
          (else
            (error "Unknown procedure type: EXECUTE-APPLICATION"
                   proc))))
  ; amb
  (define (analyze-amb exp)
    (let ((cprocs (map analyze (amb-choices exp))))
      (lambda (env succeed fail)
        (define (try-next choices)
          (if (null? choices)
            (fail)
            ((car choices)
             env
             succeed
             (lambda () (try-next (cdr choices))))))
        (try-next cprocs))))
  (define (analyze-ramb exp)
    (let ((cprocs (map analyze (amb-choices exp))))
      (lambda (env succeed fail)
        (define (try-next choices)
          (if (null? choices)
            (fail)
            ((car choices)
             env
             succeed
             (lambda () (try-next (cdr choices))))))
        (try-next (shuffle cprocs)))))
  (define (shuffle lst)
    (if (< (length lst) 2)
      lst
      (let ((item (list-ref lst (random (length lst)))))
        (cons item (shuffle (delete item lst))))))

  ; Added by Exercise 4.51
  (define (analyze-permanent-assignment _)
    (error "analyze-permanent-assignment not implemented."))
  (define (implement-analyze-permanent-assignment proc)
    (set! analyze-permanent-assignment proc))

  (define (dispatch m)
    (cond ((eq? m 'ambeval) ambeval)
          ((eq? m 'analyze) analyze)
          ((eq? m 'implement-analyze-permanent-assignment) implement-analyze-permanent-assignment)
          (else
            (error "Unknown operation" m))))
  dispatch)
