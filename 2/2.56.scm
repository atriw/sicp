(load "deriv.scm")

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (let ((u (base exp))
               (n (exponent exp)))
           (make-product n
                         (make-product
                           (make-exponentiation u (make-sum n -1))
                           (deriv u var)))))
        (else
          (error "unknown expression type: DERIV" exp))))

(define (make-exponentiation base exp)
  (cond ((=number? base 0) 0)
        ((or (=number? base 1) (=number? exp 0)) 1)
        ((=number? exp 1) base)
        ((and (number? base) (number? exp))
         (expt base exp))
        (else (list '** base exp))))
(define (exponentiation? exp) (and (pair? exp) (eq? (car exp) '**)))
(define base cadr)
(define exponent caddr)
