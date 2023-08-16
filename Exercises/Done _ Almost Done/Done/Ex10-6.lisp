(in-package :cs325-user)

(defmacro preserve (v &body body)
  `((lambda ,v ,@body) ,@v))