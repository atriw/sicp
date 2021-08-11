(load "test.scm")
(load "3/3.69.scm")

(define (test)
  (assert-stream pythagorean-triples
                 (list '(3 4 5) '(6 8 10) '(5 12 13))
                 "Failed pythagorean-triples"))
(test)
