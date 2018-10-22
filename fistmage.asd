(cl:pushnew :bodge-gl2 cl:*features*)

(asdf:defsystem :fistmage
  :description "Simple finite-state machine-driven game engine"
  :license "MIT"
  :version "1.0.0"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :depends-on (alexandria trivial-gamekit)
  :pathname "src/"
  :serial t
  :components ((:file "packages")
               (:file "state")
               (:file "game")))


(asdf:defsystem :fistmage/example
  :description "FistMage example"
  :license "MIT"
  :version "1.0.0"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :depends-on (fistmage)
  :pathname "example/"
  :serial t
  :components ((:file "packages")
               (:file "utils")
               (:file "start-state")
               (:file "end-state")
               (:file "example")))
