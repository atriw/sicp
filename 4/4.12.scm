(define (new-evironment-model env-model)
  (define (enclosing-environment env) (cdr env))
  (define (first-frame env) (car env))
  (define the-empty-environment '())

  (define (make-frame variables values)
    (cons variables values))
  (define (frame-variables frame) (car frame))
  (define (frame-values frame) (cdr frame))
  (define (add-binding-to-frame! var val frame)
    (set-car! frame (cons var (car frame)))
    (set-cdr! frame (cons val (cdr frame))))
  (define (traverse-env var fn-vals fn-frame env)
    (define loop-down? (null? fn-frame))
    (define (env-loop env)
      (define (scan vars vals frame)
        (cond ((null? vars)
               (if loop-down?
                 (env-loop (enclosing-environment env))
                 (fn-frame frame)))
              ((eq? var (car vars)) (fn-vals vals))
              (else (scan (cdr vars) (cdr vals) frame))))
      (if (and loop-down? (eq? env the-empty-environment))
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)
                frame))))
    (env-loop env))
  (define (lookup-variable-value var env)
    (traverse-env var car '() env))
  (define (set-variable-value! var val env)
    (traverse-env var
                  (lambda (vals) (set-car! vals val))
                  '()
                  env))
  (define (define-variable! var val env)
    (traverse-env var
                  (lambda (vals) (set-car! vals val))
                  (lambda (frame) (add-binding-to-frame! var val frame))
                  env))
  (define (dispatch m)
    (cond ((eq? m 'lookup-variable-value) lookup-variable-value)
          ((eq? m 'set-variable-value!) set-variable-value!)
          ((eq? m 'define-variable!) define-variable!)
          (else (env-model m))))
  dispatch)
