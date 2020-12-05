(define (deep-reverse items)
  (if (or (not (pair? items)) (null? items)) items
        (reverse (map deep-reverse items))))
