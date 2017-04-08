module Enzyme.Types 
  ( ENZYME
  , ReactClassInstance
  ) where

import Control.Monad.Eff (kind Effect)

foreign import data ENZYME :: Effect

foreign import data ReactClassInstance :: Type
