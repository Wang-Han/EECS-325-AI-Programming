(in-pacakge :cs325-user)

(defmacro doublef (n)
  (list 'let (list (list 'var n))
        (list 'setf 'var (list '* 'var '2))))