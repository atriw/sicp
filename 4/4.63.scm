(define (prepare-database)
  (define records
    (list
      '(son Adam Cain)
      '(son Cain Enoch)
      '(son Enoch Irad)
      '(son Irad Mehujael)
      '(son Mehujael Methushael)
      '(son Methushael Lamech)
      '(wife Lamech Ada)
      '(son Ada Jabal)
      '(son Ada Jubal)))
  (map
    (lambda (record)
      (list 'assert! record))
    records))

(define grandson
  '(rule (grandson ?grandfather ?grandson)
         (and (son ?father ?grandson)
              (son ?grandfather ?father))))
(define son
  '(rule (son ?father ?son)
         (and (wife ?father ?wife)
              (son ?wife ?son))))
