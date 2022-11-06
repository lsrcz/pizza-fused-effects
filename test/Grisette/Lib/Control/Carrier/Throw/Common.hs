{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module Grisette.Lib.Control.Carrier.Throw.Common where

import Control.Effect.Throw
import Grisette.Core

e :: (Has (Throw a) sig m, GUnionLike bool m, SymBoolOp bool) => Either a b -> m b
e = liftEither

em ::
  forall sig m bool a b.
  (Has (Throw a) sig m, GUnionLike bool m, SymBoolOp bool, GMergeable bool (m b)) =>
  bool ->
  Either a b ->
  Either a b ->
  m b
em cond e1 e2 = ms cond (e e1) (e e2)
  where
    SimpleStrategy ms = gmergingStrategy :: GMergingStrategy bool (m b)

em1 ::
  forall sig m bool a b.
  (Has (Throw a) sig m, GUnionLike bool m, SymBoolOp bool, GMergeable bool b) =>
  bool ->
  Either a b ->
  Either a b ->
  m b
em1 cond e1 e2 = ms cond (e e1) (e e2)
  where
    SimpleStrategy ms = gmergingStrategy1 :: GMergingStrategy bool (m b)

es ::
  forall sig m bool a b.
  (Has (Throw a) sig m, GUnionLike bool m, SymBoolOp bool, GSimpleMergeable bool (m b)) =>
  bool ->
  Either a b ->
  Either a b ->
  m b
es cond e1 e2 = gmrgIte cond (e e1) (e e2)

es1 ::
  forall sig m bool a b.
  (Has (Throw a) sig m, GUnionLike bool m, SymBoolOp bool, GSimpleMergeable bool b) =>
  bool ->
  Either a b ->
  Either a b ->
  m b
es1 cond e1 e2 = gmrgIte1 cond (e e1) (e e2)

eu ::
  forall sig m bool a b.
  (Has (Throw a) sig m, GUnionLike bool m, SymBoolOp bool, GMergeable bool b) =>
  bool ->
  Either a b ->
  Either a b ->
  m b
eu cond e1 e2 = mrgIf cond (e e1) (e e2)

eu' ::
  forall sig m bool a b.
  (Has (Throw a) sig m, GUnionLike bool m, SymBoolOp bool) =>
  bool ->
  Either a b ->
  Either a b ->
  m b
eu' cond e1 e2 = unionIf cond (e e1) (e e2)
