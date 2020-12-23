(load "../type.scm")

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define variable? symbol?)
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum-deriv exp var)
  (make-sum (deriv (addend exp) var)
            (deriv (augend exp) var)))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (attach-tag '+ (list a1 a2)))))
(define addend car)
(define augend cadr)

(define (product-deriv exp var)
  (make-sum (make-product
              (multiplier exp)
              (deriv (multiplicand exp) var))
            (make-product
              (deriv (multiplier exp) var)
              (multiplicand exp))))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2))
         (* m1 m2))
        (else (attach-tag '* (list m1 m2)))))
(define (=number? exp num) (and (number? exp) (= exp num)))
(define multiplier car)
(define multiplicand cadr)

(define (exponentiation-deriv exp var)
  (let ((u (base exp))
        (n (exponent exp)))
    (make-product n
                  (make-product
                    (make-exponentiation u (make-sum n -1))
                    (deriv u var)))))
(define (make-exponentiation base exp)
  (cond ((=number? base 0) 0)
        ((or (=number? base 1) (=number? exp 0)) 1)
        ((=number? exp 1) base)
        ((and (number? base) (number? exp))
         (expt base exp))
        (else (attach-tag '** (list base exp)))))
(define base car)
(define exponent cadr)

(put 'deriv '+ sum-deriv)
(put 'deriv '* product-deriv)
(put 'deriv '** exponentiation-deriv)