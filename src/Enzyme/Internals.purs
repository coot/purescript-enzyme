module Enzyme.Internals where

import Prelude (($))
import Data.StrMap as S
import Unsafe.Coerce (unsafeCoerce)

foreign import data Undefined :: Type

foreign import undefined :: Undefined

-- left baiased unsafe merge
unsafeMerge :: forall r s t. Union r s t => Record r -> Record s -> Record t
unsafeMerge r s = unsafeCoerce $ S.union (unsafeCoerce r) (unsafeCoerce s)
