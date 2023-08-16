(in-package :cs325-user)

(defun match-p (x y) (not (null (match x y))))

(defun match (x y &optional (blst nil))
  (cond ((eql x y) blst)
        ((var-p x) (bind x y blst))
        ((or (atom x) (atom y)) nil)
        (t
         (match
          (cdr x)
          (cdr y)
          (match (car x) (car y) blst)))))

(defun bind (x y blst)
  (let ((bdg (assoc x blst)))
    (cond ((null bdg) (cons (cons x y) blst))
          ((eql (cdr bdg) y) blst)
          (t nil))))

(defun var-p (x)
  (and (symbolp x)
       (eql (char (symbol-name x) 0) #\?)))