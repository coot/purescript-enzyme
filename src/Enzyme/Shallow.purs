module Enzyme.Shallow where

import Data.Foreign (Foreign)
import React (ReactElement)
import Enzyme.ShallowWrapper (ShallowWrapper)

foreign import shallow :: ReactElement -> Foreign -> ShallowWrapper
