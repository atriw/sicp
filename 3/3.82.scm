(load "monte-carlo.scm")

(define (random-in-range low high)
  (cons-stream
    (+ low (random (- high low)))
    (random-in-range low high)))

(define (estimate-integral-stream P x1 x2 y1 y2)
  (let ((area (abs (* (- y2 y1) (- x2 x1)))))
    (stream-map
      (lambda (x) (* area x))
      (monte-carlo-stream
        (stream-map
          P
          (random-in-range (min x1 x2) (max x1 x2))
          (random-in-range (min y1 y2) (max y1 y2)))
        0 0))))
