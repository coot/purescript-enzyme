module Enzyme.Utils where

import React (ReactClass, ReactThis)

foreign import isInstanceOf :: forall props state. ReactThis props state -> ReactClass props -> Boolean
