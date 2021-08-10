(load "stream.scm")

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams
                 (scale-stream (stream-cdr s1) (stream-car s2))
                 (mul-series s1 (stream-cdr s2)))))
; (a0+a1*x+a2*x^2...) * (b0+b1*x...)
; = a0*b0 + b0 * (a1*x+a2*x^2...) + (b1*x+b2*x^2...) * (a0+a1*x+a2*x^2...)
; = a0*b0 + b0 * (a1*x+a2*x^2...) + x * (b1+b2*x+b3*x^2...) * (a0+a1*x+a2*x^2...)
; = a0*b0 + x * (b0 * (a1+a2*x...) + (b1+b2*x...) * (a0+a1*x...))
; = (cons a0*b0
;      (add-streams
;          (scale-stream (cdr A) b0)
;          (mul-series A (cdr B))))
