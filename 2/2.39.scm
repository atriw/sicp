(define (reverse-left sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))

(define (reverse-right sequence)
  (fold-right (lambda (x y) (append y (list x))) '() sequence))
