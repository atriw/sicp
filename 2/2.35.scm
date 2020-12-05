(load "../list.scm")

(define (count-leaves t)
  (accumulate + 0 (map (lambda (sub-t)
                         (if (pair? sub-t)
                           (count-leaves sub-t)
                           1))
                       t)))
