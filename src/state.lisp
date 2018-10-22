(cl:in-package :fistmage)

(defgeneric button-pressed (game-state button)
  (:method (game-state button) (declare (ignore game-state button))))

(defgeneric button-released (game-state button)
  (:method (game-state button) (declare (ignore game-state button))))

(defgeneric act (game-state)
  (:method (game-state) (declare (ignore game-state))))

(defgeneric draw (game-state)
  (:method (game-state) (declare (ignore game-state))))

(defgeneric initialize-state (game-state &key &allow-other-keys)
  (:method (game-state &key &allow-other-keys)
    (declare (ignore game-state))))

(defgeneric discard-state (game-state)
  (:method (game-state) (declare (ignore game-state))))
