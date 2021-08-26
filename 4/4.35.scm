(define an-integer-between
  '(define (an-integer-between low high)
     (if (or (> low high) (= low high))
       (amb)
       (amb low (an-integer-between (+ low 1) high)))))

(define a-pythagorean-triple-between
  '(define (a-pythagorean-triple-between low high)
     (let ((i (an-integer-between low high)))
       (let ((j (an-integer-between i high)))
         (let ((k (an-integer-between j high)))
           (require (= (+ (* i i) (* j j)) (* k k)))
           (list i j k))))))
