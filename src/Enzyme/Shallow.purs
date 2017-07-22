module Enzyme.Shallow
  ( shallow
  , shallowWithOptions
  ) where

import Control.Monad.Eff (Eff)
import Data.Foreign (Foreign, toForeign)
import Enzyme.Class (class Subrow)
import Enzyme.Internals (undefined, unsafeMerge)
import Enzyme.ShallowWrapper (ShallowWrapper)
import Enzyme.Types (ENZYME)
import Prelude (($))
import React (ReactElement)

foreign import _shallow :: forall e. ReactElement -> Foreign -> Eff (enzyme :: ENZYME | e) ShallowWrapper

type Mandatory r = (|r) :: # Type
type Optional r = (lifecycleExperimental :: Boolean, context :: Foreign | r)
type ShallowOptions r = Record (Mandatory (Optional r))

defaults :: {|Optional ()}
defaults = { lifecycleExperimental: false, context: toForeign undefined }

shallow :: forall e. ReactElement -> Eff (enzyme :: ENZYME | e) ShallowWrapper
shallow e = _shallow e (toForeign defaults)

mergeOpts
  :: forall r s
  .  Union r (Optional ()) (Optional s)
  => Subrow s (Optional ())
  => Record (Mandatory r)
  -> Record (Optional s)
mergeOpts o = unsafeMerge o defaults

shallowWithOptions
  :: forall r s t e
   .  Union s (Optional ()) (Optional r)
  => Union r t (Optional ())
  => ReactElement
  -> { | s :: # Type }
  -> Eff (enzyme :: ENZYME | e) ShallowWrapper
shallowWithOptions e o = _shallow e $ toForeign opts
  where
    opts = mergeOpts o
