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

-- This actually fails a test `React.isValidElement`
foreign import getNode :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e)  ReactElement

foreign import getNodes :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) (Array ReactElement)

foreign import getDOMNode :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) HTMLElement

foreign import ref :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e)  ReactWrapper

foreign import instance_ :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactClassInstance

foreign import update :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) ReactWrapper

foreign import unmount :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

foreign import mount :: forall e. ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

foreign import setProps :: forall props e. props -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

-- todo: setProps with callback
-- foreign import setPropsFn

foreign import setState :: forall state e. state -> ReactWrapper -> Eff (dom :: DOM, enzyme :: ENZYME | e) ReactWrapper

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

foreign import props :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import state :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

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

foreign import prop :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Foreign

foreign import key :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import type_ :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import name :: forall e. ReactWrapper -> Eff (enzyme :: ENZYME | e) String

foreign import hasClass :: forall e. String -> ReactWrapper -> Eff (enzyme :: ENZYME | e) Boolean

-- foreign import forEach :: ReactWrapper -> (ReactElement -> Unit) -> ReactWrapper

foreign import map :: forall a e. (ReactElement -> a) -> ReactWrapper -> Eff (enzyme :: ENZYME | e) (Array a)

foreign import reduce :: forall a e. (a -> ReactWrapper -> a) -> a -> ReactWrapper -> Eff (enzyme :: ENZYME | e) a

foreign import reduceRight :: forall a e. (a -> ReactWrapper -> a) -> a -> ReactWrapper -> Eff (enzyme :: ENZYME | e) a

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
