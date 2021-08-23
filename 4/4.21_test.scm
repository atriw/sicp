(load "test.scm")
(load "4/4.21.scm")

(define (test)
  (assert-eq 120
             ((lambda (n)
                ((lambda (fact) (fact fact n))
                 (lambda (ft k) (if (= k 1) 1 (* k (ft ft (- k 1)))))))
              5)
             "Failed factorial 5")
  (assert-eq 55
             (fibonacci 10)
             "Failed fibonacci 10")
  (assert-eq #t
             (f 14)
             "Failed even? 14"))
(test)
