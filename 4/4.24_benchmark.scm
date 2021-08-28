(load "test.scm")
(load "4/4.24.scm")
(load "evaluator_test.scm")
(load "debug.scm")
(load "4/4.4.scm") ; new-derived-and-or-syntax
(load "4/4.6.scm") ; let syntax. NOTE: load after 4/4.4.scm where new-syntax are also defined.

(define (setup)
  (define s1
    (setup-test
      (lambda (syntax) (new-derived-and-or-syntax (new-syntax syntax)))
      '()
      (lambda (evaluator syntax env-model)
        (let ((impl (make-derived-and-or-implementation evaluator syntax env-model)))
          ((evaluator 'implement-eval-and) (car impl))
          ((evaluator 'implement-eval-or) (cdr impl))))))
  (define s2
    (setup-test-analyzing (lambda (syntax) (new-derived-and-or-syntax (new-syntax syntax))) '() '()))
  (cons s1 s2))

(define (benchmark)
  (let* ((suite (setup))
         (s1 (car suite))
         (s2 (cdr suite)))
    (define (bench-fn1 eval env)
      (eval fibonacci env)
      (with-print-time eval '(fibonacci 20) env))
    (define (bench-fn2 eval env)
      (define-queens eval env)
      (with-print-time eval '(queens 7) env))
    (newline) (display "Benchmark normal evaluator") (newline)
    (newline) (display "Fibonacci 20 workload") (newline)
    (s1 bench-fn1)
    (newline) (display "queens 7 workload") (newline)
    (s1 bench-fn2)
    (newline) (display "Benchmark analyzing evaluator") (newline)
    (newline) (display "Fibonacci 20 workload") (newline)
    (s2 bench-fn1)
    (newline) (display "queens 7 workload") (newline)
    (s2 bench-fn2)))
(benchmark)
; Benchmark normal evaluator
;
; Fibonacci 20 workload
;
; Applying #[compound-procedure 12 eval]
; Run time: 2.66s, GC time: .02s, Real time: 2.682s.
;
; queens 7 workload
;
; Applying #[compound-procedure 12 eval]
; Run time: 17.46s, GC time: .06s, Real time: 17.523s.
;
; Benchmark analyzing evaluator
;
; Fibonacci 20 workload
;
; Applying #[compound-procedure 13 eval]
; Run time: 1.33s, GC time: 0.s, Real time: 1.33s.
;
; queens 7 workload
;
; Applying #[compound-procedure 13 eval]
; Run time: 11.74s, GC time: .05s, Real time: 11.794s.

(define (test)
  (let* ((suite (setup))
         (s1 (car suite))
         (s2 (cdr suite)))
    (define (test-fn eval env)
      (define-queens eval env)
      (display (eval '(queens 7) env)))
    (s2 test-fn)))
