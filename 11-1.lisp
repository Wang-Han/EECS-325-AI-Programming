(in-package :cs325-user)

(defun unifies-p (x y) (not (null (unify x y))))

(defun unify (x y &optional (blsts (list nil)))
  (cond ((null blsts) nil)
        ((eql x y) blsts)
        ((var-p x) (match-var x y blsts))
        ((var-p y) (match-var y x blsts))
        ((or (atom x) (atom y)) nil)
        (t
         (unify (cdr x) (cdr y)
                (unify (car x) (car y) blsts)))))

(defun match-var (x y blsts)
  (mapcan (lambda (blst) (list-if (bind x y blst))) blsts))

(defun list-if (x) (and x (list x)))

(defun bind (x y blst)
  (and (not (occurs-in-p x y))
       (let ((bdg (assoc x blst)))
         (cond ((null bdg) (cons (cons x y) blst))
               ((eql (cdr bdg) y) blst)
               (t nil)))))

(defun occurs-in-p (x y)
  (or (eql x y)
      (and (consp y)
           (or (occurs-in-p x (car y))
               (occurs-in-p x (cdr y))))))

(defun var-p (x)
  (and (symbolp x) (eql (char (symbol-name x) 0) #\?)))