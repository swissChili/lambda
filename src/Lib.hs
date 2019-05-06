{--# LANGUAGE #--}

module Lib where

import Types
import Data.Map (fromList, Map, (!), insert)

addNative m = insert "to_up" (NativeFn upcase) m
  where upcase _ (Str a) = Str $ "Upcase" ++ a
        upcase _ a = a

assignmentsToMap = addNative . fromList . map toPair
  where toPair (Assignment a b) = (a, b)

interpret :: Map String Term -> Term -> Term
interpret _ (Number a) = Number a
interpret c (Str s) = Str s
interpret c (Var a) = c ! a
interpret c (Invocation f a) = callLambda c a f
interpret _ _ = Number 0

callLambda :: Map String Term -> Term -> Term -> Term
callLambda f arg (Lambda a t) = interpret (insert a arg f) t
callLambda f arg (NativeFn h) = h f arg
callLambda f arg (Var v) = call f v arg
callLambda _ _ _ = Number $ -1

call :: Map String Term -> String -> Term -> Term
call m a t = callLambda m t $ m ! a
