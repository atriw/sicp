(load "test.scm")
(load "3/3.3.scm")

(define (test)
  (let ((acc (make-account 100 'some-password)))
    (begin (assert-eq 70 ((acc 'some-password 'withdraw) 30) "Failed withdraw")
           (assert-eq "Insufficient funds" ((acc 'some-password 'withdraw) 80) "Failed withdraw")
           (assert-eq "Incorrect password" ((acc 'incorrect-password 'withdraw) 30) "Failed incorrect password"))))
(test)
