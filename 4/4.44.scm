(define queens
  '(define (queens n)
     (define (integer-between low high)
       (if (> low high)
         (amb)
         (amb low (integer-between (+ 1 low) high))))
     (define make-position cons)
     (define row-position car)
     (define col-position cdr)
     (define (safe? col board)
       (let ((row (row-of-col board col)))
         (accumulate (lambda (cur result)
                       (let ((cur-col (col-position cur))
                             (cur-row (row-position cur)))
                         (and result
                              (or (= cur-col col)
                                  (not (or (= cur-row row)
                                           (= (abs (- cur-row row)) (abs (- cur-col col)))))))))
                     true
                     board)))
     (define (row-of-col board col)
       (row-position (list-ref board (- col 1))))
     (define (adjoin-position row col board)
       (append board (list (make-position row col))))
     (define (queen-cols k)
       (if (= k 0)
         '()
         (let ((rest-of-queens (queen-cols (- k 1))))
           (let ((new-board (adjoin-position (integer-between 1 n) k rest-of-queens)))
             (require (safe? k new-board))
             new-board))))
     (queen-cols n)))

