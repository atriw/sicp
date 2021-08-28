(define generate-word
  '(define (parse-word word-list)
     (define (generate-word words)
       (if (null? words)
         (amb)
         (amb (list (car word-list) (car words)) (generate-word (cdr words)))))
     (generate-word (cdr word-list))))

(define generate-word-random
  '(define (parse-word word-list)
     (define (generate-word words)
       (if (null? words)
         (amb)
         (ramb (list (car word-list) (car words)) (generate-word (cdr words)))))
     (generate-word (cdr word-list))))
