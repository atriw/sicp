(load "../test.scm")
(load "2.63.scm")

(define tree1 (adjoin-set
                11
                (adjoin-set
                  5
                  (adjoin-set
                    1
                    (adjoin-set
                      9
                      (adjoin-set
                        3
                        (adjoin-set 7 '())))))))

(define tree2 (adjoin-set
                11
                (adjoin-set
                  9
                  (adjoin-set
                    5
                    (adjoin-set
                      7
                      (adjoin-set
                        1
                        (adjoin-set 3 '())))))))

(define tree3 (adjoin-set
                11
                (adjoin-set
                  7
                  (adjoin-set
                    1
                    (adjoin-set
                      9
                      (adjoin-set
                        3
                        (adjoin-set 5 '())))))))
