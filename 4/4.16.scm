(define (new-environment-model env-model syntax)
  (define make-quote (syntax 'make-quote))
  (define make-let (syntax 'make-let))
  (define definition? (syntax 'definition?))
  (define definition-variable (syntax 'definition-variable))
  (define definition-value (syntax 'definition-value))
  (define (make-application operator operands)
    (cons operator operands))

  (define (scan-out-defines body)
    (define (scan exps defines others)
      (if (null? exps)
        (cons defines others)
        (if (definition? (car exps))
          (scan (cdr exps) (append defines (list (car exps))) others)
          (scan (cdr exps) defines (append others (list (car exps)))))))
    (define (definition->binding exp)
      (list (definition-variable exp) (make-quote '*unassigned*)))
    (define (definition->set! exp)
      (make-application 'set! (list (definition-variable exp) (definition-value exp))))
    (let* ((scaned (scan body '() '()))
           (defines (car scaned))
           (others (cdr scaned)))
      (if (null? defines)
        others
        (list (make-let (map definition->binding defines)
                        (append (map definition->set! defines) others))))))

  (define (make-procedure parameters body env)
    (list 'procedure parameters (scan-out-defines body) env))

  (define (enclosing-environment env) (cdr env))
  (define (first-frame env) (car env))
  (define the-empty-environment '())
  (define (frame-variables frame) (car frame))
  (define (frame-values frame) (cdr frame))
  (define (lookup-variable-value var env)
    (define (env-loop env)
      (define (scan vars vals)
        (cond ((null? vars)
               (env-loop (enclosing-environment env)))
              ((eq? var (car vars))
               (if (eq? '*unassigned* (car vals))
                 (error "Unassigned variable" var)
                 (car vals)))
              (else (scan (cdr vars) (cdr vals)))))
      (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
    (env-loop env))
  (define (dispatch m)
    (cond ((eq? m 'lookup-variable-value) lookup-variable-value)
          ((eq? m 'make-procedure) make-procedure)
          (else (env-model m))))
  dispatch)
