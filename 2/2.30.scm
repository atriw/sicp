(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (map square-tree-map tree))))
