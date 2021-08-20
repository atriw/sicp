(load "test.scm")
(load "4/4.7.scm")
(load "evaluator_test.scm")
(load "4/4.6.scm")

(define (test fold?)
  (define test-suite
    (setup-test (lambda (syntax) (new-let*-syntax (new-syntax syntax) fold?))
                '()))
  (define (test-fn eval env)
    (assert-eq 39 (eval '(let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z)) env) "Failed let*"))
  (test-suite test-fn))
(test #f)
(test #t)
