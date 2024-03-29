(define (cycle? l)
  (define (cycle-iter x counted)
    (cond ((not (pair? x)) #f)
          ((memq x counted) #t)
          (else (let ((new-counted (cons x counted)))
                  (cycle-iter (cdr x) new-counted)))))
  (cycle-iter l '()))
