(in-package :cs325-user)

(defun show-dots (lst)
  (cond ((atom lst) (format t "~s" lst))
        (t 
         (format t "(")
         (show-dots (car lst))
         
         (format t " . ")
         (show-dots (cdr lst))
         (format t ")"))))

(defun show-list (lst)   ;; it seems helper is not needed for show-list as well. :)
  (cond ((atom lst) (format t "~s" lst))
        (t 
         (format t "[")
         (show-list (car lst))
         (do ((l (cdr lst) (cdr l)))
             ((atom l) (unless (null l) (format t " . ~a" l)) )
           (format t " ")
           (show-list (car l)))
         (format t "]"))))