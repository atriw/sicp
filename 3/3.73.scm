(load "stream.scm")

(define (RC R C dt)
  (define (v i v0)
    (add-streams
      (scale-stream i R)
      (integral (scale-stream i (/ 1. C)) v0 dt)))
  v)
