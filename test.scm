(define (equal p1 p2)
  (cond
        ((and (null? p1) (null? p2)) #t)
        ((and (null? p1) (not (null? p2))) #f)
        ((and (not (null? p1)) (null? p2)) #f)
        ((and (not (pair? p1)) (not (pair? p2))) (= p1 p2))
        ((and (pair? p1) (not (pair? p2))) #f)
        ((and (not (pair? p1)) (pair? p2)) #f)
        (else (and (equal (car p1) (car p2)) (equal (cdr p1) (cdr p2))))))

(define (assert op want got msg)
  (if (op want got)
    (begin (display "Test pass.") (newline))
    (error msg)))

(define (assert-eq want got msg)
  (assert = want got msg))

(define (assert-neq want got msg)
  (assert (lambda (x y) (not (= x y))) want got msg))

(define (assert-pair-eq want got msg)
  (assert equal want got msg))
