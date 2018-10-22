(cl:in-package :fistmage.example)


(defclass start-state ()
  ((started-at :initform (real-time-seconds))))


(defmethod fistmage:button-pressed ((this start-state) (button (eql :enter)))
  (declare (ignore this button))
  (fistmage:transition-to 'end-state))


(defmethod fistmage:act ((this start-state))
  (with-slots (started-at) this
    (when (> (- (real-time-seconds) started-at) 5)
      (fistmage:transition-to 'end-state))))


(defmethod fistmage:draw ((this start-state))
  (declare (ignore this))
  (gamekit:draw-text "START STATE REACHED" (gamekit:vec2 200 400)))
