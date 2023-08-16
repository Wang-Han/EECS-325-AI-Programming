(in-package :cs325-user)

(defun shortest-path (start end net)
  (reverse (ids (list start)
                (lambda (s) (eql end s)) 
                (lambda (s) (cdr (assoc s net))))))

(defun ids (path pred gen)
  (do ((depth 0 (1+ depth))
       (found nil (dls path pred gen depth)))
      ((or found (= depth 7)) found)))

(defun dls (path pred gen depth)
  (cond
   ((funcall pred (car path)) path)
   ((= depth 0) nil)
   (t (let ((next (safe-neighbour path (funcall gen (car path)))))
      (do ((rest next (cdr rest))
           (found nil (dls (cons (car rest) path) pred gen (1- depth))))
          ((or (null rest) found) found))))))

(defun safe-neighbour (path next)
  (mapcan #'(lambda (n) (if (member n path)
                            nil
                          (list n)))
          next))
