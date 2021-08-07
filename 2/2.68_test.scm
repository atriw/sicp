(load "test.scm")
(load "2/2.68.scm")

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define sample-symbols '(A D A B B C A))

(define (test)
  (begin (assert-eq sample-message (encode sample-symbols sample-tree) "Failed encode")
         (assert-eq sample-symbols (decode sample-message sample-tree) "Failed decode")))
(test)

(define (error-test)
  (begin (assert-error (lambda () (encode '(E) sample-tree)) "Failed error-test")
         (assert-error (lambda () (encode sample-symbols '())) "Failed error-test")))
(error-test)
