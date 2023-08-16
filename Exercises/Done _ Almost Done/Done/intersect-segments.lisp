(in-package :cs325-user)
#|
(defun intersect-segments (ax ay bx by cx cy dx dy)
  (let* ((a (list ax ay))
         (b (list bx by))
         (c (list cx cy))
         (d (list dx dy))
         (v1 (subtract-points b a))
         (v2 (subtract-points d c))
         (den (cross-product v1 v2))
         (s1-num (cross-product (subtract-points c a) v2))
         (s2-num (cross-product (subtract-points c a) v1))
         (s1 (if (= den 0) (* (signum s1-num) most-positive-fixnum) (/ s1-num den)))
         (s2 (if (= den 0) (* (signum s2-num) most-positive-fixnum) (/ s2-num den))))
    (cond ((and (equal a b) (equal c d) (equal a c)) (values-list (append a b)))
          ((equal a b) (in-a-line c a d))
          ((equal c d) (in-a-line a c b))
          ((overlapping-p v1 v2 a c) (find-overlap a b c d))
          ((intersection-p v1 v2 s1 s2) (find-intersection a s1 v1))
          (t nil))))
;; I know that this is a little bit long but it didn't make much sense to me to create a function
;; that would take a ton of arguments if I already had them within the original

(defun overlapping-p (v1 v2 a c)
  (and (= (cross-product v1 v2) 0)
       (= (cross-product (subtract-points c a) v1) 0)
       (or (<= 0 (dot-product (subtract-points c a) v1) (dot-product v1 v1))
           (<= 0 (dot-product (subtract-points a c) v2) (dot-product v2 v2)))))

(defun find-overlap (a b c d)
  (cond
    ((< (car d) (car b)) (values-list (append c d)))
    ((> (car a) (car b)) (values-list (append c a)))
    (t (values-list (append c b)))))

(defun in-a-line (a b c)
  (when (or (equal a b) (equal b c)
            (and (= (slope a b) (slope b c))
                 (<= (car a) (car b) (car c))))
    (values-list (append b b))))

(defun intersection-p (v1 v2 s1 s2)
  (and (= (cross-product v1 v2) 0)
       (<= 0 s1) (<= s1 1)
       (<= 0 s2) (<= s2 1)))

(defun find-intersection (a s1 v1)
  (values-list (add-points a (scalar-point s1 v1))))

(defun subtract-points (a b)
  (let ((x (- (car a) (car b)))
        (y (- (cadr a) (cadr b))))
    (list x y)))

(defun add-points (a b)
  (let ((x (+ (car a) (car b)))
        (y (+ (cadr a) (cadr b))))
    (list x y)))

(defun scalar-point (scalar a)
  (let ((x (* (car a) scalar))
        (y (* (cadr a) scalar)))
    (list x y)))

(defun cross-product (a b)
  (- (* (car a) (cadr b)) (* (cadr a) (car b))))

(defun dot-product (a b)
  (+ (* (car a) (car b)) (* (cadr a) (cadr b))))

(defun slope (a b)
  (let ((x (- (car a) (car b)))
        (y (- (cadr a) (cadr b))))
    (unless (or (= x 0)
                (= y 0))
      (/ y x))))
|#


(defun intersect-segments (ax ay bx by cx cy dx dy)
  (let* ((v1 (list (- bx ax) (- by ay)))
         (v2 (list (- dx cx) (- dy cy)))
         (v3 (list (- ax cx) (- ay cy)))
         (denominator (cross-product v1 v2)))
    (cond ((/= denominator 0)
           (non-parallel-intersection ax ay v1 v2 v3 denominator))
          ((and (= (cross-product v2 v3) 0) (= (cross-product v1 v3) 0) (= denominator 0))
           (parallel-overlap ax ay bx by cx cy dx dy))
          (t nil))))

(defun cross-product (v1 v2)
  (- (* (car v1) (cadr v2)) (* (car v2) (cadr v1))))

(defun non-parallel-intersection (x y v1 v2 v3 deno)
  (let* ((a (/ (cross-product v2 v3) deno))
         (b (/ (cross-product v1 v3) deno)))
    (and (>= 1 a 0) (>= 1 b 0) (values (+ x (* a (car v1))) (+ y (* a (cadr v1)))))))

(defun parallel-overlap (ax ay bx by cx cy dx dy)
  (let ((start1 (max ax bx))
        (end1 (min ax bx))
        (start2 (max cx dx))
        (end2 (min cx dx)))
    (cond ((and (eql (slope ax ay bx by) 'point) (eql (slope cx cy dx dy) 'point) (eql (slope ax ay cx cy) 'point))
           (values ax ay cx cy))
          ((and (> start1 cx) (> start1 dx) (< end1 cx) (< end1 dx)) 
           (values cx cy dx dy))
          ((and (> start2 ax) (> start2 bx) (< end2 ax) (< end2 bx)) 
           (values ax ay bx by))
          ((and (>= start1 end2) (>= end2 end1))
           (values start1 (max ay by) end2 (min cy dy)))
          (t nil))))

(defun slope (ax ay bx by)
  (cond ((= ax bx) 'undefined)
        ((= ay by) 0)
        ((and (= ax bx) (= ay by)) 'point)
        (t (/ (- ay by) (- ax bx)))))
