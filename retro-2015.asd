(defsystem retro-2015
  :depends-on (:crane
	       :lucerne)
  :components ((:file "models")
	       (:file "views")
	       (:file "package")))
