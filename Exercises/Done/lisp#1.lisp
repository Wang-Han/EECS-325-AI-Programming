(in-package :cs325-user)
#|
(defun has-number-p (lst)
  (cond ((null lst) nil)
        ((atom lst) (numberp lst))
        ((some #'has-number-p lst) t)))

|#

(defun has-number-p (x)
  (if (atom x)
      (numberp x)
    (some #'has-number-p x)))
