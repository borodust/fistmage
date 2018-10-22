(cl:in-package :fistmage.example)


(fistmage:defgame (fistmage-example start-state)
  (:viewport-title "FistMage Example"))


(defun run ()
  (fistmage:start 'fistmage-example))
