(load "test.scm")
(load "3/3.78.scm")

(define dt 0.0001)
(define pi 31415)

(define (test)
  ; let a = 4, b = -5
  ; y`` - 4 y` + 5y = 0
  ; => y = C1 e^2x cosx + C2 e^2x sinx
  ;    y(0) = y0 = C1
  ;    y` = C1(2*e^2x cosx - e^2x sinx) + C2(2*e^2x sinx + e^2x cosx)
  ;       = e^2x (2C1+C2 cosx + 2C2-C1 sinx)
  ;    y`(0) = dy0 = 2C1+C2
  ; let y0 = 1, dy0 = 3
  ; => C1 = 1, C2 = 1
  ; y(pi/2) = e^pi    = 23.1406
  ; y(pi)   = -e^2*pi = -535.4916
  (let ((y (solve-2nd 4 -5 dt 1 3)))
    (define (equal-with-tolerance x y) (> 1 (abs (- x y))))
    (assert equal-with-tolerance 23.1406 (stream-ref y (quotient pi 2)) "Failed y(pi/2)")
    (assert equal-with-tolerance -535.4916 (stream-ref y pi) "Failed y(pi)")))
(test)

(define (test2)
  (define (equal-with-tolerance x y) (< (abs (- x y)) 0.001))
  (assert equal-with-tolerance
          (stream-ref (solve-2nd 1 0 dt 1 1) 10000)
          2.718
          "Failed e")
  (assert equal-with-tolerance
          ; y = C1cosx + C2sinx
          ; y0 = C1
          ; dy0 = C2
          (stream-ref (solve-2nd 0 -1 dt 1 0) (quotient pi 3))
          0.5
          "Failed cos(pi/3)")
  (assert equal-with-tolerance
          (stream-ref (solve-2nd 0 -1 dt 0 1) (quotient pi 6))
          0.5
          "Failed sin(pi/6)"))
(test2)
