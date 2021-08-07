(load "test.scm")
(load "2/2.69.scm")
(load "2/2.68.scm")

(define sample-tree (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define sample-symbols '(A D A B B C A))

(define (test)
  (begin (assert-eq sample-message (encode sample-symbols sample-tree) "Failed encode")
         (assert-eq sample-symbols (decode sample-message sample-tree) "Failed decode")))
(test)
