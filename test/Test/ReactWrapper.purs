module Test.ReactWrapper
  ( testSuite
  , CProps(..)
  , CState(..)
  , readCProps
  , cls
  , cState
  , cProps
  , isValidElement
  , isReactWrapper
  , isThrowing
  , unsafeGetReactElement
  ) where

import Control.Monad.Aff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Except (runExcept)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (HTMLElement, htmlDocumentToDocument, htmlElementToElement, readHTMLElement)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement) as DOM
import DOM.Node.Element (id) as Element
import DOM.Node.Node (appendChild, removeChild)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.ParentNode (QuerySelector(..), querySelector)
import DOM.Node.Types (Element, ElementId(ElementId), documentToNonElementParentNode, documentToParentNode, elementToNode)
import Data.Array (length)
import Data.Either (Either(..), isRight)
import Data.Foldable (foldMap)
import Data.Foreign (F, Foreign, readInt, readString, toForeign)
import Data.Foreign.Index ((!))
import Data.Maybe (Maybe(..), fromJust, isJust)
import Data.Monoid.Conj (Conj(..))
import Data.Newtype (class Newtype, ala, over, un)
import Enzyme.Mount (mount, mountWithOptions)
import Enzyme.ReactWrapper (ReactWrapper)
import Enzyme.ReactWrapper as E
import Enzyme.Types (ENZYME)
import Partial.Unsafe (unsafePartial)
import Prelude (bind, discard, id, not, pure, show, void, ($), (+), (<$>), (<<<), (<>), (==), (>), (>>=))
import React (ReactClass, ReactElement, createClass, createElement, getChildren, getProps, readState, spec, transformState)
import React.DOM as D
import React.DOM.Props as P
import Test.Unit (TestSuite, failure, success, suite, test)
import Test.Unit.Assert (assert)
import Unsafe.Coerce (unsafeCoerce)

newtype CProps = CProps { id :: String }

derive instance newtypeCProps :: Newtype CProps _

cProps :: CProps
cProps = CProps { id: "main" }

readCProps :: Foreign -> F CProps
readCProps obj = do
  id_ <- obj ! "id" >>= readString
  pure (CProps { id: id_ })

unsafeSetKey :: CProps -> String -> CProps
unsafeSetKey props key = over CProps up props
  where
    up p = unsafeCoerce ((unsafeCoerce p) { key = key })

newtype CState = CState { c :: Int }

cState :: CState
cState = CState { c: 0 }

readCState :: Foreign -> F CState
readCState obj = do
  c <- obj ! "c" >>= readInt
  pure (CState { c })

derive instance newtypeCState :: Newtype CState _

foreign import isValidElement :: ReactElement -> Boolean

foreign import unsafeGetReactElement :: ReactElement -> ReactElement

foreign import isReactWrapper :: ReactWrapper -> Boolean

foreign import isThrowing :: forall e a. Eff e a -> Eff e Boolean

findElementById :: forall e. ElementId -> Eff (dom :: DOM | e) (Maybe Element)
findElementById _id = do
  d <- window >>= document
  getElementById _id (castDocument d)
  where
    castDocument = documentToNonElementParentNode <<< htmlDocumentToDocument

getElementId :: forall e. HTMLElement -> Eff (dom :: DOM | e) ElementId
getElementId = Element.id <<< htmlElementToElement

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

testSuite :: forall e. TestSuite (dom :: DOM, enzyme :: ENZYME, console :: CONSOLE | e)
testSuite = suite "ReactWrapper" do 
  test "getNode" do
    el <- liftEff do
      wrp <- mount $ createElement cls cProps []
      E.getNode wrp
    assert "its not a valid element" (isValidElement $ unsafeGetReactElement el)

  test "getNodes" do
    els <- liftEff do
      wrp <- mount $ createElement cls cProps []
      E.getNodes wrp
    assert "got en empty array" $ length els > 0
    assert "one node wasn't a react element" $ ala Conj foldMap (isValidElement <<< unsafeGetReactElement <$> els)

  test "getDOMNode" do
    f <- liftEff do
      wrp <- mount $ createElement cls cProps []
      toForeign <$> E.getDOMNode wrp

    assert "did not received a HTMLElement" $ isRight (runExcept (readHTMLElement f))

  test "ref" do
    wrp <- liftEff do
      wrp <- mount $ createElement cls cProps []
      E.ref "main" wrp
    assert "did not received a ReactWrapper" $ isReactWrapper wrp
    ElementId _id <- liftEff (E.getDOMNode wrp >>= getElementId)
    assert "" $ _id == (un CProps cProps).id

  test "instance_" do
    log "instance_: TODO"

  test "update" do
    wrp <- liftEff do
      wrp' <- mount $ createElement cls cProps []
      E.update wrp'
    assert "did not received a ReactWrapper" $ isReactWrapper wrp

  test "unmount & mount" do
    let _id = (un CProps cProps).id

    body <- liftEff $ do
      doc <- htmlDocumentToDocument <$> (window >>= document)
      mbd <- querySelector (QuerySelector "body") (documentToParentNode doc)
      let bd = unsafePartial (fromJust mbd)
      pure bd

    node <- liftEff $ do
      doc <- htmlDocumentToDocument <$> (window >>= document)
      el <- DOM.createElement "div" doc
      let nd = elementToNode el
      _ <- appendChild nd (elementToNode body)
      pure nd

    wrp <- liftEff $ do
      wrp <- mountWithOptions (createElement cls cProps []) { attachTo: Just node }
      mount $ createElement cls cProps []

    mel <- liftEff $ findElementById (ElementId "counter")
    assert "is not mounted" $ isJust mel

    wrp' <- liftEff $ E.unmount wrp
    throws <- liftEff $ isThrowing (E.getDOMNode wrp)
    assert "did not throw" throws
    assert "did not received a ReactWrapper" $ isReactWrapper wrp'

    -- cleanup the DOM tree
    void $ liftEff $ removeChild node (elementToNode body)

    -- | TODO this fails
    {--
      - wrp'' <- liftEff $ E.mount wrp'
      - throws' <- liftEff $ isThrowing (E.getDOMNode wrp)
      - assert "did throw" (not throws')
      - assert "did not received a ReactWrapper" $ isReactWrapper wrp''
      --}

  test "setProps & props" do
    fprops <- liftEff do
      wrp <- mount $ createElement cls cProps []
      wrp' <- E.setProps (CProps { id: "ok" }) wrp
      E.props wrp'

    case runExcept (readCProps fprops) of
      Left _ -> failure "did not read props from foreign value"
      Right (CProps { id: id_ }) -> assert "did not set props" $ id_ == "ok"

  test "setState & state" do
    fc <- liftEff do
      wrp <- mount (createElement cls cProps []) >>= E.setState (CState { c: 1 })
      E.state "c" wrp

    case runExcept (readInt fc) of
      Left _ -> failure "did not read counter from foreign value"
      Right c -> assert "did not set state" $ c == 1
  
  test "setContext & context" do
    fctx <- liftEff do
      wrp <- mountWithOptions (createElement cls cProps []) { context: toForeign { ctx: 0 }}
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
      mount (createElement cls cProps []) >>= E.children
    assert "did not received $a ReactWrapper" $ isReactWrapper children

    ElementId id_ <- liftEff $ (E.at 0 children >>= E.getDOMNode >>= getElementId)
    assert ("wrong id: got " <> id_) $ id_ == "counter"

  test "childrenBySelector" do
    children <- liftEff do
      mount (createElement cls cProps []) >>= E.childrenBySelector "#counter"
    assert "did not received $a ReactWrapper" $ isReactWrapper children

    ElementId id_ <- liftEff $ (E.getDOMNode children >>= getElementId)
    assert ("wrong id: got " <> id_) $ id_ == "counter"

  test "parents" do
    let oid = (un CProps cProps).id
    ElementId id_ <- liftEff do
      wrp <- mount $ createElement cls cProps []
      E.childAt 0 wrp >>= E.parents >>= E.at 0 >>= E.getDOMNode >>= getElementId

    assert ("wrong id: got " <> id_) $ id_ == oid

  test "parentsBySelector" do
    let oid = (un CProps cProps).id
    ElementId id_ <- liftEff do
      wrp <- mount $ createElement cls cProps []
      chl <- E.childAt 0 wrp
      E.parentsBySelector "TestClass" chl >>= E.getDOMNode >>= getElementId

    assert ("wrong id: got " <> id_) $ id_ == oid

  test "parent" do
    let oid = (un CProps cProps).id
    ElementId id_ <- liftEff do
      wrp <- mount $ createElement cls cProps []
      chl <- E.childAt 0 wrp
      E.parent chl >>= E.getDOMNode >>= getElementId

    assert ("wrong id: got " <> id_) $ id_ == oid

  test "closest" do
    let oid = (un CProps cProps).id
    ElementId id_ <- liftEff do
      wrp <- mount $ createElement cls cProps []
      E.closest "TestClass" wrp >>= E.getDOMNode >>= getElementId

    assert ("wrong id: got " <> id_) $ id_ == oid

  test "key" do
    key <- liftEff do
      wrp <- mount $ createElement cls cProps []
      E.childAt 0 wrp >>= E.key

    assert ("" <> key) $ key == "key-counter"

  suite "type_" do
    test "DOM node" do
      type_ <- liftEff do
        mount (createElement cls cProps []) >>= E.childAt 0 >>= E.type_

      case type_ of
        Left s -> assert "" $ s == "div"
        Right _ -> failure "should get a string"

    test "ReactClass" do
      type_ <- liftEff do
        mount (createElement cls cProps []) >>= E.type_

      case type_ of
        Right _ -> success
        Left _ -> failure "should get a constructor"

  test "name" do
    name <- liftEff do
      mount (createElement cls cProps []) >>= E.name

    assert ("got " <> name <> "expected TestClass")  $ name == "TestClass"

  suite "hasClass" do
    test "positive" do
      hasClass <- liftEff do
        mount (createElement cls cProps []) >>= E.childAt 0 >>= E.hasClass "counter"

      assert "expected to have class 'counter'" hasClass

    test "negative" do
      hasClass <- liftEff do
        mount (createElement cls cProps []) >>= E.childAt 0 >>= E.hasClass "x"

      assert "expected not to have class 'x'" (not hasClass)

  test "map" do
    as <- liftEff do
      mount (createElement cls cProps []) >>= E.children >>= E.map id

    assert "should get array of length 2" (length as == 2)

  test "reduce" do
    c <- liftEff do
      mount (createElement cls cProps []) >>= E.children >>= E.reduce (\x _ _ -> x + 1) 0

    assert "should get 2" $ c == 2

  test "reduceRight" do
    c <- liftEff do
      mount (createElement cls cProps []) >>= E.children >>= E.reduceRight (\x _ _ -> x + 1) 0

    assert "should get 2" $ c == 2

  test "slice" do
    s <- liftEff do
      mount (createElement cls cProps []) >>= E.children >>= E.slice 0 1 >>= E.getNodes

    assert "should get array of length 1" (length s == 1)

  suite "some" do
    test "positive" do
      match <- liftEff do
        mount (createElement cls cProps []) >>= E.children >>= E.some "div"

      assert "should get true" match

    test "negative" do
      match <- liftEff do
        mount (createElement cls cProps []) >>= E.children >>= E.some "#abc"

      assert "should get false" (not match)

    test "should throw" do
      throws <- liftEff $ do
        wrp <- mount (createElement cls cProps [])
        isThrowing (E.some "x" wrp)

      assert "should throw on the root" throws

  test "get" do
    re <- liftEff do
      mount (createElement cls cProps []) >>= E.get 0

    assert "" (isValidElement $ unsafeGetReactElement re)

  test "first" do
    ElementId id_ <- liftEff do
      first <- mount (createElement cls cProps []) >>= E.children >>= E.first
      E.getDOMNode first >>= getElementId

    assert ("" <> id_) $ id_ == "counter"

  test "last" do
    ElementId id_ <- liftEff do
      first <- mount (createElement cls cProps []) >>= E.children >>= E.last
      E.getDOMNode first >>= getElementId

    assert ("" <> id_) $ id_ == "container"

  test "isEmpty" do
    empty <- liftEff do
      mount (createElement cls cProps []) >>= E.children >>= E.isEmpty

    assert "" (not empty)

  test "exists" do
    exists <- liftEff do
      mount (createElement cls cProps []) >>= E.children >>= E.exists

    assert "" exists

  suite "detach" do
    test "throws" do
      throws <- liftEff do
        wrp <- mount (createElement cls cProps [])
        isThrowing (E.detach wrp)

      assert "" throws

    test "runs" do
      _ <- liftEff do
        el <- window >>= document >>= (DOM.createElement "div" <<< htmlDocumentToDocument)
        wrp <- mountWithOptions (createElement cls cProps []) { attachTo: Just (elementToNode el) }
        E.detach wrp

      success
