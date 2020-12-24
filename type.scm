(load-option 'hash-table)

(define global-table
  (make-equal-hash-table))

(define (put op type item)
  (hash-table/put! global-table (cons op type) item)
  'done)

(define (get op type)
  (hash-table/get global-table (cons op type) #f))

(define (attach-tag type-tag contents)
  (if (or
        (eq? type-tag 'symbol)
        (eq? type-tag 'scheme-number))
    contents
    (cons type-tag contents)))

(define (type-tag datum)
  (cond ((symbol? datum) 'symbol)
        ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum: TYPE-TAG" datum))))

(define (contents datum)
  (cond ((symbol? datum) datum)
        ((number? datum) 'scheme-number)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum: CONTENTS" datum))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (error
          "No method for these types: APPLY-GENERIC"
          (list op type-tags))))))
