(in-package :cl-user)
(defpackage :retro.models
  (:use :cl :crane)
  (:export :game
	   :load-games
	   :all-games
	   :add-game
	   :vote-for))

(in-package :retro.models)

;; Setup the database configuration and connect

(setup :migrations-directory (asdf:system-relative-pathname
			       :retro-2015 #p"migrations/")
       :databases `(:main (:type :sqlite3
			   :name ,(asdf:system-relative-pathname
				   :retro-2015 #p"retro.db"))))

(connect)

;; Our one data model

(deftable game ()
  (name :type text :uniquep t :nullp nil)
  (votes :type integer :initform 0))

;; Our data interface

(defparameter *all-games* nil)

(defun load-games()
  (setf *all-games* (filter 'game)))

(defun all-games ()
  (unless *all-games*
    (load-games))
  (sort (copy-list *all-games*) #'> :key #'votes))

(defun add-game (name)
  (push (create 'game :name name) *all-games*))

(defun find-game (name)
  (find name *all-games* :key #'name :test #'string=))

(defun vote-for (name)
  (let ((game (find-game name)))
    (when game
      (incf (votes game))
      (save game))))
