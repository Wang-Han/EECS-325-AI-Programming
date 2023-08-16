(in-package :cs325-user)

(defun greater (x y)
  (if (> x y) x
    y))

(defun has-list-p (lst)
  (cond ((null lst) nil)
        ((listp (car lst)) t)
        (t (has-list-p (cdr lst)))))

(defun print-dots (x)   ;;iterative
  (do ((i 0 (1+ i)))
      ((= i x) nil)
    (format t ".")))

(defun print-dots (x)  ;;recursive
  (cond ((= x 0) nil)
        (t (format t ".")
           (print-dots (1- x)))))

(defun get-a-count (lst) ;; iterative
    (do ((i lst (cdr i)) 
         (num 0 (+ num (if (eql (car i) 'a) 1 0))))
        ((null i) num)))

(defun get-a-count (lst) ;;recursive
  (if (null lst) 0
    (+ (if (eql 'a (car lst)) 1 0) (get-a-count (cdr lst)))))

(defun summit (lst)
  (apply #'+ (remove nil lst)))  ;;remove did not change lst, so we use the result of remove 

(defun summit (lst)
  (if (null lst) 0   ;;after several times recursive(cdr lst), it will turn out to be nil(the base case) and the return of nil should be 0 
    (let ((x (car lst)))
      (if (null x)
          (summit (cdr lst))
        (+ x (summit (cdr lst)))))))