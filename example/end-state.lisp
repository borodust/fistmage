(cl:in-package :fistmage.example)


(defclass end-state ()
  ((started-at :initform (real-time-seconds))))


(defmethod fistmage:button-pressed ((this end-state) (button (eql :space)))
  (declare (ignore this button))
  (fistmage:transition-to 'start-state))


(defmethod fistmage:act ((this end-state))
  (with-slots (started-at) this
    (when (> (- (real-time-seconds) started-at) 5)
      (fistmage:transition-to 'start-state))))


(defmethod fistmage:draw ((this end-state))
  (declare (ignore this))
  (gamekit:draw-text "END STATE REACHED" (gamekit:vec2 200 200)))
