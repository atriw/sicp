(load "list.scm")

(define (queens board-size)
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
  (queen-cols board-size))

(define make-position cons)
(define row-position car)
(define col-position cdr)

(define empty-board '())
(define (adjoin-position row col board)
  (append board (list (make-position row col))))

(define (safe? col board)
  (let ((row (row-of-col board col)))
    (accumulate (lambda (cur result)
                  (let ((cur-col (col-position cur))
                        (cur-row (row-position cur)))
                    (and result
                         (or (= cur-col col)
                             (not (or (= cur-row row)
                                      (= (abs (- cur-row row)) (abs (- cur-col col)))))))))
                #t
                board)))

(define (row-of-col board col)
  (row-position (list-ref board (- col 1))))
