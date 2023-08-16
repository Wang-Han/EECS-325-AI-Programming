(in-package :cs325-user)

(defparameter *rules*
    (quote
     ((<- (mortal ?x) (animal ?x))
      (<- (intelligent ?x) (human ?x))
      (<- (intelligent ?x) (animal ?x) (martian ?x))
      (<- (animal ?x) (human ?x))
      (<- (animal ?x) (dog ?x)) (<- (human plato))
      (<- (dog pluto)) (<- (dog k-9))
      (<- (martian k-9)))))

(defun ask-p (query) (not (null (ask query))))

(defun ask (query &optional (blsts (list nil)))
  (and blsts
       (mapcan (lambda (rule) (bc rule query blsts))
               *rules*)))

(defun bc (rule query blsts)
  (reduce (lambda (blsts x) (ask x blsts)) (cddr rule)
    :initial-value (unify query (cadr rule) blsts)))
