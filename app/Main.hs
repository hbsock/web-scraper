module Main where

-- import Lib
-- import Parser
import System.IO
import Text.HTML.TagSoup

parseForChapterContents :: [Tag String] -> [Tag String]
parseForChapterContents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">")

main :: IO ()
main = do
    file <- readFile "thing.html"
    let chapter_contents = parseForChapterContents . parseTags $ file

    print chapter_contents
