module Enzyme.ShallowWrapper where

import Control.Monad.Eff (Eff)
import Data.Foreign (Foreign)
import Enzyme.Types (ENZYME, ReactClassInstance)
import React (ReactClass, ReactElement)
import Unsafe.Coerce (unsafeCoerce)

foreign import data ShallowWrapper :: Type

foreign import getNode :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ReactElement

foreign import getNodes :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) (Array ReactElement)

foreign import ref :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import instance_ :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ReactClassInstance

foreign import update :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import rerender :: forall props e. ShallowWrapper -> props -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import rerenderWithContext :: forall props context e. ShallowWrapper -> props -> context -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import setProps :: forall props r e. ShallowWrapper -> props -> Eff (enzyme :: ENZYME | e) r

-- todo: setProps with callback
-- foreign import setPropsFn

foreign import setState :: forall state e. ShallowWrapper -> state -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: setState with callback
-- foreign import setStateFn

foreign import setContext :: forall ctx e. ShallowWrapper -> ctx -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import containsNode :: forall e. ShallowWrapper -> ReactElement -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsNodes :: forall e. ShallowWrapper -> Array ReactElement -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsMatchingElement :: forall e. ShallowWrapper -> ReactElement -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsAllMatchingElements :: forall e. ShallowWrapper -> Array ReactElement -> Eff (enzyme :: ENZYME | e) Boolean

foreign import containsAnyMatchingElements :: forall e. ShallowWrapper -> Array ReactElement -> Eff (enzyme :: ENZYME | e) Boolean

foreign import equals :: forall e. ShallowWrapper -> ReactElement -> Eff (enzyme :: ENZYME | e) Boolean

foreign import matchesElement :: forall e. ShallowWrapper -> ReactElement -> Eff (enzyme :: ENZYME | e) Boolean

-- apriori we don't know what is the cls of the returned ShallowWrapper
foreign import find :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

findReactClass :: forall props e. ShallowWrapper -> ReactClass props -> Eff (enzyme :: ENZYME | e) ShallowWrapper 
findReactClass wrp cls = find wrp (unsafeCoerce cls)

-- todo: find with callback
-- foreign import findFn

foreign import is :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) Boolean

foreign import isEmptyRender :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import filterWhere :: forall e. ShallowWrapper -> (ShallowWrapper -> Boolean) -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import filter :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: filter with callback

foreign import not :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: not with callback

foreign import text :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import html :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

-- todo CheerioWrapper
-- foreign import render :: ShallowWrapper -> CheerioWrapper

foreign import unmount :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import simulate :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import simulateWithArgs :: forall e. ShallowWrapper -> String -> Array Foreign -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import props :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import state :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) Foreign

foreign import context :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) Foreign

foreign import children :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import childrenBySelector :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: children with callback

foreign import childAt :: forall e. ShallowWrapper -> Int -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import parents :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: parents with callback

foreign import parent :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import closest :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import shallow :: forall e. ShallowWrapper -> Foreign -> Eff (enzyme :: ENZYME | e) ShallowWrapper

-- todo: closest with callback

foreign import prop :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) Foreign

foreign import key :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import type_ :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import name :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import hasClass :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) Boolean

-- foreign import forEach :: ShallowWrapper -> (ReactElement -> Unit) -> ShallowWrapper

foreign import map :: forall a e. ShallowWrapper -> (ReactElement -> a) -> Eff (enzyme :: ENZYME | e) (Array a)

foreign import reduce :: forall a e. ShallowWrapper -> (a -> ShallowWrapper -> a) -> a -> Eff (enzyme :: ENZYME | e) a

foreign import reduceRight :: forall a e. ShallowWrapper -> (a -> ShallowWrapper -> a) -> a -> Eff (enzyme :: ENZYME | e) a

foreign import slice :: forall e. ShallowWrapper -> Int -> Int -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import some :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) Boolean

-- todo: some with callback

foreign import someWhere :: forall e. ShallowWrapper -> (ShallowWrapper -> Boolean) -> Eff (enzyme :: ENZYME | e) Boolean

foreign import every :: forall e. ShallowWrapper -> String -> Eff (enzyme :: ENZYME | e) Boolean

-- todo: every with callback

foreign import everyWhere :: forall e. ShallowWrapper -> (ShallowWrapper -> Boolean) -> Eff (enzyme :: ENZYME | e) Boolean

foreign import findWhere :: forall e. ShallowWrapper -> (ShallowWrapper -> Boolean) -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import get :: forall e. ShallowWrapper -> Int -> Eff (enzyme :: ENZYME | e) ReactElement

foreign import at :: forall e. ShallowWrapper -> Int -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import first :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import last :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) ShallowWrapper

foreign import isEmpty :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import exists :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) Boolean

foreign import debug :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) String

-- todo: tap

foreign import dive :: forall e. ShallowWrapper -> Foreign -> Eff (enzyme :: ENZYME | e) ShallowWrapper
