(in-package :cs325-user)


(defun longest-path (start end network)
  (or (reverse (dfs end (list start) network))
      (if (eql start end) (list start) nil)))

(defun dfs (end current network)
  (cond ((and (eql end (car current)) (cdr current)) current)
        ((member (car current) (cdr current)) nil)
        (t 
         (do ((next (cdr (assoc (car current) network)) (cdr next))
              (longest nil (longer longest (dfs end (cons (car next) current) network))))
             ((null next) longest)))))

(defun longer (current longest)
  (if (> (length current) (length longest)) current longest))

#|
(defun get-path (end current next longest network)
  (let ((path (if next (cons next current) nil)))
    (cond
      ((null path) nil)
      ((safe-cycle-p end path) path)
      ((eql (car path) end) path)
      ((member (car path) (cdr path)) longest)
      (t (dfs end path network)))))

(defun safe-cycle-p (end current)
  (and (eql end (car current))
       (eql end (car (last current)))))
|#

#|

(defun longest-path (start end net)
  (or
   (reverse (dfs (list start) end net))
   (if (eql start end) (list start) nil)))


(defun dfs (path end net)
  (cond
   ((and (eql (car path) end) (cdr path))
    path)
   ((member (car path) (cdr path))
    nil)
   (t
    (let ((neighbours (cdr (assoc (car path) net))))
      (do ((nodes neighbours (cdr nodes))
           (best-path nil 
            (better-path best-path (dfs (cons (car nodes) path) end net))))
          ((null nodes) best-path))))))
|#
