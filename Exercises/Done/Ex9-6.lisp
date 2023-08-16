(in-package :cs325-user)

(defun horner (x &rest lst)
  (reduce #'(lambda (a b) (+ (* a x) b)) lst))
