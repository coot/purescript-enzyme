module Enzyme.ReactWrapper where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML.Types (HTMLElement)
import Data.Foreign (Foreign)
import Enzyme.Types (ENZYME, ReactClassInstance)
import React (ReactClass, ReactElement)
import Unsafe.Coerce (unsafeCoerce)

foreign import data ReactWrapper :: Type

foreign import getNode :: ReactWrapper -> ReactElement

foreign import getNodes :: ReactWrapper -> Array ReactElement

foreign import getDOMNode :: ReactWrapper -> HTMLElement

foreign import ref :: ReactWrapper -> String -> ReactWrapper

foreign import instance_ :: ReactWrapper -> ReactClassInstance

foreign import update :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import unmount :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import mount :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import setProps :: forall props. ReactWrapper -> props -> ReactWrapper

-- todo: setProps with callback
-- foreign import setPropsFn

foreign import setState :: forall state. ReactWrapper -> state -> ReactWrapper

-- todo: setState with callback
-- foreign import setStateFn

foreign import setContext :: forall ctx. ReactWrapper -> ctx -> ReactWrapper

foreign import matchesElement :: ReactWrapper -> ReactElement -> Boolean

foreign import containsNode :: ReactWrapper -> ReactElement -> Boolean

foreign import containsNodes :: ReactWrapper -> Array ReactElement -> Boolean

foreign import containsMatchingElement :: ReactWrapper -> ReactElement -> Boolean

foreign import containsAllMatchingElements :: ReactWrapper -> Array ReactElement -> Boolean

foreign import containsAnyMatchingElements :: ReactWrapper -> Array ReactElement -> Boolean

-- apriori we don't know what is the cls of the returned ReactWrapper
foreign import find :: ReactWrapper -> String -> ReactWrapper

findReactClass :: forall props. ReactWrapper -> ReactClass props -> ReactWrapper 
findReactClass wrp cls = find wrp (unsafeCoerce cls)

-- todo: find with callback
-- foreign import findFn

foreign import is :: ReactWrapper -> String -> Boolean

foreign import isEmptyRender :: ReactWrapper -> Boolean

foreign import filterWhere :: ReactWrapper -> (ReactWrapper -> Boolean) -> ReactWrapper

foreign import filter :: ReactWrapper -> String -> ReactWrapper

-- todo: filter with callback

foreign import not :: ReactWrapper -> String -> ReactWrapper

-- todo: not with callback

foreign import text :: ReactWrapper -> String

foreign import html :: ReactWrapper -> String

-- todo CheerioWrapper
-- foreign import render :: ReactWrapper -> CheerioWrapper

foreign import simulate :: ReactWrapper -> String -> ReactWrapper

foreign import simulateAndMock :: ReactWrapper -> String -> Foreign -> ReactWrapper

foreign import props :: ReactWrapper -> Foreign

foreign import state :: ReactWrapper -> String -> Foreign

foreign import context :: ReactWrapper -> String -> Foreign

foreign import children :: ReactWrapper -> ReactWrapper

foreign import childrenBySelector :: ReactWrapper -> String -> ReactWrapper

-- todo: children with callback

foreign import childAt :: ReactWrapper -> Int -> ReactWrapper

foreign import parents :: ReactWrapper -> String -> ReactWrapper

-- todo: parents with callback

foreign import parent :: ReactWrapper -> ReactWrapper

foreign import closest :: ReactWrapper -> String -> ReactWrapper

-- todo: closest with callback

foreign import prop :: ReactWrapper -> String -> Foreign

foreign import key :: ReactWrapper -> String

foreign import type_ :: ReactWrapper -> String

foreign import name :: ReactWrapper -> String

foreign import hasClass :: ReactWrapper -> String -> Boolean

-- foreign import forEach :: ReactWrapper -> (ReactElement -> Unit) -> ReactWrapper

foreign import map :: forall a. ReactWrapper -> (ReactElement -> a) -> Array a

foreign import reduce :: forall a. ReactWrapper -> (a -> ReactWrapper -> a) -> a -> a

foreign import reduceRight :: forall a. ReactWrapper -> (a -> ReactWrapper -> a) -> a -> a

foreign import slice :: ReactWrapper -> Int -> Int -> ReactWrapper

foreign import some :: ReactWrapper -> String -> Boolean

-- todo: some with callback

foreign import someWhere :: ReactWrapper -> (ReactWrapper -> Boolean) -> Boolean

foreign import every :: ReactWrapper -> String -> Boolean

-- todo: every with callback

foreign import everyWhere :: ReactWrapper -> (ReactWrapper -> Boolean) -> Boolean

foreign import get :: ReactWrapper -> Int -> ReactElement

foreign import at :: ReactWrapper -> Int -> ReactWrapper

foreign import first :: ReactWrapper -> ReactWrapper

foreign import last :: ReactWrapper -> ReactWrapper

foreign import isEmpty :: ReactWrapper -> Boolean

foreign import exists :: ReactWrapper -> Boolean

foreign import debug :: ReactWrapper -> String

-- todo: tap

foreign import detach :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) Unit
