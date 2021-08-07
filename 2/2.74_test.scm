(load "test.scm")
(load "2/2.74.scm")

(install-division-1)
(install-division-2)

(define xiaoming
  (make-record 'division-1 'xiaoming 10))

(define zhangsan
  (make-record 'division-1 'zhangsan 20))

(define dante
  (make-record 'division-2 'dante 30))

(define vergil
  (make-record 'division-2 'vergil 40))

(define file1
  (make-file 'division-1 xiaoming zhangsan))

(define file2
  (make-file 'division-2 dante vergil))

(define (test)
  (begin (assert-eq 10 (get-salary (get-record 'xiaoming file1)) "Failed")
         (assert-eq 20 (get-salary (get-record 'zhangsan file1)) "Failed")
         (assert-eq 30 (get-salary (get-record 'dante file2)) "Failed")
         (assert-eq 40 (get-salary (get-record 'vergil file2)) "Failed")
         (assert-eq #f (find-employee-record 'v (list file1 file2)) "Failed")))
(test)
