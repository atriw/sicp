(load "test.scm")
(load "3/3.7.scm")

(define (test)
  (define peter-acc (make-account 100 'open-sesame))
  (define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
  (define wrong-acc (make-joint peter-acc 'wrong 'sun))
  (begin (assert-eq
           70
           ((peter-acc 'open-sesame 'withdraw) 30)
           "Failed withdraw peter")
         (assert-eq
           50
           ((paul-acc 'rosebud 'withdraw) 20)
           "Failed withdraw paul")
         (assert-eq
            80
            ((peter-acc 'open-sesame 'deposit) 30)
            "Failed deposit peter")
         (assert-eq
           "Incorrect password"
           ((wrong-acc 'sun 'withdraw) 30)
           "Failed withdraw wrong-acc")))
(test)
