(in-package :cs325-user)
#|
(defun solve (f min max epsilon)
  (let ((mid (* 0.5 (+ min max))))
    (if (< (- max min) epsilon)
        (ret f min max)
      (let ((fmid (funcall f mid))
            (fmin (funcall f min))
            (fmax (funcall f max)))
        (cond ((< 0 (* fmin fmax)) (error "no solution"))
              ((= 0 fmid) mid)
              ((< 0 (* fmin fmid)) (solve f mid max epsilon))
              ((< 0 (* fmax fmid)) (solve f min mid epsilon))
              (t nil))))))

(defun ret (f min max)
  (if (< (abs (- (funcall f max) 0)) (abs (- (funcall f min) 0)))
      max
    min))
|#


(defun solve (f min max epsilon)
  (solve-helper f min (funcall f min) max (funcall f max) epsilon))

(defun solve-helper (f min fmin max fmax epsilon)
  (let* ((mid (* 0.5 (+ min max)))
         (fmid (funcall f mid))
         (delta (- max min)))
    (cond ((and (< delta epsilon) (< (abs fmax) (abs fmin))) max)
          ((and (< delta epsilon) (> (abs fmax) (abs fmin))) min)
          ((< 0 (* fmin fmax)) (error "no solution"))
          ((= 0 fmid) mid)
          ((< 0 (* fmin fmid)) (solve-helper f mid fmid max fmax epsilon))
          ((< 0 (* fmax fmid)) (solve-helper f min fmin mid fmid epsilon))
          (t nil))))

           
