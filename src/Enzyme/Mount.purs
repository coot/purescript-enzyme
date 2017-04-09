module Enzyme.Mount where

import Prelude (($))
import DOM.Node.Types (Node)
import Data.Maybe (Maybe(..), maybe)
import Data.Foreign (Foreign, toForeign)
import Data.Record (merge)
import Enzyme.ReactWrapper (ReactWrapper)
import React (ReactElement)

import Enzyme.Types (undefined)

type Optional = (attachTo :: Maybe Node, context :: Foreign)
type MountOptions = {|Optional}

defaults :: {|Optional}
defaults = { attachTo: Nothing, context: toForeign undefined }

foreign import _mount :: ReactElement -> Foreign -> ReactWrapper

mount :: ReactElement -> MountOptions -> ReactWrapper
mount e o = _mount e $
            toForeign
              { attachTo: maybe (toForeign undefined) toForeign opts.attachTo
              , context: opts.context
              }
  where
    opts :: MountOptions
    opts = merge defaults o
