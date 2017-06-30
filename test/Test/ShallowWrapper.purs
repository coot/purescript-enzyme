module Test.ShallowWrapper
  ( testSuite
  , isShallowWrapper
  ) where

import Control.Monad.Aff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Except (runExcept)
import DOM (DOM)
import Data.Array (length)
import Data.Either (Either(Right, Left))
import Data.Foldable (foldMap, intercalate)
import Data.Foreign (MultipleErrors, readInt, readString, renderForeignError, toForeign)
import Data.Foreign.Index ((!))
import Data.Monoid.Conj (Conj(..))
import Data.Newtype (ala, over, un)
import Enzyme.Shallow (shallow, shallowWithOptions)
import Enzyme.ShallowWrapper (ShallowWrapper)
import Enzyme.ShallowWrapper as E
import Enzyme.Types (ENZYME)
import Enzyme.Utils (isInstanceOf, isValidElement)
import Prelude (Unit, bind, discard, id, join, not, pure, show, unit, ($), (+), (<$>), (<>), (==), (>), (>>=))
import React (ReactClass, createClass, createClassStateless, createElement, getChildren, getProps, readState, spec, transformState)
import React.DOM as D
import React.DOM.Props as P
import Test.ReactWrapper (CProps(CProps), CState(CState), cProps, cState, isThrowing, readCProps, readCState)
import Test.Unit (TestSuite, failure, suite, test)
import Test.Unit.Assert (assert)
import Unsafe.Coerce (unsafeCoerce)

foreign import isShallowWrapper :: ShallowWrapper -> Boolean

getElementProps :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) (Either MultipleErrors CProps)
getElementProps wrp = do
  fpr <- E.props wrp
  pure $ runExcept (readCProps fpr)

getElementId :: forall e. ShallowWrapper -> Eff (enzyme :: ENZYME | e) (Either MultipleErrors String)
getElementId wrp = do
  fpr <- E.props wrp
  pure $ runExcept do
    id_ <- fpr ! "id" >>= readString
    pure id_


cls :: ReactClass CProps
cls = createClass $ (spec cState render) { displayName = "TestClass" }
  where
    clickFn this ev = do
      transformState this (over CState (\st@{ c } -> st { c = c + 1 }))

    render this = do
      children <- getChildren this
      CProps { id } <- getProps this
      CState { c } <- readState this

      pure $ 
        D.main [ P._id id, unsafeCoerce { ref: "main" }, P.onClick (clickFn this) ]
          [ D.div [ P._id "counter", P.key "key-counter", P.className "counter" ] [ D.text (show c) ]
          , D.div [ P._id "container" ] children
          ]

clsNoRefs :: ReactClass Unit
clsNoRefs = createClassStateless (\_ -> D.main [ P._id "main" ] [ D.text "hello :)"])

testSuite :: forall e. TestSuite (dom :: DOM, enzyme :: ENZYME, console :: CONSOLE | e)
testSuite = suite "ShallowWrapper" do 
  test "getNode" do
    el <- liftEff do
      wrp <- shallow $ createElement cls cProps []
      E.getNode wrp
    assert "its not a valid element" (isValidElement $ el)

  test "getNodes" do
    els <- liftEff do
      wrp <- shallow (createElement cls cProps [])
      E.getNodes wrp
    assert "got en empty array" $ length els > 0
    assert "one node wasn't a react element" $ ala Conj foldMap (isValidElement <$> els)

  test "instance_" do
    inst <- liftEff do
      shallow (createElement cls cProps [])
        >>= E.instance_
    assert "" (isInstanceOf inst cls)

  test "update" do
    wrp <- liftEff do
      wrp' <- shallow $ createElement cls cProps []
      E.update wrp'
    assert "did not received a ShallowWrapper" $ isShallowWrapper wrp

  suite "unmunt" do
    test "unmount & shallow" do
      wrp <- liftEff $ shallow (createElement clsNoRefs unit [])

      wrp' <- liftEff $ E.unmount wrp
      assert "did not received a ShallowWrapper" $ isShallowWrapper wrp

    test "unmount raises on component with refs" do
      wrp <- liftEff $ shallow (createElement clsNoRefs unit [])

      throws <- liftEff $ isThrowing (E.unmount wrp)
      assert "did not throw! :)" throws

  test "setProps & props" do
    fprops <- liftEff do
      wrp <- shallow $ createElement cls cProps []
      wrp' <- E.setProps (CProps { id: "ok" }) wrp
      E.props wrp'

    case runExcept (readCProps fprops) of
      Left _ -> failure "did not read props from foreign value"
      Right (CProps { id: id_ }) -> assert "did not set props" $ id_ == "ok"

  suite "state" do
    test "setState & stateByKey" do
      fc <- liftEff do
        wrp <- shallow (createElement cls cProps []) >>= E.setState (CState { c: 1 })
        E.stateByKey "c" wrp

      case runExcept (readInt fc) of
        Left _ -> failure "did not read counter from foreign value"
        Right c -> assert "did not set state" $ c == 1

    test "setState & state" do
      fst <- liftEff do
        wrp <- shallow (createElement cls cProps []) >>= E.setState (CState { c: 1 })
        E.state wrp

      case runExcept (join (readCState <$> fst)) of
        Left _ -> failure "did not read counter from foreign value"
        Right (CState {c}) -> assert "did not set state" $ c == 1
  
  test "setContext & context" do
    fctx <- liftEff do
      wrp <- shallowWithOptions (createElement cls cProps []) { context: toForeign { ctx: 0 }}
      E.setContext { ctx: 1 } wrp >>= E.context "ctx"

    log "context: TODO"
    -- this does not work, I should modify the class so that ti accepts a context
    {--
      - _ <- traceAnyA fctx
      - case runExcept (readInt fctx) of
      -   Left _ -> failure "did not read ctx from foreign value"
      -   Right c -> assert "did not set state" $ c == 1
      --}

  test "children & at" do
    children <- liftEff do
      shallow (createElement cls cProps []) >>= E.children
    assert "did not received $a ShallowWrapper" $ isShallowWrapper children

  test "childrenBySelector" do
    children <- liftEff do
      shallow (createElement cls cProps []) >>= E.childrenBySelector "#counter"
    assert "did not received $a ShallowWrapper" $ isShallowWrapper children

  test "parents" do
    let oid = (un CProps cProps).id
    epr <- liftEff do
      wrp <- shallow $ createElement cls cProps []
      E.childAt 0 wrp >>= E.parents >>= E.at 0 >>= getElementProps

    case epr of
      Left _ -> failure "reading props failed"
      Right (CProps { id: id_ }) ->
        assert ("wrong id: got " <> id_) $ id_ == oid

  test "parentsBySelector" do
    let oid = (un CProps cProps).id
    epr <- liftEff do
      wrp <- shallow $ createElement cls cProps []
      chl <- E.childAt 0 wrp
      p <- E.parentsBySelector "#main" chl
      getElementProps p

    case epr of
      Left _ -> failure "reading props failed"
      Right (CProps { id: id_ }) ->
        assert ("wrong id: got " <> id_) $ id_ == oid

  test "parent" do
    let oid = (un CProps cProps).id
    epr <- liftEff do
      wrp <- shallow $ createElement cls cProps []
      chl <- E.childAt 0 wrp
      E.parent chl >>= getElementProps

    case epr of
      Left _ -> failure "reading props failed"
      Right (CProps { id: id_ }) ->
        assert ("wrong id: got " <> id_) $ id_ == oid

  test "closest" do
    let oid = (un CProps cProps).id
    epr <- liftEff do
      wrp <- shallow $ createElement cls cProps []
      E.closest "#main" wrp >>= getElementId

    case epr of
      Left errs ->
        failure $ "reading props failed: " <> (intercalate "; " (renderForeignError <$> errs))
      Right id_ ->
        assert ("wrong id: got " <> id_) $ id_ == oid

  test "key" do
    key <- liftEff do
      wrp <- shallow $ createElement cls cProps []
      E.childAt 0 wrp >>= E.key

    assert ("" <> key) $ key == "key-counter"

  suite "type_" do
    test "DOM node" do
      type_ <- liftEff do
        shallow (createElement cls cProps []) >>= E.childAt 0 >>= E.type_

      case type_ of
        Left s -> assert "" $ s == "div"
        Right _ -> failure "should get a string"

    test "ReactClass" do
      type_ <- liftEff do
        shallow (createElement cls cProps []) >>= E.type_

      case type_ of
        Left s -> assert ("should get main, but got: " <> s) $  s == "main"
        Right _ -> failure "should get a string"

  test "name" do
    name <- liftEff do
      shallow (createElement cls cProps []) >>= E.name

    assert ("got " <> name <> " expected main")  $ name == "main"

  suite "hasClass" do
    test "positive" do
      hasClass <- liftEff do
        shallow (createElement cls cProps []) >>= E.childAt 0 >>= E.hasClass "counter"

      assert "expected to have class 'counter'" hasClass

    test "negative" do
      hasClass <- liftEff do
        shallow (createElement cls cProps []) >>= E.childAt 0 >>= E.hasClass "x"

      assert "expected not to have class 'x'" (not hasClass)

  test "map" do
    as <- liftEff do
      shallow (createElement cls cProps []) >>= E.children >>= E.map id

    assert "should get array of length 2" (length as == 2)

  test "reduce" do
    c <- liftEff do
      shallow (createElement cls cProps []) >>= E.children >>= E.reduce (\x _ _ -> x + 1) 0

    assert ("should get 2, but got: " <> show c) $ c == 2

  test "reduceRight" do
    c <- liftEff do
      shallow (createElement cls cProps []) >>= E.children >>= E.reduceRight (\x _ _ -> x + 1) 0

    assert ("should get 2, but got: " <> show c) $ c == 2

  test "slice" do
    s <- liftEff do
      shallow (createElement cls cProps []) >>= E.children >>= E.slice 0 1 >>= E.getNodes

    assert "should get array of length 1" (length s == 1)

  suite "some" do
    test "positive" do
      match <- liftEff do
        shallow (createElement cls cProps []) >>= E.children >>= E.some "div"

      assert "should get true" match

    test "negative" do
      match <- liftEff do
        shallow (createElement cls cProps []) >>= E.children >>= E.some "#abc"

      assert "should get false" (not match)

    test "should throw" do
      throws <- liftEff $ do
        wrp <- shallow (createElement cls cProps [])
        isThrowing (E.some "x" wrp)

      assert "should throw on the root" throws

  test "get" do
    re <- liftEff do
      shallow (createElement cls cProps []) >>= E.get 0

    assert "not a valid element" (isValidElement re)

  test "first" do
    eid <- liftEff do
      first <- shallow (createElement cls cProps []) >>= E.children >>= E.first
      getElementId first

    case eid of
      Left _ -> failure "failed to read id"
      Right id_ ->
        assert ("" <> id_) $ id_ == "counter"

  test "last" do
    eid <- liftEff do
      first <- shallow (createElement cls cProps []) >>= E.children >>= E.last
      getElementId first

    case eid of
      Left _ -> failure "failed to read id"
      Right id_ ->
        assert ("" <> id_) $ id_ == "container"

  test "isEmpty" do
    empty <- liftEff do
      shallow (createElement cls cProps []) >>= E.children >>= E.isEmpty

    assert "" (not empty)

  test "exists" do
    exists <- liftEff do
      shallow (createElement cls cProps []) >>= E.children >>= E.exists

    assert "" exists
