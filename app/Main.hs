module Main where

-- import Lib
import Parser (parseBoxNovelHTML)
import System.IO

main :: IO ()
main = do
    file <- readFile "thing.html"
    let chapter_contents = parseBoxNovelHTML file

    writeFile "out.txt" $ unlines chapter_contents
    print chapter_contents
