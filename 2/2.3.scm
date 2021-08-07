(load "2/2.2.scm")

(define (length-segment s)
  (let ((start (start-segment s))
        (end (end-segment s)))
    (let ((x (- (x-point end) (x-point start)))
          (y (- (y-point end) (y-point start))))
      (sqrt (+ (* x x) (* y y))))))

(define (make-rect1 p1 p2 p3)
  (list p1 p2 p3))

(define first-rect1 car)
(define second-rect1 cadr)
(define third-rect1 caddr)

(define (length-rect1 rect1)
  (let ((p1 (first-rect1 rect1))
        (p2 (second-rect1 rect1))
        (p3 (third-rect1 rect1)))
    (list (length-segment (make-segment p1 p2))
          (length-segment (make-segment p1 p3)))))

(define (make-rect2 s1 s2)
  (list s1 s2))

(define (length-rect2 rect2)
  (map length-segment rect2))

(define (width length-rect)
  (lambda (rect) (apply min (length-rect rect))))

(define (height length-rect)
  (lambda (rect) (apply max (length-rect rect))))

(define (perimeter length-rect)
  (lambda (rect)
    (let ((w (width length-rect))
          (h (height length-rect)))
      (* 2 (+ (w rect) (h rect))))))

(define (area length-rect)
  (lambda (rect)
    (let ((w (width length-rect))
          (h (height length-rect)))
      (* (w rect) (h rect)))))

