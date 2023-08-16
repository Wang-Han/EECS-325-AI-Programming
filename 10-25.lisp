(in-package :cs325-user)

;;; BROKEN CODE TO FIX
(defun match (x y &optional (blsts (list nil)))
  (cond ((eql x y) blsts)
        ((var-p x) 
         (mapcan (lambda (blst) (list-if (bind x y blst))) blsts))
        ((atom x) nil)
        ((apply (car x) y (cdr x)) blsts)
        (t (match (cdr x) (cdr y)
                  (match (car x) (car y) blsts)))))

;;; LEAVE ALONE

(defparameter *example-queries*
  '(
    ;;; all novels
    ((?x isa novel))
    ;;; female authors of novels
    ((?x author ?y) (?x isa novel) (?y isa female))
    ;;; should fail
    ((?x author ?y) (?x isa novel) (?y isa dog))
    ;;; authors who sold more than a million copies
    ((?y author ?x) (?y sales (> 1000000)))
    ))


(defparameter *triples*
  '((male isa person)(female isa person)
    (novel isa book)
    (stephen-king isa male) (carrie isa novel)
    (carrie author stephen-king)
    (the-handmaids-tale author margaret-atwood)
    (the-handmaids-tale isa novel)
    (margaret-atwood isa female)
    (dark-tower author stephen-king)
    (dark-tower isa novel)
    (dark-tower sales 30000000)
    ))


(defun demo-query-triples ()
  (dolist (query *example-queries*)
    (format t "~%~S => ~{~%  ~S~}~%" query (query-triples query))))

(defun query-triples (queries &optional (blsts (list nil)))
  (cond ((null queries) blsts)
        ((null blsts) nil)
        (t (query-triples (cdr queries)
                          (query-triple (car queries)
                                        blsts)))))

(defun query-triple (query blsts)
  (mapcan (lambda (triple) (match query triple blsts))
          *triples*))
 
(defun list-if (x) (and x (list x)))

(defun bind (x y blst)
  (let ((bdg (assoc x blst)))
    (cond ((null bdg) (cons (cons x y) blst))
          ((eql (cdr bdg) y) blst)
          (t nil))))

(defun var-p (x)
  (and (symbolp x) (eql (char (symbol-name x) 0) #\?)))
