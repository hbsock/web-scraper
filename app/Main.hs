module Main where

-- import Lib
-- import Parser
import System.IO
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Char (toUpper)


main :: IO ()
main = do
    file <- B.readFile "thing.html"
    let lines = B.lines file
    let string_lines = map B.unpack lines
    let uppLines = map toUpper $ unlines string_lines

    print uppLines 
