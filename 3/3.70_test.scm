(load "test.scm")
(load "3/3.70.scm")

(define (test)
  (define (divisiable-two-three-five x)
    (or (= 0 (remainder x 2))
        (= 0 (remainder x 3))
        (= 0 (remainder x 5))))
  (let ((ordered-by-sum (weighted-pairs integers integers (lambda (p) (+ (car p) (cadr p)))))
        (not-two-three-five (stream-filter (lambda (x) (not (divisiable-two-three-five x))) integers)))
    (let ((ordered-not-two-three-five-pairs
            (weighted-pairs not-two-three-five not-two-three-five (lambda (p) (+ (* 2 (car p)) (* 3 (cadr p)) (* 5 (car p) (cadr p)))))))
      (display-stream ordered-by-sum 6)
      (assert-stream ordered-by-sum
                     (list '(1 1) '(1 2) '(1 3) '(2 2) '(1 4) '(2 3))
                     "Failed weighted-pairs ordered-by-sum")
      (display-stream ordered-not-two-three-five-pairs 6)
      (assert-stream ordered-not-two-three-five-pairs
                     (list '(1 1) '(1 7) '(1 11) '(1 13) '(1 17) '(1 19))
                     "Failed weighted-pairs ordered-not-two-three-five-pairs"))))
(test)
