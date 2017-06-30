module Test.Utils where

import Control.Monad.Eff.Class (liftEff)
import DOM (DOM)
import Data.Foldable (foldMap)
import Data.Monoid.Conj (Conj(..))
import Data.Newtype (ala)
import Enzyme.Mount (mount)
import Enzyme.ReactWrapper as RW
import Enzyme.Shallow (shallow)
import Enzyme.ShallowWrapper as SW
import Enzyme.Types (ENZYME)
import Enzyme.Utils (isValidElement)
import Prelude (bind, discard, pure, unit, ($), (<$>), (>>=))
import React (createClass, createClassStateless, createElement, spec)
import React.DOM as D
import Test.Unit (TestSuite, suite, test)
import Test.Unit.Assert (assert)

testSuite :: forall e. TestSuite (dom :: DOM, enzyme :: ENZYME | e)
testSuite = suite "Utils" do
  suite "isValidElement" do
    test "div" do
      let e = D.div [] []
      assert "div is not a valid elemenent" $ isValidElement e

    test "stateless component" do
      let e = createElement (createClassStateless \_ -> D.div [] []) unit []
      assert "stateless component element is not valid" $ isValidElement e

    test "class component" do
      let e = createElement (createClass (spec unit (\_ -> pure $ D.div [] []))) unit []
      assert "component element is not valid" $ isValidElement e

    suite "ReactWrapper" do
      test "getNode" do
        e <- liftEff do
          mount (D.div [] []) >>= RW.getNode
        assert "is not valid react element" (isValidElement e)

      test "getNodes" do
        es <- liftEff do
          mount (D.div' [ D.main' [], D.div'[], D.span' [] ]) >>= RW.childAt 0 >>= RW.getNodes
        assert "is not valid react element" (ala Conj foldMap (isValidElement <$> es))

      test "get" do
        e1 <- liftEff do
          mount (D.div [] []) >>= RW.get 0
        assert "is not valid react element" (isValidElement e1)
        e2 <- liftEff do
          mount (D.div' [ D.main' [], D.div'[], D.span' [] ]) >>= RW.children >>= RW.get 0
        assert "is not valid react element" (isValidElement e2)

    suite "ShallowWrapper" do
      test "getNode" do
        e <- liftEff do
          shallow (D.div [] []) >>= SW.getNode
        assert "is not valid react element" (isValidElement e)

      test "getNodes" do
        es <- liftEff do
          shallow (D.div' [ D.main' [], D.div'[], D.span' [] ]) >>= SW.childAt 0 >>= SW.getNodes
        assert "is not valid react element" (ala Conj foldMap (isValidElement <$> es))

      test "get" do
        e1 <- liftEff do
          shallow (D.div [] []) >>= SW.get 0
        assert "is not valid react element" (isValidElement e1)
        e2 <- liftEff do
          shallow (D.div' [ D.main' [], D.div'[], D.span' [] ]) >>= SW.children >>= SW.get 0
        assert "is not valid react element" (isValidElement e2)
