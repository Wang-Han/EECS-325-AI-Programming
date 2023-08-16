(in-package :cs325-user)

(defun map-range (fn start end)
  (do ((sign (if (> end start) 1 -1))
       (i start (+ sign i))
      ((lst nil (cons (funcall fn i) lst))))
      ((= i end) (reserve lst))))

(defun find-range (fn start end)
  (do ((sign (if (> end start) 1 -1))
       (i start (+ sign i)))
      ((or (= i end) (funcall fn i)) (if (= i end) nil i))))

(defun every-range (fn start end)
  (do ((sign (if (> end start) 1 -1))
       (i start (+ sign i)))
      ((or (= i end) (not (funcall fn i))) (= i end))))

(defun reduce-range (fn start end &optional init)
  (do ((sign (if (> end start) 1 -1))
       (i start (+ sign i))
       (result init (funcall fn result i)))
      ((= i end) result)))
       
