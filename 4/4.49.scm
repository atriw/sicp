(define generate-word
  '(define (parse-word word-list)
     (define (generate-word words)
       (if (null? words)
         (amb)
         (amb (list (car word-list) (car words)) (generate-word (cdr words)))))
     (generate-word (cdr word-list))))

