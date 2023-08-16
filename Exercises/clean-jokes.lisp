(in-package :cs325-user)

(in-package :cs325-user)
          
(defun solve (f min max epsilon)
  (if (< 0 (funcall f min))
      (solve-ordered f max min epsilon)
    (solve-ordered f min max epsilon)))

(defun solve-ordered (f neg pos epsilon)
  (let* ((mid (* 0.5 (+ neg pos)))
         (fmid (funcall f mid)))
    (cond ((within-ep neg pos epsilon) mid)
          ((> 0 fmid)
           (solve-ordered f mid pos epsilon))
          (t
           (solve-ordered f neg mid epsilon)))))

(defun within-ep (val1 val2 epsilon)
  (< (- (max val1 val2) (min val1 val2)) epsilon))