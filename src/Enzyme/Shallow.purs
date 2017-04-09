module Enzyme.Shallow
  ( shallow
  ) where

import Prelude (($))
import Data.Foreign (Foreign, toForeign)
import Data.Record (merge)
import React (ReactElement)
import Enzyme.ShallowWrapper (ShallowWrapper)

import Enzyme.Types (undefined)

foreign import _shallow :: ReactElement -> Foreign -> ShallowWrapper

type Optional = (lifecycleExperimental :: Boolean, context :: Foreign)
type ShallowOptions = {|Optional}

defaults :: {|Optional}
defaults = { lifecycleExperimental: false, context: toForeign undefined }

-- | shallow accepts ReactElement and ShallowOptions.  The later is a record
-- | with two optinal fields: field `lifecycleExperimental` with a boolean value,
-- | and `context` - a `Foreign` object.
shallow :: ReactElement -> ShallowOptions -> ShallowWrapper
shallow e o = _shallow e $ toForeign opts
  where
    opts :: ShallowOptions
    opts = merge defaults o
