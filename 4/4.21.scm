(define fibonacci
  (lambda (n)
    ((lambda (fib) (fib fib n))
     (lambda (f k)
       (cond ((= k 0) 0)
             ((= k 1) 1)
             (else (+ (f f (- k 1)) (f f (- k 2)))))))))

(define (f x)
  ((lambda (even? odd?) (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) #t (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) #f (ev? ev? od? (- n 1))))))
