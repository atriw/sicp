(load "huffman.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (if (= (length set) 1)
    (car set)
    (let ((first (car set))
          (second (cadr set))
          (remaining (cddr set)))
      (successive-merge
        (adjoin-set
          (make-code-tree first second)
          remaining)))))
