(load "type.scm")

(define (make-file type . records)
  (let ((file/cons (get 'make-file type)))
    (if file/cons
      (apply file/cons records)
      (error "Unregistered type: MAKE-FILE" type))))

(define (make-record type name salary)
  (let ((record/cons (get 'make-record type)))
    (if record/cons
      (record/cons name salary)
      (error "Unregistered type: MAKE-RECORD" type))))

(define (get-record name file)
  (apply-generic 'get-record name file))

(define (get-salary record)
  (apply-generic 'get-salary record))

(define (find-employee-record name files)
  (if (null? files)
    #f
    (let ((first (get-record name (car files))))
        (if first first (find-employee-record name (cdr files))))))

(define (get-name record)
  (apply-generic 'get-name record))

(define (install-division-1)
  (if (not (get 'make-record 'list-record)) (install-list-record) 'done)
  (if (not (get 'make-file 'list-file)) (install-list-file) 'done)
  (put 'make-record 'division-1
       (get 'make-record 'list-record))
  (put 'make-file 'division-1
       (get 'make-file 'list-file))
  'done)

(define (install-division-2)
  (if (not (get 'make-record 'pair-record)) (install-pair-record) 'done)
  (if (not (get 'make-file 'hash-table-file)) (install-hash-table-file) 'done)
  (put 'make-record 'division-2
       (get 'make-record 'pair-record))
  (put 'make-file 'division-2
       (get 'make-file 'hash-table-file))
  'done)

(define (install-list-record)
  (define (make-record name salary)
    (list name salary))
  (define record-name car)
  (define record-salary cadr)
  (define (tag x) (attach-tag 'list-record x))
  (put 'get-name '(list-record) record-name)
  (put 'get-salary '(list-record) record-salary)
  (put 'make-record 'list-record
       (lambda (name salary)
         (tag (make-record name salary))))
  'done)

(define (install-pair-record)
  (define (make-record name salary)
    (cons name salary))
  (define record-name car)
  (define record-salary cdr)
  (define (tag x) (attach-tag 'pair-record x))
  (put 'get-name '(pair-record) record-name)
  (put 'get-salary '(pair-record) record-salary)
  (put 'make-record 'pair-record
       (lambda (name salary)
         (tag (make-record name salary))))
  'done)

(define (install-list-file)
  (define (make-file . records)
    records)
  (define (get-record name file)
    (cond ((null? file) #f)
          ((equal? name (get-name (car file))) (car file))
          (else (get-record name (cdr file)))))
  (define (tag x) (attach-tag 'list-file x))
  (put 'get-record '(symbol list-file) get-record)
  (put 'make-file 'list-file
       (lambda (record . records)
         (tag (apply make-file (cons record records)))))
  'done)

(load-option 'hash-table)

(define (install-hash-table-file)
  (define (make-file . records)
    (define table
      (make-eq-hash-table))
    (for-each (lambda (record)
                (hash-table/put! table (get-name record) record))
            records)
    table)
  (define (get-record name file)
    (hash-table/get file name #f))
  (define (tag x) (attach-tag 'hash-table-file x))
  (put 'get-record '(symbol hash-table-file) get-record)
  (put 'make-file 'hash-table-file
       (lambda (record . records)
         (tag (apply make-file (cons record records)))))
  'done)
