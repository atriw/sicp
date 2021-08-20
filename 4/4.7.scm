(define (new-let*-syntax syntax fold?)
  (define (tagged-list? exp tag)
    (if (pair? exp)
      (eq? (car exp) tag)
      #f))
  (define make-let (syntax 'make-let))

  (define (let*? exp) (tagged-list? exp 'let*))
  (define (let*-bindings exp) (cadr exp))
  (define (let*-body exp) (cddr exp))
  (define (let*->nested-lets exp)
    (define (iter-bindings bindings)
      (if (null? bindings)
        (let*-body exp)
        (list (make-let (list (car bindings)) (iter-bindings (cdr bindings))))))
    (car (iter-bindings (let*-bindings exp))))
  (define (let*->nested-lets-fold exp)
    (car (fold-right (lambda (binding body)
                       (list (make-let (list binding) body)))
                     (let*-body exp)
                     (let*-bindings exp))))
  (define (dispatch m)
    (cond ((eq? m 'let*?) let*?)
          ((and (not fold?) (eq? m 'let*->nested-lets)) let*->nested-lets)
          ((and fold? (eq? m 'let*->nested-lets)) let*->nested-lets-fold)
          (else (syntax m))))
  dispatch)
