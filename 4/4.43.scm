(define yacht-daughter
  '(define (yacht-daughter)
     (define daughter cons)
     (define father car)
     (define owner cdr)
     (define (map proc seq)
       (if (null? seq)
         '()
         (cons (proc (car seq)) (map proc (cdr seq)))))
     (let ((mary-ann (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                               (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
       (require (eq? 'mr-moore (father mary-ann)))
       (require (not (eq? (father mary-ann) (owner mary-ann))))
       (let ((gabrielle (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                  (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
         (require (eq? 'sir-barnacle (owner gabrielle)))
         (require (not (eq? (father gabrielle) (owner gabrielle))))
         (let ((lorna (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
           (require (eq? 'mr-moore (owner lorna)))
           (require (not (eq? (father lorna) (owner lorna))))
           (let ((rosalind (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                     (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
             (require (eq? 'mr-hall (owner rosalind)))
             (require (not (eq? (father rosalind) (owner rosalind))))
             (let ((melissa (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                      (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
               (require (eq? 'colonel-downing (owner melissa)))
               (require (eq? 'sir-barnacle (father melissa)))
               (let ((daughter-of-dr-parker (amb mary-ann gabrielle lorna rosalind melissa)))
                 (require (eq? 'dr-parker (father daughter-of-dr-parker)))
                 (require (eq? (father gabrielle) (owner daughter-of-dr-parker)))
                 (require (distinct? (map father (list mary-ann gabrielle lorna rosalind melissa))))
                 (require (distinct? (map owner (list mary-ann gabrielle lorna rosalind melissa))))
                 (list (list 'mary-ann mary-ann)
                       (list 'gabrielle gabrielle)
                       (list 'lorna lorna)
                       (list 'rosalind rosalind)
                       (list 'melissa melissa))))))))))

(define yacht-daughter-modified
  '(define (yacht-daughter-modified)
     (define daughter cons)
     (define father car)
     (define owner cdr)
     (define (map proc seq)
       (if (null? seq)
         '()
         (cons (proc (car seq)) (map proc (cdr seq)))))
     (let ((mary-ann (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                               (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
       (require (not (eq? (father mary-ann) (owner mary-ann))))
       (let ((gabrielle (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                  (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
         (require (eq? 'sir-barnacle (owner gabrielle)))
         (require (not (eq? (father gabrielle) (owner gabrielle))))
         (let ((lorna (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
           (require (eq? 'mr-moore (owner lorna)))
           (require (not (eq? (father lorna) (owner lorna))))
           (let ((rosalind (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                     (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
             (require (eq? 'mr-hall (owner rosalind)))
             (require (not (eq? (father rosalind) (owner rosalind))))
             (let ((melissa (daughter (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker)
                                      (amb 'mr-moore 'colonel-downing 'mr-hall 'sir-barnacle 'dr-parker))))
               (require (eq? 'colonel-downing (owner melissa)))
               (require (eq? 'sir-barnacle (father melissa)))
               (let ((daughter-of-dr-parker (amb mary-ann gabrielle lorna rosalind melissa)))
                 (require (eq? 'dr-parker (father daughter-of-dr-parker)))
                 (require (eq? (father gabrielle) (owner daughter-of-dr-parker)))
                 (require (distinct? (map father (list mary-ann gabrielle lorna rosalind melissa))))
                 (require (distinct? (map owner (list mary-ann gabrielle lorna rosalind melissa))))
                 (list (list 'mary-ann mary-ann)
                       (list 'gabrielle gabrielle)
                       (list 'lorna lorna)
                       (list 'rosalind rosalind)
                       (list 'melissa melissa))))))))))