module Enzyme.Utils where

import React (ReactClass, ReactElement, ReactThis)

foreign import isInstanceOf :: forall props state. ReactThis props state -> ReactClass props -> Boolean

foreign import isValidElement :: ReactElement -> Boolean
