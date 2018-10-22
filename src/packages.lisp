(cl:defpackage :fistmage
  (:use :cl)
  (:export #:defgame
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
