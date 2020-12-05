(define (for-each proc items)
  (if (null? items)
    'ok
    (begin (proc (car items))
           (for-each proc (cdr items)))))
