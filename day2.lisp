(in-package :cs325-user)

(defparameter *triples*
  '((chilly isa penguin) (penguin isa bird)))

(define-test isa-p
  (assert-true (isa-p 'chilly 'penguin))
  (assert-true (isa-p 'penguin 'bird))
  (assert-true (isa-p 'chilly 'bird))
  (assert-false (isa-p 'bird 'penguin))
  )

(defun isa-p (x y)
  t)
