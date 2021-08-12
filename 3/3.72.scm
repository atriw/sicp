(load "stream.scm")
(load "3/3.70.scm")

(define (sum-of-two-square-in-three-different-ways)
  (define (weight p)
    (+ (square (car p)) (square (cadr p))))
  (define sum-of-two-square-pairs
    (weighted-pairs integers integers weight))
  (define (iter s1 s2 s3)
    (if (= (weight (stream-car s1)) (weight (stream-car s2)) (weight (stream-car s3)))
      (cons-stream
        (list (weight (stream-car s1)) (stream-car s1) (stream-car s2) (stream-car s3))
        (iter (stream-cdr s1) (stream-cdr s2) (stream-cdr s3)))
      (iter (stream-cdr s1) (stream-cdr s2) (stream-cdr s3))))
  (iter sum-of-two-square-pairs
        (stream-cdr sum-of-two-square-pairs)
        (stream-cdr (stream-cdr sum-of-two-square-pairs))))
