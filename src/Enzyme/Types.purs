module Enzyme.Types 
  ( ENZYME
  , ReactClassInstance
  , Undefined
  , undefined
  ) where

import Control.Monad.Eff (kind Effect)

foreign import data ENZYME :: Effect

foreign import data ReactClassInstance :: Type

foreign import data Undefined :: Type

foreign import undefined :: Undefined
