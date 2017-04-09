module Enzyme.Mount where

import Prelude (($))
import DOM.Node.Types (Node)
import Data.Maybe (Maybe(..), maybe)
import Data.Foreign (Foreign, toForeign)
import Data.Record.Class (class Subrow)
import Enzyme.ReactWrapper (ReactWrapper)
import React (ReactElement)

import Enzyme.Internals (undefined, unsafeMerge)

type Mandatory r = (|r) :: # Type
type Optional r = (attachTo :: Maybe Node, context :: Foreign | r)
type MountOptions r = Record (Mandatory (Optional r))

defaults :: {|Optional ()}
defaults = { attachTo: Nothing, context: toForeign undefined }

mergeOpts
  :: forall r s
  .  Union r (Optional ()) (Optional s)
  => Subrow s (Optional ())
  => Record (Mandatory r)
  -> Record (Optional s)
mergeOpts o = unsafeMerge o defaults 

foreign import _mount :: ReactElement -> Foreign -> ReactWrapper

mount :: ReactElement -> ReactWrapper
mount e = _mount e (toForeign defaults)

mountWithOptions
  :: forall r s t
   .  Union s (Optional ()) (Optional r)
  => Union r t (Optional ())
  => ReactElement
  -> { | s :: # Type }
  -> ReactWrapper
mountWithOptions e o = _mount e $
            toForeign
              { attachTo: maybe (toForeign undefined) toForeign opts.attachTo
              , context: opts.context
              }
  where
    opts = mergeOpts o
