module Types where

import Data.Map (Map)

data Term = Lambda String Term
          | Str String
          | Number Int
          | Invocation Term Term
          | Var String
          | DoAll [Term]
          | NativeFn (Map String Term -> Term -> Term)

instance Show Term where
  show (Str s) = show s
  show (Number i) = show i
  show (Invocation t s) = "( " ++ show t ++ show s ++ " )"
  show (Var v) = show v
  show (DoAll t) = "{ " ++ show t ++ " }"
  show (NativeFn h) = "<Native Function>"

data Toplevel = Assignment String Term
                deriving (Show)

type Program = [Toplevel]
