;;; Oct-25-2016 File released

;;; Depends on: simple-triples.lisp

(defpackage #:triple-tests
  (:use #:common-lisp #:lisp-unit #:triples)
  )

(in-package #:triple-tests)

;;; Set the following variable to the directory with your triple data files

(defparameter *triple-directory* "~/Desktop/325-AI Programming/Exercises")


;;; Utility code to load triples from a text file for testing
;;; Note: because triple lists might be very long, this only reloads
;;; if necessary, and clears an old list before loading a new one.

(defparameter *current-triple-file* nil)

(defun load-triples (file &optional reload-p)
  (when (or reload-p (not (equal *current-triple-file* file)))
    (let ((pathname (merge-pathnames file *triple-directory*)))
      (format t "~&Loading ~A" pathname)
      (setq *triples* nil)
      (setq *triples* (read-triples pathname))
      (setq *current-triple-file* file))))

;;; UNIT TESTS

(define-test animals
  (load-triples "toy-animal-triples.txt")
  (assert-equal '(((?x fish)) ((?x whale)))
                (query '((?x lives-in water))))
  (assert-equal '(((?x whale)))
                (query '((?x lives-in water) (?x isa mammal))))
  (assert-equal '(((?y mammal) (?x whale)))
                (query '((?x lives-in water) (?x isa ?y) (?y has vertebra))))
  (assert-equal '(((?w 66000) (?a whale)) ((?w 240) (?a bear)))
                (query '((?a weight ?w) (?w (>) 100))))
  )


(defun neql (x y) (not (eql x y)))

(define-test movies
  (load-triples "movie-triples.txt")
  (assert-equal 7
     (length (query '((?m director francis_ford_coppola)))))
  (assert-equal 1
     (length (query '((?m director woody_allen) (?m actor woody_allen)))))
  (assert-equal 9
     (length (query '((?m director ?d) (?m actor ?d)))))
  ;; list movies after 2004
  (assert-equal 9
     (length (query '((?m movie ?y) (?y (>) 2004)))))
  ;; list directors with at least two different movies in the same year
  (assert-equal 6
     (length
      (query '((?m1 movie ?y) (?m2 movie ?y) (?m1 (neql) ?m2) (?m1 director ?d) (?m2 director ?d)))))
  )

;;; Just a scale-up test for now.
(define-test dbpedia
  (load-triples "dbpedia-triples.txt")
  ;; hack to delay getting symbol until package loaded from file
  (let ((subclass (find-symbol "SUB-CLASS-OF" :RDF-SCHEMA)))
    ;; get all concepts that 7 layers deep
    (assert-equal 4
      (length 
       (query `((?c1 ,subclass ?c2) (?c2 ,subclass ?c3) (?c3 ,subclass ?c4) 
                (?c4 ,subclass ?c5) (?c5 ,subclass ?c6) (?c6 ,subclass ?c7) 
                (?c7 ,subclass ?c8)))))
    ))

;;; READ-NT

(defparameter *prefixes*
  '((dbp "http://dbpedia.org/ontology/")
    (dbpt "http://dbpedia.org/datatype/")
    (owl "http://www.w3.org/2002/07/owl#")
    (rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#")
    (rdfs "http://www.w3.org/2000/01/rdf-schema#")
    (skos "http://www.w3.org/2004/02/skos/core#")
    (xsd "http://www.w3.org/2001/XMLSchema#")
    (schema "http://schema.org/")
    (dul "http://www.ontologydesignpatterns.org/ont/dul/")
    (geo "http://www.w3.org/2003/01/geo/wgs84_pos:")
    (wiki "wikicat_")
    (yago "yago")
    ))

(defparameter *skip-strings*
  '("<http://dbpedia.org/ontology/>"
    "<http://www.w3.org/2000/01/rdf-schema#comment>"
    "<http://www.w3.org/ns/prov#wasDerivedFrom>"
    "<http://www.w3.org/2000/01/rdf-schema#label>"
    "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
    "<http://www.w3.org/2002/07/owl#equivalentClass>"
    "<http://www.w3.org/2002/07/owl#equivalentProperty>"
    "<http://www.w3.org/2002/07/owl#disjointWith>"
    "<wordnet_"
    "@base"
    "@prefix"
    "<hasGloss>"
    "yagoGeoEntity"
    ))

(defun load-nt (file)
  (let ((pathname (merge-pathnames file *triple-directory*)))
    (format t "~&Loading ~A" pathname)
    (setq *triples* nil)
    (setq *triples* (read-nt pathname *prefixes* *skip-strings*))))

;;; Same test as before, but reads raw triple file to get data
(define-test dbpedia-nt
  (load-nt "dbpedia_2016-04.nt")
  ;; hack to delay getting symbol until package loaded from file
  (let ((subclass (find-symbol "SUB-CLASS-OF" :RDFS)))
    ;; get all concepts that 7 layers deep
    (assert-equal 4
      (length 
       (query `((?c1 ,subclass ?c2) (?c2 ,subclass ?c3) (?c3 ,subclass ?c4) 
                (?c4 ,subclass ?c5) (?c5 ,subclass ?c6) (?c6 ,subclass ?c7) 
                (?c7 ,subclass ?c8)))))
    ))
