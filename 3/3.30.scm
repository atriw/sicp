(load "circuit-simulate.scm")

(define (ripple-carry-adder A B S C)
  (define (iter a b s c-in)
    (cond ((and (null? a) (null? b) (null? s)) 'ok)
          ((or (null? a) (null? b) (null? s))
           (error "Unmatch number of wires"))
          (else
            (let ((c-out (make-wire))
                  (an (car a))
                  (bn (car b))
                  (sn (car s)))
              (full-adder an bn c-in sn c-out)
              (iter (cdr a) (cdr b) (cdr s) c-out)))))
  (iter A B S C))
