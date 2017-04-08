module Enzyme.ShallowWrapper where

import Prelude

import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML.Types (HTMLElement)
import Data.Foreign (Foreign)
import React (ReactElement)
import Enzyme.Types (ENZYME, ReactClassInstance)

foreign import data ShallowWrapper :: Type

foreign import getNode :: ShallowWrapper -> ReactElement

foreign import getNodes :: ShallowWrapper -> Array ReactElement

foreign import ref :: ShallowWrapper -> String -> HTMLElement

foreign import instance_ :: ShallowWrapper -> ReactClassInstance

foreign import update :: ShallowWrapper -> Eff (enzyme :: ENZYME) ShallowWrapper

foreign import rerender :: forall props . props -> ShallowWrapper

foreign import rerenderWithContext :: forall props context. props -> context -> ShallowWrapper

foreign import setProps :: forall props. ShallowWrapper -> props -> ShallowWrapper

-- todo: setProps with callback
-- foreign import setPropsFn

foreign import setState :: forall state. ShallowWrapper -> state -> ShallowWrapper

-- todo: setState with callback
-- foreign import setStateFn

foreign import setContext :: forall ctx. ShallowWrapper -> ctx -> ShallowWrapper

foreign import containsNode :: ShallowWrapper -> ReactElement -> Boolean

foreign import containsNodes :: ShallowWrapper -> Array ReactElement -> Boolean

foreign import containsMatchingElement :: ShallowWrapper -> ReactElement -> Boolean

foreign import containsAllMatchingElements :: ShallowWrapper -> Array ReactElement -> Boolean

foreign import containsAnyMatchingElements :: ShallowWrapper -> Array ReactElement -> Boolean

foreign import equals :: ShallowWrapper -> ReactElement -> Boolean

foreign import matchesElement :: ShallowWrapper -> ReactElement -> Boolean

-- apriori we don't know what is the cls of the returned ShallowWrapper
foreign import find :: ShallowWrapper -> String -> ShallowWrapper

-- todo: find with callback
-- foreign import findFn

foreign import is :: ShallowWrapper -> String -> Boolean

foreign import isEmptyRender :: ShallowWrapper -> Boolean

foreign import filterWhere :: ShallowWrapper -> (ShallowWrapper -> Boolean) -> ShallowWrapper

foreign import filter :: ShallowWrapper -> String -> ShallowWrapper

-- todo: filter with callback

foreign import not :: ShallowWrapper -> String -> ShallowWrapper

-- todo: not with callback

foreign import text :: ShallowWrapper -> String

foreign import html :: ShallowWrapper -> String

-- todo CheerioWrapper
-- foreign import render :: ShallowWrapper -> CheerioWrapper

foreign import unmount :: ShallowWrapper -> ShallowWrapper

foreign import simulate :: ShallowWrapper -> String -> ShallowWrapper

foreign import simulateWithArgs :: ShallowWrapper -> String -> Array Foreign -> ShallowWrapper

foreign import props :: ShallowWrapper -> Foreign

foreign import state :: ShallowWrapper -> String -> Foreign

foreign import context :: ShallowWrapper -> String -> Foreign

foreign import children :: ShallowWrapper -> String -> ShallowWrapper

-- todo: children with callback

foreign import childAt :: ShallowWrapper -> Int -> ShallowWrapper

foreign import parents :: ShallowWrapper -> String -> ShallowWrapper

-- todo: parents with callback

foreign import parent :: ShallowWrapper -> ShallowWrapper

foreign import closest :: ShallowWrapper -> String -> ShallowWrapper

foreign import shallow :: ShallowWrapper -> Foreign -> ShallowWrapper

-- todo: closest with callback

foreign import prop :: ShallowWrapper -> String -> Foreign

foreign import key :: ShallowWrapper -> String

foreign import type_ :: ShallowWrapper -> String

foreign import name :: ShallowWrapper -> String

foreign import hasClass :: ShallowWrapper -> String -> Boolean

-- foreign import forEach :: ShallowWrapper -> (ReactElement -> Unit) -> ShallowWrapper

foreign import map :: forall a. ShallowWrapper -> (ReactElement -> a) -> Array a

foreign import reduce :: forall a. ShallowWrapper -> (a -> ShallowWrapper -> a) -> a -> a

foreign import reduceRight :: forall a. ShallowWrapper -> (a -> ShallowWrapper -> a) -> a -> a

foreign import slice :: ShallowWrapper -> Int -> Int -> ShallowWrapper

foreign import some :: ShallowWrapper -> String -> Boolean

-- todo: some with callback

foreign import someWhere :: ShallowWrapper -> (ShallowWrapper -> Boolean) -> Boolean

foreign import every :: ShallowWrapper -> String -> Boolean

-- todo: every with callback

foreign import everyWhere :: ShallowWrapper -> (ShallowWrapper -> Boolean) -> Boolean

foreign import findWhere :: ShallowWrapper -> (ShallowWrapper -> Boolean) -> ShallowWrapper

foreign import get :: ShallowWrapper -> Int -> ReactElement

foreign import at :: ShallowWrapper -> Int -> ShallowWrapper

foreign import first :: ShallowWrapper -> ShallowWrapper

foreign import last :: ShallowWrapper -> ShallowWrapper

foreign import isEmpty :: ShallowWrapper -> Boolean

foreign import exists :: ShallowWrapper -> Boolean

foreign import debug :: ShallowWrapper -> String

-- todo: tap

foreign import dive :: ShallowWrapper -> Foreign -> ShallowWrapper
