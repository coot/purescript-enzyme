module Test.Main where

import Prelude

import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import DOM (DOM)
import Enzyme.Types (ENZYME)
import Test.ReactWrapper (testSuite) as ReactWrapper
import Test.ShallowWrapper (testSuite) as ShallowWrapper
import Test.Unit.Karma (runKarma)

main :: forall e. Eff (avar :: AVAR, console :: CONSOLE, dom :: DOM, enzyme :: ENZYME | e) Unit
main = runKarma do
  ShallowWrapper.testSuite
  ReactWrapper.testSuite
