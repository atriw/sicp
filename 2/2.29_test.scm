(load "test.scm")
(load "2/2.29.scm")

(define branch1 (make-branch 10 7))
(define mobile1 (make-mobile branch1 empty-branch))
(define branch2 (make-branch 20 mobile1))
(define branch3 (make-branch 30 10))
(define mobile2 (make-mobile branch2 branch3))

(define (test-total-weight)
  (begin (assert-eq 17 (total-weight mobile2) "Failed total-weight")))
(test-total-weight)

(define branch4 (make-branch 7 20))
(define balanced-mobile (make-mobile branch2 branch4))

(define (test-balanced-mobile)
  (begin (assert-eq #f (balanced-mobile? mobile1) "Failed balanced-mobile? 1")
         (assert-eq #f (balanced-mobile? mobile2) "Failed balanced-mobile? 2")
         (assert-eq #t (balanced-mobile? balanced-mobile) "Failed balanced-mobile? balanced")))
(test-balanced-mobile)

