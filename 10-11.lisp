(in-package :cs325-user)

((define-test more-specific-p
  (assert-true (more-specific-p '(volatis can-fly yes) '(animal can-fly no)))
  (assert-true (more-specific-p '(penguin can-fly no) '(bird can-fly yes)))
  (assert-false (more-specific-p '(bird can-fly yes) '(bird can-fly yes)))
  (assert-false (more-specific-p '(animal can-fly no) '(penguin can-fly no))
  (assert-false (more-specific-p '(animal can-fly no) '(penguin can-fly no)))
  (assert-true (more-specific-p '(volatis can-fly yes) '(volatis can-fly yes-no)))
  (assert-false (more-specific-p '(volatis can-fly yes-no) '(volatis can-fly yes)))
  )


(defparameter *triples*
  '((volatis isa penguin) (penguin isa bird) 
    (bird isa animal) (cat isa animal)
    (yes isa yes-no) (no isa yes-no)
    (animal can-fly no) (bird can-fly yes) 
    (penguin can-fly no) (volatis can-fly yes)
    (vera isa volatis) (chilly isa penguin) 
    (tweety isa bird) (sylvester isa cat)
    ))

(defun isa-p (x y &optional (triples *triples*))
  (cond ((null triples) nil)
        ((and
          (eql x (caar triples))
          (eql y (caddar triples)))
         t)
        ((eql x (caar triples))
         (isa-p (caddar triples) y))
        (t (isa-p x y (cdr triples)))))

(defun more-specific-p (x y &optional (triples *triples*));shb786
  (cond
   ((eql (car x) (car y)) (isa-p (caddr x) (caddr y)))
   (t (isa-p (car x) (car y)))))

