module Enzyme.ShallowWrapper
  ( ShallowWrapper
  , getNode
  , getNodes
  , instance_
  , update
  , rerender
  , rerenderWithContext
  , setProps
  , setState
  , setState_
  , setContext
  , containsNode
  , containsNodes
  , containsMatchingElement
  , containsAllMatchingElements
  , containsAnyMatchingElements
  , equals
  , matchesElement
  , find
  , findReactClass
  , is
  , isEmptyRender
  , filterWhere
  , filter
  , not
  , text
  , html
  , unmount
  , simulate
  , simulateWithArgs
  , props
  , prop
  , state
  , unsafeState
  , state_
  , stateByKey
  , context
  , children
  , childrenBySelector
  , childAt
  , parents
  , parentsBySelector
  , parent
  , closest
  , shallow
  , key
  , type_
  , name
  , hasClass
  , map
  , reduce
  , reduceRight
  , slice
  , some
  , someWhere
  , every
  , everyWhere
  , findWhere
  , get
  , at
  , first
  , last
  , isEmpty
  , exists
  , debug
  , dive 
  ) where

import Control.Monad.Eff (Eff)
import Control.Monad.Except (runExcept)
import Data.Either (Either(..))
import Data.Foreign (Foreign, F, isNull, readString, toForeign)
import Data.Foreign.Index (readProp)
import Enzyme.Types (ENZYME)
import Prelude (bind, pure, (<$>))
import React (ReactClass, ReactElement, ReactThis)
import Type.Proxy (Proxy)
import Unsafe.Coerce (unsafeCoerce)

foreign import data ShallowWrapper :: Type

foreign import getNode :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ReactElement

foreign import getNodes :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) (Array ReactElement)

foreign import instance_ :: forall props state e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) (ReactThis props state)

foreign import update :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import rerender :: forall props e. props -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import rerenderWithContext :: forall props context e. props -> context -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import setProps :: forall props r e. props -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) r

-- todo: setProps with callback
-- foreign import setPropsFn

-- | Set state of your component.  Note that it will wrap as `{ state: state }`,
-- | since this is what `purescript-react` does in it's own bindings.
setState :: forall state e. state -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper
setState st = setState_ (toForeign { state: st })

-- | The original which does not wrap state
foreign import setState_ :: forall e. Foreign -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: setState with callback
-- foreign import setStateFn

foreign import setContext :: forall ctx e. ctx -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import containsNode :: forall e. ReactElement -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsNodes :: forall e. Array ReactElement -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsMatchingElement :: forall e. ReactElement -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsAllMatchingElements :: forall e. Array ReactElement -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsAnyMatchingElements :: forall e. Array ReactElement -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import equals :: forall e. ReactElement -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import matchesElement :: forall e. ReactElement -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- apriori we don't know what is the cls of the returned ShallowWrapper
foreign import find :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

findReactClass :: forall props e. ReactClass props -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper 
findReactClass cls wrp = find (unsafeCoerce cls) wrp

-- todo: find with callback
-- foreign import findFn

foreign import is :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import isEmptyRender :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import filterWhere :: forall e. (ShallowWrapper -> Boolean) -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import filter :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: filter with callback

foreign import not :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: not with callback

foreign import text :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import html :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

-- todo CheerioWrapper
-- foreign import render :: ShallowWrapper -> CheerioWrapper

foreign import unmount :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import simulate :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import simulateWithArgs :: forall e. String -> Array Foreign -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import props :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Foreign

unsafeProps :: forall props e. Proxy props -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) props
unsafeProps _ wrp = unsafeCoerce <$> props wrp

foreign import prop :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Foreign

-- | Note that `purescript-react` writes state as `{ state: state }`
-- | (so you can use any purescript value as state).  This function will unwrap
-- | the state and return what you specified in your `ReactSpec` signature.
-- |
-- | Use `runExcept $ join ((readState :: Foreign -> State) <$> state)` to read
-- | the state from `F Foreign`.
state :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) (F Foreign)
state wrp = do
  st <- state_ wrp
  pure (readProp "state" st)

unsafeState :: forall e state. Proxy state -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) state
unsafeState _ wrp = unsafeCoerce <$> state_ wrp

-- | The original which does not unwrap the state.
foreign import state_ :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import stateByKey :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import context :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import children :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import childrenBySelector :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: children with callback

foreign import childAt :: forall e. Int -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import parents :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import parentsBySelector :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: parents with callback

foreign import parent :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import closest :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import shallow :: forall e. Foreign -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: closest with callback

foreign import key :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import typeImpl :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Foreign

type_ :: forall e p. ShallowWrapper -> Eff (enzyme :: ENZYME | e) (Either String (ReactClass p))
type_ wrp = do
  f <- typeImpl wrp
  pure (readForeign f)

 where
   readForeign :: Foreign -> Either String (ReactClass p)
   readForeign obj =
     if isNull obj
       then Left ""
       else case runExcept (readString obj) of
        Left _ -> Right (unsafeCoerce obj)
        Right s -> Left s

foreign import name :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import hasClass :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- foreign import forEach :: (ReactElement -> Unit) -> ShallowWrapper

foreign import map :: forall a e. (ReactElement -> a) -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) (Array a)

foreign import reduce :: forall a e. (a -> ShallowWrapper -> Int -> a) -> a -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) a

foreign import reduceRight :: forall a e. (a -> ShallowWrapper -> Int -> a) -> a -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) a

foreign import slice :: forall e. Int -> Int -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import some :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- todo: some with callback

foreign import someWhere :: forall e. (ShallowWrapper -> Boolean) -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import every :: forall e. String -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- todo: every with callback

foreign import everyWhere :: forall e. (ShallowWrapper -> Boolean) -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import findWhere :: forall e. (ShallowWrapper -> Boolean) -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import get :: forall e. Int -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ReactElement

foreign import at :: forall e. Int -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import first :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import last :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import isEmpty :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import exists :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import debug :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

-- todo: tap

foreign import dive :: forall e. Foreign -> ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper
