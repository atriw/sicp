(define (make-syntax)
  ; exps ::= exp exps | epsilon
  ; symbols ::= symbol symbols | epsilon
  ; self-evaluating ::= number | string
  ; variable ::= symbol
  ; quote ::= 'quote symbol
  ; assignment ::= 'set! variable exp
  ; definition ::= 'define variable exp | 'define symbols exps
  ; if ::= 'if exp exp | 'if exp exp exp
  ; lambda ::= 'lambda symbols exps
  ; begin ::= 'begin exps
  ; cond ::= 'cond clauses
  ; clauses ::= clause clauses | epsilon
  ; clause ::= exp exps | 'else exps
  ; application ::= exps
  (define (self-evaluating? exp)
    (cond ((number? exp) #t)
          ((string? exp) #t)
          (else #f)))
  (define (variable? exp) (symbol? exp))
  (define (quote? exp) (tagged-list? exp 'quote))
  (define (text-of-quotation exp) (cadr exp))
  (define (tagged-list? exp tag)
    (if (pair? exp)
      (eq? (car exp) tag)
      #f))
  (define (assignment? exp) (tagged-list? exp 'set!))
  (define (assignment-variable exp) (cadr exp))
  (define (assignment-value exp) (caddr exp))
  (define (definition? exp) (tagged-list? exp 'define))
  (define (definition-variable exp)
    (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))
  (define (definition-value exp)
    (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)
                   (cddr exp))))
  (define (lambda? exp) (tagged-list? exp 'lambda))
  (define (lambda-parameters exp) (cadr exp))
  (define (lambda-body exp) (cddr exp))
  (define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))
  (define (if? exp) (tagged-list? exp 'if))
  (define (if-predicate exp) (cadr exp))
  (define (if-consequent exp) (caddr exp))
  (define (if-alternative exp)
    (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
  (define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))
  (define (begin? exp) (tagged-list? exp 'begin))
  (define (begin-actions exp) (cdr exp))
  (define (last-exp? seq) (null? (cdr seq)))
  (define (first-exp seq) (car seq))
  (define (rest-exps seq) (cdr seq))
  (define (sequence->exp seq)
    (cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
          (else (make-begin seq))))
  (define (make-begin seq) (cons 'begin seq))
  (define (application? exp) (pair? exp))
  (define (operator exp) (car exp))
  (define (operands exp) (cdr exp))
  (define (no-operands? ops) (null? ops))
  (define (first-operand ops) (car ops))
  (define (rest-operands ops) (cdr ops))
  (define (cond? exp) (tagged-list? exp 'cond))
  (define (cond-clauses exp) (cdr exp))
  (define (cond-else-clause? clause)
    (eq? (cond-predicate clause) 'else))
  (define (cond-predicate clause) (car clause))
  (define (cond-actions clause) (cdr clause))
  (define (cond->if exp) (expand-clauses (cond-clauses exp)))
  (define (expand-clauses clauses)
    (if (null? clauses)
      #f
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
          (if (null? rest)
            (sequence->exp (cond-actions first))
            (error "ELSE clause isn't last: COND->IF"
                   clauses))
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest))))))
  (define (dispatch m)
    (cond ((eq? m 'self-evaluating?) self-evaluating?)
          ((eq? m 'variable?) variable?)
          ((eq? m 'quote?) quote?)
          ((eq? m 'text-of-quotation) text-of-quotation)
          ((eq? m 'assignment?) assignment?)
          ((eq? m 'definition?) definition?)
          ((eq? m 'if?) if?)
          ((eq? m 'lambda?) lambda?)
          ((eq? m 'lambda-parameters) lambda-parameters)
          ((eq? m 'lambda-body) lambda-body)
          ((eq? m 'begin?) begin?)
          ((eq? m 'begin-actions) begin-actions)
          ((eq? m 'cond?) cond?)
          ((eq? m 'cond->if) cond->if)
          ((eq? m 'application?) application?)
          ((eq? m 'operator) operator)
          ((eq? m 'operands) operands)
          ((eq? m 'no-operands?) no-operands?)
          ((eq? m 'first-operand) first-operand)
          ((eq? m 'rest-operands) rest-operands)
          ((eq? m 'if-predicate) if-predicate)
          ((eq? m 'if-consequent) if-consequent)
          ((eq? m 'if-alternative) if-alternative)
          ((eq? m 'last-exp?) last-exp?)
          ((eq? m 'first-exp) first-exp)
          ((eq? m 'rest-exps) rest-exps)
          ((eq? m 'assignment-variable) assignment-variable)
          ((eq? m 'assignment-value) assignment-value)
          ((eq? m 'definition-variable) definition-variable)
          ((eq? m 'definition-value) definition-value)
          ; Added by Exercise 4.4
          ; Not implemented.
          ((eq? m 'and?) (lambda (exp) #f))
          ((eq? m 'or?) (lambda (exp) #f))
          ; Added by Exercise 4.4
          ((eq? m 'make-if) make-if)
          ; Added by Exercise 4.5
          ((eq? m 'sequence->exp) sequence->exp)
          ; Added by Exercise 4.6
          ; Not implemented.
          ((eq? m 'let?) (lambda (exp) #f))
          ((eq? m 'let->combination) (lambda (exp) (error "let->combination not implemented.")))
          ; Added by Exercise 4.6
          ((eq? m 'make-lambda) make-lambda)
          ; Added by Exercise 4.7
          ; Not implemented.
          ((eq? m 'let*?) (lambda (exp) #f))
          ((eq? m 'let*->nested-lets) (lambda (exp) (error "let*->nested-lets not implemented.")))
          ; Added by Exercise 4.8
          ((eq? m 'make-begin) make-begin)
          ; Added by Exercise 4.16
          ((eq? m 'make-quote) (lambda (text) (list 'quote text)))
          ; Added by Exercise 4.20
          ((eq? m 'letrec?) (lambda (exp) #f))
          ((eq? m 'letrec->combination) (lambda (exp) (error "letrec->combination not implemented.")))
          ; Added by Exercise 4.24
          ((eq? m 'not?) (lambda (exp) #f))
          ((eq? m 'not->if) (lambda (exp) (error "not->if not implemented.")))
          ((eq? m 'and->if) (lambda (exp) (error "and->if not implemented.")))
          ((eq? m 'or->if) (lambda (exp) (error "or->if not implemented.")))
          ; Added by Exercise 4.51
          ((eq? m 'permanent-assignment?) (lambda (exp) #f))
          ; Added by Exercise 4.52
          ((eq? m 'if-fail?) (lambda (exp) #f))
          (else
            (error "Unknown syntax" m))))
  dispatch)
