module Main where

import Parser
import Types
import Lib

main :: IO ()
main = case parseLambda "let main = λ argv . (to_up argv)" of
  Right a -> print $ call (assignmentsToMap a) "main" (Str "Hello, World!")
  Left b -> print b
