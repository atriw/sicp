(load "stream.scm")

(define (solve-2nd a b dt y0 dy0)
  (define y
    (delayed-integral (delay dy) y0 dt))
  (define dy
    (delayed-integral (delay ddy) dy0 dt))
  (define ddy
    (add-streams
      (scale-stream dy a)
      (scale-stream y b)))
  y)
