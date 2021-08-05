(define (cycle? l)
  (define (cycle-iter slow fast)
    (cond ((or (null? slow) (null? fast)) #f)
          ((eq? slow fast) #t)
          ((null? (cdr fast)) #f)
          (else (cycle-iter (cdr slow) (cddr fast)))))
  (if (or (null? l) (null? (cdr l)))
    #f
    (cycle-iter (cdr l) (cddr l))))
