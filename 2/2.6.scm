(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (add-1 zero))
(define two (add-1 one))

(define (add a b)
  (lambda (f) (lambda (x) ((b f) ((a f) x)))))

(define four (add two two))

(define (mul a b)
  (lambda (f) (lambda (x) ((a (b f)) x))))

(define eight (mul two four))
