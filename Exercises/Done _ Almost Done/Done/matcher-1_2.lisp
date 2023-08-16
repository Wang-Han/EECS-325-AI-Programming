(in-package #:exmatch)

(defun ?not (a b &optional (lst '(nil)))
  (if (match-p (car a) b lst)
      nil
    lst))

(defun ?or (a b &optional (lst '(nil)))
  (and a (append (match-p (car a) b lst)
                    (?or (cdr a) b lst))))

(defun ?= (a b &optional (lst '(nil)))
  (let ((fun (cadr a)))
    (match-p (car a) (apply fun b (cddr a)) lst)))

(defun ?contains (a b &optional lst)
  (cond ((atom b) (match-p (car a) b))
        (t (append (match-p (car a) b) 
                   (mapcan #'(lambda (x) (?contains a x)) b)))))