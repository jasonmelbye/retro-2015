(in-package :cl-user)
(defpackage :retro.views
  (:use :cl :lucerne)
  (:export :app))

(in-package :retro.views)
(annot:enable-annot-syntax)

(defapp app
    :middlewares ((clack.middleware.static:<clack-middleware-static>
		   :path "/static/"
		   :root (asdf:system-relative-pathname :retro-2015
							#p"static/"))))

(djula:add-template-directory
 (asdf:system-relative-pathname :retro-2015 #p"templates/"))

(defparameter +index+ (djula:compile-template* "index.html"))
(defparameter +add+   (djula:compile-template* "add.html"))

@route app "/"
(defview index ()
  (render-template (+index+)
		   :games (retro.models:all-games)))

@route app "/vote"
(defview vote ()
  (with-params (name)
    (retro.models:vote-for name))
  (redirect "/"))

@route app "/add"
(defview add ()
  (render-template (+add+)))

@route app (:post "/add")
(defview add-post ()
  (with-params (name)
    (retro.models:add-game name))
  (redirect "/"))
