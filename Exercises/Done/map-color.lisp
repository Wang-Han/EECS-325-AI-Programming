(in-package :ddr-tests)


(defparameter *colors-kb*
  '(
    (color red)
    (color blue)
    (color green)
    (color yellow)))

(defparameter *all-different-kb*
  '(
    (-> (all-different (cons ?x (cons ?a ?l))) (different ?x ?a)
                                               (all-different (cons ?x ?l))
                                               (all-different (cons ?a ?l)))
    (-> (different ?x ?y) (different ?y ?x))
    
    (all-different (cons red (cons blue (cons green (cons yellow nil)))))))

(defparameter *color-map1-kb*
  '(
    (<- (colors-for map1 ?a ?b ?c ?d)
        (color ?a)
        (color ?b)
        (color ?c)
        (color ?d)
        (different ?a ?b)
        (different ?a ?c)
        (different ?a ?d)
        (different ?b ?c)
        (different ?b ?d)
        (different ?c ?d))))

(defparameter *color-map2-kb*
  '(
    (<- (colors-for map2 ?a ?b ?c ?d ?e)
        (color ?a)
        (color ?b)
        (color ?c)
        (color ?d)
        (color ?e)
        (different ?a ?b)
        (different ?a ?c)
        (different ?a ?d)
        (different ?a ?e)
        (different ?b ?c)
        (different ?b ?e)
        (different ?c ?d)
        (different ?c ?e)
        (different ?d ?e))))

(defparameter *color-map3-kb*
  '(
    (<- (colors-for map3 ?a ?b ?c ?d ?e ?f)
        (color ?a)
        (color ?b)
        (color ?c)
        (color ?d)
        (color ?e)
        (color ?f)
        (different ?a ?b)
        (different ?a ?c)
        (different ?a ?d)
        (different ?a ?e)
        (different ?a ?f)
        (different ?b ?c)
        (different ?b ?d)
        (different ?b ?e)
        (different ?c ?d)
        (different ?d ?e)
        (different ?d ?f)
        (different ?e ?f))))

(defparameter *map-color-kb*
  (append *colors-kb* *all-different-kb* *color-map1-kb* *color-map2-kb* *color-map3-kb*))