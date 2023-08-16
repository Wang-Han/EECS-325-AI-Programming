(in-package :cs325-user)

(defmacro nth-expr (n &rest exprs)
    `(case ,n
       ,@(loop for i in exprs
               for n from 1
               collect `((,n) ,i))))


(defmacro n-of (n exprs)
  (let ((num (gensym)) (i (gensym)) (lst (gensym)))
    `(do ((,num ,n) 
          (,i 0 (1+ ,i)) 
          (,lst nil (cons ,exprs ,lst)))
         ((= ,i ,num) (nreverse ,lst))
        ())))