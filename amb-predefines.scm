(define nop-succeed
  (lambda (val fail) val))
(define nop-fail
  (lambda () 'fail))

(define (amb-predefines ambeval env)
  (let ((defines (list
                   '(define (require p) (if (not p) (amb)))
                   '(define (map proc sequence)
                      (if (null? sequence)
                        '()
                        (cons (proc (car sequence)) (map proc (cdr sequence)))))
                   '(define (enumerate-interval low high)
                      (if (> low high)
                        '()
                        (cons low (enumerate-interval (+ 1 low) high))))
                   '(define (accumulate op init sequence)
                      (if (null? sequence)
                        init
                        (accumulate op (op (car sequence) init) (cdr sequence))))
                   '(define (distinct? items)
                      (cond ((null? items) true)
                            ((null? (cdr items)) true)
                            ((member (car items) (cdr items)) false)
                            (else (distinct? (cdr items)))))
                   '(define (an-element-of lst)
                      (if (null? lst)
                        (amb)
                        (amb (car lst) (an-element-of (cdr lst)))))
                   '(define (an-integer-starting-from n)
                      (amb n (an-integer-starting-from (+ n 1)))))))
    (for-each (lambda (def) (ambeval def env nop-succeed nop-fail)) defines)))

(define (amb->stream ambeval exp env)
  (ambeval exp env
           (lambda (val fail)
             (cons-stream val (fail)))
           (lambda () '())))

(define (drain-amb ambeval exp env)
  (ambeval exp env
           (lambda (val fail)
             (+ 1 (fail)))
           (lambda () 0)))
