(load "test.scm")
(load "4/4.51.scm")
(load "evaluator_test.scm")
(load "4/4.4.scm")
(load "4/4.6.scm")
(load "stream.scm")
(load "debug.scm")

(define (test)
  (define test-suite
    (setup-test-amb (lambda (syntax) (new-permanent-assignment-syntax (new-derived-and-or-syntax (new-syntax syntax))))
                    '()
                    implement-analyze-permanent-assignment))
  (define (test-fn ambeval env)
    (ambeval '(define (f)
                (define count 0)
                (let ((x (an-element-of '(a b c)))
                      (y (an-element-of '(a b c))))
                  (permanent-set! count (+ count 1))
                  (require (not (eq? x y)))
                  (list x y count))) env nop-succeed nop-fail)
    (assert-stream (amb->stream ambeval '(f) env)
                   '((a b 2)
                     (a c 3)
                     (b a 4)
                     (b c 6)
                     (c a 7)
                     (c b 8))
                   "Failed permanent-set!")
    )
  (test-suite test-fn))
(test)
