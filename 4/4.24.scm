(define fibonacci
  '(define (fibonacci n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))))
; syntax requirements:
; - let
; - and
; - or
; - not
(define (define-queens eval env)
  (eval '(define (map proc sequence)
           (if (null? sequence)
             '()
             (cons (proc (car sequence)) (map proc (cdr sequence))))) env)
  (eval '(define (filter pred sequence)
           (if (null? sequence)
             '()
             (if (pred (car sequence))
               (cons (car sequence) (filter pred (cdr sequence)))
               (filter pred (cdr sequence))))) env)
  (eval '(define (enumerate-interval low high)
           (if (> low high)
             '()
             (cons low (enumerate-interval (+ 1 low) high)))) env)
  (eval '(define (accumulate op initial sequence)
           (if (null? sequence)
             initial
             (op (car sequence)
                 (accumulate op initial (cdr sequence))))) env)
  (eval '(define (flatmap proc sequence)
           (accumulate append '() (map proc sequence))) env)
  (eval '(define (queens board-size)
           (define (queen-cols k)
             (if (= k 0)
               (list empty-board)
               (filter
                 (lambda (positions) (safe? k positions))
                 (flatmap
                   (lambda (rest-of-queens)
                     (map
                       (lambda (new-row)
                         (adjoin-position
                           new-row k rest-of-queens))
                       (enumerate-interval 1 board-size)))
                   (queen-cols (- k 1))))))
           (queen-cols board-size)) env)
  (eval '(define make-position cons) env)
  (eval '(define row-position car) env)
  (eval '(define col-position cdr) env)
  (eval '(define empty-board '()) env)
  (eval '(define (adjoin-position row col board)
           (append board (list (make-position row col)))) env)
  (eval '(define (safe? col board)
           (let ((row (row-of-col board col)))
             (accumulate (lambda (cur result)
                           (let ((cur-col (col-position cur))
                                 (cur-row (row-position cur)))
                             (and result
                                  (or (= cur-col col)
                                      (not (or (= cur-row row)
                                               (= (abs (- cur-row row)) (abs (- cur-col col)))))))))
                         true
                         board))) env)
  (eval '(define (row-of-col board col)
           (row-position (list-ref board (- col 1)))) env)
  'ok)
