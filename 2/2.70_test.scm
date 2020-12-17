(load "../test.scm")
(load "2.68.scm")
(load "2.69.scm")

(define alphabet
  '((A 2) (GET 2) (SHA 3) (WAH 1)
          (BOOM 1) (JOB 2) (NA 16) (YIP 9)))

(define tree (generate-huffman-tree alphabet))

(define message
  '(Get a job
        Sha na na na na na na na na
        Get a job
        Sha na na na na na na na na
        Wah yip yip yip yip yip yip yip yip yip
        Sha boom))

(define bits
  (encode message tree))

(assert-eq 84 (length bits) "Failed")
(assert-eq message (decode bits tree) "Failed")
