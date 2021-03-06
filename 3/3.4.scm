(define (make-account balance secret)
  (define consecutive-incorrect-password 0)
  (define (call-the-cops x) "Call the cops")
  (define (handle-incorrect x)
    (begin (set! consecutive-incorrect-password (+ consecutive-incorrect-password 1))
           (if (>= consecutive-incorrect-password 7)
             (call-the-cops x)
             "Incorrect password")))
  (define (withdraw amount)
    (if (> amount balance)
      "Insufficient funds"
      (begin (set! balance (- balance amount))
             balance)))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define (dispatch password m)
    (if (not (eq? password secret))
      handle-incorrect
      (begin (set! consecutive-incorrect-password 0)
             (cond ((eq? m 'withdraw) withdraw)
                   ((eq? m 'deposit) deposit)
                   (else (error "Unknown request: MAKE-ACCOUNT" m))))))
  dispatch)
