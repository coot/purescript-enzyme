module Enzyme.Mount where

import React (ReactElement)
import Enzyme.ReactWrapper (ReactWrapper)

foreign import mount :: ReactElement -> ReactWrapper
