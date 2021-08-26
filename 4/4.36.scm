; Dead loop
(define a-pythagorean-triple-dead-loop
  '(define (a-pythagorean-triple)
     (let ((i (an-integer-starting-from 1)))
       (let ((j (an-integer-starting-from i)))
         (let ((k (an-integer-starting-from j)))
           (require (= (+ (* i i) (* j j)) (* k k)))
           (list i j k))))))

(define a-pythagorean-triple
  '(define (a-pythagorean-triple)
     (define (an-integer-between low high)
       (if (or (> low high) (= low high))
         (amb)
         (amb low (an-integer-between (+ low 1) high))))
     (let ((k (an-integer-starting-from 1)))
       (let ((i (an-integer-between 1 k)))
         (let ((j (an-integer-between i k)))
           (require (= (+ (* i i) (* j j)) (* k k)))
           (list i j k))))))
