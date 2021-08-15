(load "stream.scm")

(define (RLC R L C dt)
  (define (vi vc0 il0)
    (define vc
      (delayed-integral (delay dvc) vc0 dt))
    (define il
      (delayed-integral (delay dil) il0 dt))
    (define dvc
      (scale-stream il (/ -1 C)))
    (define dil
      (add-streams
        (scale-stream il (* -1 (/ R L)))
        (scale-stream vc (/ 1 L))))
    (cons vc il))
  vi)
