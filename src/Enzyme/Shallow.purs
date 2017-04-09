module Enzyme.Shallow
  ( shallow
  , shallowWithOptions
  ) where

import Prelude (($))

import Data.Foreign (Foreign, toForeign)
import Data.Record.Class (class Subrow)
import Enzyme.ShallowWrapper (ShallowWrapper)
import React (ReactElement)

import Enzyme.Internals (undefined, unsafeMerge)

foreign import _shallow :: ReactElement -> Foreign -> ShallowWrapper

type Mandatory r = (|r) :: # Type
type Optional r = (lifecycleExperimental :: Boolean, context :: Foreign | r)
type ShallowOptions r = Record (Mandatory (Optional r))

defaults :: {|Optional ()}
defaults = { lifecycleExperimental: false, context: toForeign undefined }

shallow :: ReactElement -> ShallowWrapper
shallow e = _shallow e (toForeign defaults)

mergeOpts
  :: forall r s
  .  Union r (Optional ()) (Optional s)
  => Subrow s (Optional ())
  => Record (Mandatory r)
  -> Record (Optional s)
mergeOpts o = unsafeMerge o defaults

shallowWithOptions
  :: forall r s t
   .  Union s (Optional ()) (Optional r)
  => Union r t (Optional ())
  => ReactElement
  -> { | s :: # Type }
  -> ShallowWrapper
shallowWithOptions e o = _shallow e $ toForeign opts
  where
    opts = mergeOpts o
