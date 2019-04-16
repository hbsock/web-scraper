module Main where

-- import Lib
-- import Parser
import System.IO
import Text.HTML.TagSoup

main :: IO ()
main = do
    file <- readFile "thing.html"
    let chapter_contents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">") . parseTags $ file

    print chapter_contents
