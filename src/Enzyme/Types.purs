module Enzyme.Types
  ( ENZYME
  ) where

import Control.Monad.Eff (kind Effect)

foreign import data ENZYME :: Effect
