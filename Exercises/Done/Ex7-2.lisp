(in-package :cs325-user)

(defun map-stream (function stream)
  (let ((end (gensym)))
    (do ((r (read stream nil end) (read stream nil end)))
        ((eql r end))
      (funcall function r))))

(defun map-file (function pathname)
  (with-open-file (stream pathname :direction :input)
    (map-stream function stream)))
