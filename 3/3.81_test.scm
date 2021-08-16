(load "test.scm")
(load "stream.scm")
(load "3/3.81.scm")

(define (test)
  (let ((requests (list->stream (list 'generate 'generate 'generate 'reset 'generate 'generate 'generate))))
    (let ((s (random-numbers requests)))
      (assert-stream s (list 1 48 847 4430 1 48 847 4430) "Failed random-stream"))))
(test)
