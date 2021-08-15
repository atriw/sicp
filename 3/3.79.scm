(load "stream.scm")
(load "3/3.78.scm")

(define (genaral-solve-2nd f dt y0 dy0)
  (define y
    (delayed-integral (delay dy) y0 dt))
  (define dy
    (delayed-integral (delay ddy) dy0 dt))
  (define ddy
    (stream-map f dy y))
  y)
