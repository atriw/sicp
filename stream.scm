(define (add-streams s1 s2) (stream-map + s1 s2))

(define (scale-stream s f)
  (stream-map
    (lambda (x) (* x f)) s))

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< s1car s2car)
                   (cons-stream s1car (merge (stream-cdr s1) s2)))
                  ((> s1car s2car)
                   (cons-stream s2car (merge s1 (stream-cdr s2))))
                  (else
                    (cons-stream s1car (merge (stream-cdr s1) (stream-cdr s2)))))))))

(define ones
  (cons-stream 1 ones))

(define integers
  (cons-stream 1 (add-streams ones integers)))
