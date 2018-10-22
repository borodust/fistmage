(cl:in-package :fistmage)

(declaim (special *cursor*))

(defgeneric game-initial-state-class (game-instance))
(defgeneric initialize-game (game-instance))


(defclass game ()
  ((game-state :initform nil)
   (cursor :initform (gamekit:vec2 0 0))))


(defparameter *game-opt-names* (list))


(defun %initialize-game (instance &key &allow-other-keys)
  (declare (ignore instance)))


(defun cursor-position ()
  *cursor*)


(defun game-opt-p (opt-name)
  (find opt-name *game-opt-names* :test #'equal))


(defmacro defgame ((name initial-state-class) &body opts)
  (multiple-value-bind (game-opts gamekit-opts)
      (loop for opt in opts
            for (opt-name . args) = (alexandria:ensure-list opt)
            if (game-opt-p opt-name)
              append (list opt-name `(list ,@args)) into game-opts
            else
              collect opt into gamekit-opts
            finally (return (values game-opts gamekit-opts)))
    `(progn
       (gamekit:defgame ,name (game) () ,@gamekit-opts)
       (defmethod initialize-game ((this ,name))
         (%initialize-game this ,@game-opts))
       (defmethod game-initial-state-class ((this ,name))
         (declare (ignore this))
         (find-class ',initial-state-class)))))


(defmacro with-game-specials ((game) &body body)
  (alexandria:with-gensyms (this-cursor)
    `(with-slots ((,this-cursor cursor)) ,game
       (let ((*cursor* ,this-cursor))
         ,@body))))


(defun transition-to (state-class &rest args &key &allow-other-keys)
  (let ((game (gamekit:gamekit)))
    (with-slots (game-state) game
      (flet ((%transition-to ()
               (with-game-specials (game)
                 (discard-state game-state)
                 (setf game-state (apply #'make-instance state-class args))
                 (apply #'initialize-state game-state args))))
        (gamekit:push-action #'%transition-to)))))


(defmethod gamekit:post-initialize ((this game))
  (with-slots (cursor game-state) this
    (initialize-game this)
    (gamekit:bind-cursor (lambda (x y)
                           (setf (gamekit:x cursor) x
                                 (gamekit:y cursor) y)))
    (flet ((process-button (button state)
             (with-game-specials (this)
               (case state
                 (:pressed (button-pressed game-state button))
                 (:released (button-released game-state button))))))
      (gamekit:bind-any-button #'process-button))
    (transition-to (game-initial-state-class this))))


(defmethod gamekit:act ((this game))
  (with-slots (game-state) this
    (with-game-specials (this)
      (act game-state))))


(defmethod gamekit:draw ((this game))
  (with-slots (game-state) this
    (with-game-specials (this)
      (draw game-state))))


(defun start (game-class)
  (gamekit:start game-class :samples 4
                            :opengl-version '(2 1)))


(defun stop ()
  (gamekit:stop))
