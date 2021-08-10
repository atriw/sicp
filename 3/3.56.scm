(load "stream.scm")

(define S
  (cons-stream 1
               (merge (scale-streams S 2)
                      (merge (scale-streams S 3)
                             (scale-streams S 5)))))
