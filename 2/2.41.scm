(load "2/2.17.scm")
(load "2/2.40.scm")

(define (three-sum n s)
  (map (lambda (pair)
         (append pair (list (fold-left - s pair))))
       (filter (lambda (pair)
                 (let ((last (fold-left - s pair)))
                   (and (> last 0) (< last (car (last-pair pair))))))
               (unique-pairs n))))
