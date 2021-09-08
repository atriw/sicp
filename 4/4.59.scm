(define (prepare-meeting)
  (list
    '(assert! (meeting accounting (Monday 9am)))
    '(assert! (meeting administration (Monday 10am)))
    '(assert! (meeting computer (Wednesday 3pm)))
    '(assert! (meeting administration (Friday 1pm)))
    '(assert! (meeting whole-company (Wednesday 4pm)))))

(define meeting-time
  '(rule (meeting-time ?person ?day-and-time)
        (and (job ?person (?division . ?rest))
             (or (meeting whole-company ?day-and-time)
                 (meeting ?division ?day-and-time)))))
