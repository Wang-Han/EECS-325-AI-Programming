(in-package :cs325-user)

(defun shortest-path (start end net)
  (reverse (bfs (list (list start))
                (lambda (s) (eql end s)) 
                (lambda (s) (cdr (assoc s net))))))

(defun bfs (paths pred gen)
  (let* ((path (car paths))
         (node (car path))
         (next (funcall gen node)))
    (cond ((null paths) nil)
          ((funcall pred node) path)
          (t (bfs (cdr (append paths (safe-neighbour path next))) pred gen)))))

(defun safe-neighbour (path next)
  (mapcan #'(lambda (n) (if (member n path)
                            nil
                          (list (cons n path))))
          next))

