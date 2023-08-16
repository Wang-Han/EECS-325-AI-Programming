(in-package :cs325-user)

(defun bfs (end queue net)
  (let* ((path (car queue)) (node (car path)) (neighbours (cdr (assoc node net))))
    (cond ((empty-queue-p queue) nil)
          ((member end neighbours)
           (reverse (cons end (car queue))))
          (t (bfs end (cdr (append queue (valid-neighbours path neighbours))) net)))))
