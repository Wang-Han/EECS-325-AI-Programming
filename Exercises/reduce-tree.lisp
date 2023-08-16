(in-package :cs325-user)

(defun reduce-tree (fn tree &optional (init nil))
  (cond ((null tree) init)
        ((atom tree) (funcall fn init tree))
        (t (do ((lst tree (cdr lst))
                (result init (reduce-tree fn (car lst) result)))
               ((null lst) result)))))