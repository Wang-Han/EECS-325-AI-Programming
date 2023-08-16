(in-package :cs325-user)
(in-package :ddr-tests)
#|
(defparameter *all-different-kb*
  '(
    (-> (different ?x ?y) (different ?y ?x))
    (-> (all-different (cons ?x (cons ?y ?d))) 
        (all-different (cons ?y ?z))
        (all-different (cons ?x ?z))
        (different ?x ?y))
    ))

(defparameter *all-different-kb*
  '(
    (-> (different ?x ?y) (different ?y ?x))
    (-> (ad (cons ?x (cons ?y nil))) (different ?x ?y))
    (-> (ad (cons ?x (cons ?y ?l))) (different ?x ?y) 
                                               (ad ?x ?l) 
                                               (ad ?y ?l))))


(defparameter *all-different-kb* 
  '( (-> (different ?x ?y) (different ?y ?x)) 
     (-> (all-different (cons ?x ?l)) (differ ?x ?l)) 
     (-> (differ ?x (cons ?a ?l)) (different ?x ?a) 
                                  (all-different (cons ?x ?l)) 
                                  (all-different (cons ?a ?l)))

))

|#

(defparameter *all-different-kb*
  '(
    (-> (different ?x ?y) (different ?y ?x))
    (-> (all-different (cons ?x (cons ?y nil))) (different ?x ?y))
    (-> (all-different (cons ?x (cons ?y ?l))) (different ?x ?y)
                                               (all-different ?x ?l)
                                               (all-different ?y ?l))))