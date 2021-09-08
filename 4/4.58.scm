(define big-shot
  '(rule (big-shot ?person)
         (and (job ?person (?division . ?rest-1))
              (not (and (job ?s (?division . ?rest-2))
                        (supervisor ?person ?s))))))
