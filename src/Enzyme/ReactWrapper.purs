module Enzyme.ReactWrapper
  ( ReactWrapper
  , getNode
  , getNodes
  , getDOMNode
  , ref
  , instance_
  , update
  , unmount
  , mount
  , setProps
  , setState
  , setState_
  , setContext
  , matchesElement
  , containsNode
  , containsNodes
  , containsMatchingElement
  , containsAllMatchingElements
  , containsAnyMatchingElements
  , find
  , findReactClass
  , is
  , isEmptyRender
  , filterWhere
  , filter
  , not
  , text
  , html
  , simulate
  , simulateAndMock
  , props
  , state
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
  , prop
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
  , get
  , at
  , first
  , last
  , isEmpty
  , exists
  , debug
  , detach
  ) where

import Control.Monad.Eff (Eff)
import Control.Monad.Except (runExcept)
import DOM (DOM)
import DOM.HTML.Types (HTMLElement)
import Data.Either (Either(Left, Right))
import Data.Foreign (Foreign, F, readString, toForeign)
import Data.Foreign.Index (readProp)
import Enzyme.Types (ENZYME)
import Prelude (Unit, bind, pure)
import React (ReactClass, ReactElement, ReactThis)
import Unsafe.Coerce (unsafeCoerce)

foreign import data ReactWrapper :: Type

-- This actually fails a test `React.isValidElement`
foreign import getNode :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e)  ReactElement

foreign import getNodes :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) (Array ReactElement)

foreign import getDOMNode :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) HTMLElement

foreign import ref :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e)  ReactWrapper

foreign import instance_ :: forall e props state. ReactWrapper -> Eff (enzyme :: ENZYME | e) (ReactThis props state)

foreign import update :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import unmount :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

foreign import mount :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

foreign import setProps :: forall props e. props -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

-- todo: setProps with callback
-- foreign import setPropsFn

-- | Set state of your component.  Note that it will wrap as `{ state: state }`,
-- | since this is what `purescript-react` does in it's own bindings.
setState :: forall state e. state -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper
setState st = setState_ (toForeign { state: st })

-- | The original which does not wrap state
foreign import setState_ :: forall e. Foreign -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

-- todo: setState with callback
-- foreign import setStateFn

foreign import setContext :: forall ctx e. ctx -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

foreign import matchesElement :: forall e. ReactElement -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsNode :: forall e. ReactElement -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsNodes :: forall e. Array ReactElement -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsMatchingElement :: forall e. ReactElement -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsAllMatchingElements :: forall e. Array ReactElement -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsAnyMatchingElements :: forall e. Array ReactElement -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- apriori we don't know what is the cls of the returned ReactWrapper
foreign import find :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

findReactClass :: forall props e. ReactClass props -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper 
findReactClass cls wrp = find (unsafeCoerce cls) wrp

-- todo: find with callback
-- foreign import findFn

foreign import is :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import isEmptyRender :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import filterWhere :: forall e. (ReactWrapper -> Boolean) -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import filter :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

-- todo: filter with callback

foreign import not :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

-- todo: not with callback

foreign import text :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import html :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

-- todo CheerioWrapper
-- foreign import render :: ReactWrapper -> CheerioWrapper

foreign import simulate :: forall e. String -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

foreign import simulateAndMock :: forall e. String -> Foreign -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

foreign import prop :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import props :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

-- | Note that `purescript-react` writes state as `{ state: state }`
-- | (so you can use any purescript value as state).  This function will unwrap
-- | the state and return something of the type in your `ReactSpec` signature.
-- |
-- | Use `runExcept $ join ((readState :: Foreign -> State) <$> state)` to read
-- | the state from `F Foreign`.
state :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) (F Foreign)
state wrp = do
  st <- state_ wrp
  pure (readProp "state" st)

-- | The original which does not unwrap the state.
foreign import state_ :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

-- | The same note above applied to `stateByKey`.
foreign import stateByKey :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import context :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import children :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import childrenBySelector :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

-- todo: children with callback

foreign import childAt :: forall e. Int -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import parents :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import parentsBySelector :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

-- todo: parents with callback

foreign import parent :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import closest :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

-- todo: closest with callback

foreign import key :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import typeImpl :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

-- todo: I am not sure if `ReactClass` is what is returened
type_ :: forall p e. ReactWrapper -> Eff (enzyme :: ENZYME | e) (Either String (ReactClass p))
type_ wrp = do
  f <- typeImpl wrp
  pure (readForeign f)

 where
   readForeign :: Foreign -> Either String (ReactClass p)
   readForeign obj =
     case runExcept (readString obj) of
       Left _ -> Right (unsafeCoerce obj)
       Right s -> Left s


foreign import name :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import hasClass :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- foreign import forEach :: ReactWrapper -> (ReactElement -> Unit) -> ReactWrapper

foreign import map :: forall a e. (ReactElement -> a) -> ReactWrapper -> Eff (enzyme :: ENZYME | e) (Array a)

foreign import reduce :: forall a e. (a -> ReactWrapper -> Int -> a) -> a -> ReactWrapper -> Eff (enzyme :: ENZYME | e) a

foreign import reduceRight :: forall a e. (a -> ReactWrapper -> Int -> a) -> a -> ReactWrapper -> Eff (enzyme :: ENZYME | e) a

foreign import slice :: forall e. Int -> Int -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import some :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- todo: some with callback

foreign import someWhere :: forall e. (ReactWrapper -> Boolean) -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import every :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- todo: every with callback

foreign import everyWhere :: forall e. (ReactWrapper -> Boolean) -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import get :: forall e. Int -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactElement

foreign import at :: forall e. Int -> ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import first :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import last :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import isEmpty :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import exists :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import debug :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

-- todo: tap

foreign import detach :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) Unit
