(in-package :cl-user)
(defpackage :retro
  (:use :cl)
  (:import-from :retro.models
		:load-games
		:all-games
		:add-game
		:vote-for)
  (:import-from :retro.views
		:app)
  (:export :load-games
	   :all-games
	   :add-game
	   :vote-for
	   :app))
