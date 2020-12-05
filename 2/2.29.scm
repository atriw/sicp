(define (make-mobile left right)
  (list left right))

(define (make-branch len structure)
  (list len structure))

(define left-branch car)
(define right-branch cadr)

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (branch-weight branch)
  (cond ((empty-branch? branch) 0)
        ((mobile-branch? branch) (total-weight (branch-structure branch)))
        (else (branch-structure branch))))

(define (branch-length branch)
  (if (empty-branch? branch) 0 (car branch)))
(define branch-structure cadr)

(define empty-branch? null?)
(define (mobile-branch? branch)
  (and (not (empty-branch? branch))
       (pair? (branch-structure branch))))
(define empty-branch '())

(define (balanced-mobile? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (= (* (branch-length left) (branch-weight left))
       (* (branch-length right) (branch-weight right)))))

