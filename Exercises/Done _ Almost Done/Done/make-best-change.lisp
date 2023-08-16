(in-package :cs325-user)

(defun make-best-change (x &optional (lst '(25 10 5 1)))
    (values-list (reverse (car (make-change x lst)))))

(defun make-change (x lst &optional (best-change nil) (value nil))
  (do ((clst (change-list x lst) (cdr clst))
       (change best-change (make-change (- x (* (car lst) (car clst))) (cdr lst) change (cons (car clst) value))))
      ((null clst) (get-best-change x value change))))

(defun change-list (x lst)
  (cond ((null lst) nil)  ;;; I think it is not on every iteration actually
        ((null (cdr lst)) (list (floor x (car lst))))
        (t (let ((n (1+ (floor x (car lst)))))
             (mapcar #'(lambda (x) (decf n)) (make-list n))))))

(defun get-best-change (x value best)
  (if (or (null best)
          (< x (cdr best))
          (and (< (reduce #'+ value) (reduce #'+ (car best))) (= x (cdr best))))
      (cons value x) best))
