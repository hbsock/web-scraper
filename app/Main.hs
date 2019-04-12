module Main where

-- import Lib
-- import Parser
import System.IO
import qualified Data.ByteString.Lazy.Char8 as B


main :: IO ()
main = do
    file <- B.readFile "thing.html"
    print file
-- main = someFunc
