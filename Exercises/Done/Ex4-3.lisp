(in-package :cs325-user)

(defstruct 3tree
  (data nil)
  (left nil)
  (middle nil)
  (right nil))

(defun 3tree-clone (tree)
  (if (null tree)
      nil
    (make-3tree :data (3tree-data tree)
                :left (3tree-clone (3tree-left tree))
                :middle (3tree-clone (3tree-middle tree))
                :right (3tree-clone (3tree-right tree)))))

(defun 3tree-member (x tree)
  (if (null tree)
      nil
    (or (eql x (3tree-data tree))
        (3tree-number x (3tree-left tree))
        (3tree-number x (3tree-middle tree))
        (3tree-number x (3tree-right tree)))))