(cl:defpackage :fistmage
  (:use :cl)
  (:export #:defgame
           #:initialize-game
           #:destroy-game
           #:transition-to

           #:initialize-state
           #:discard-state
           #:act
           #:draw
           #:button-pressed
           #:button-released

           #:start
           #:stop

           #:cursor-position))
