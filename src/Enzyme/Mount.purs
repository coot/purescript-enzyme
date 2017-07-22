module Enzyme.Mount 
  ( mount
  , mountWithOptions
  ) where

import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.Node.Types (Node)
import Data.Foreign (Foreign, toForeign)
import Data.Maybe (Maybe(..), maybe)
import Enzyme.Class (class Subrow)
import Enzyme.Internals (undefined, unsafeMerge)
import Enzyme.ReactWrapper (ReactWrapper)
import Enzyme.Types (ENZYME)
import Prelude (($))
import React (ReactElement)

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

foreign import _mount :: forall e. ReactElement -> Foreign -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

mount :: forall e. ReactElement -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper
mount e = _mount e (toForeign {})

mountWithOptions
  :: forall r s t e
   .  Union s (Optional ()) (Optional r)
  => Union r t (Optional ())
  => ReactElement
  -> { | s :: # Type }
  -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper
mountWithOptions e o = _mount e $
            toForeign
              { attachTo: maybe (toForeign undefined) toForeign opts.attachTo
              , context: opts.context
              }
  where
    opts = mergeOpts o
