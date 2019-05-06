module Parser where

import Text.ParserCombinators.Parsec
import Text.Parsec.Char

import Types

ident = many1 $ letter <|> oneOf "_$"
num = many1 digit >>= return . Number . read
strSingle = between (char '\'') (char '\'') (many $ noneOf "'") >>= return . Str
strDouble = between (char '"') (char '"') (many $ noneOf "\"") >>= return . Str
strCurved = between (char '“') (char '”') (many $ noneOf "”") >>= return . Str
str = try strSingle <|> try strDouble

assignment = do
  string "let"
  spaces
  name <- ident
  spaces
  char '='
  spaces
  val <- term
  return $ Assignment name val

variable = ident >>= return . Var
invoc = do
  char '('
  a <- term
  spaces
  b <- term
  char ')'
  spaces
  return $ Invocation a b

-- λ arg . body
-- \ can be used instead of λ, but λ is cool and unicode should
-- be used more in languages so that's the recommended syntax
lambda = do
  oneOf "λ\\"
  spaces
  var <- ident
  spaces
  char '.'
  spaces
  body <- term
  spaces
  return $ Lambda var body

doAll = between (char '{' <* spaces) (spaces *> char '}')
                (many1 $ term <* spaces) >>= return . DoAll

term = try doAll
    <|>try invoc
    <|>try lambda
    <|>try variable
    <|>try num
    <|>try str

top = many1 assignment

parseLambda = parse top "(unknown)"
