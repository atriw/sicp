(load "stream.scm")
(load "3/3.70.scm")

(define (ramanujan-numbers)
  (define ramanujan-stream
    (weighted-pairs integers integers (lambda (p) (+ (cube (car p)) (cube (cadr p))))))
  (let ((s (stream-map (lambda (p) (+ (cube (car p)) (cube (cadr p)))) ramanujan-stream)))
    (define (iter s1 s2)
      (if (= (stream-car s1) (stream-car s2))
        (cons-stream (stream-car s1)
                     (iter (stream-cdr s1) (stream-cdr s2)))
        (iter (stream-cdr s1) (stream-cdr s2))))
    (iter s (stream-cdr s))))
