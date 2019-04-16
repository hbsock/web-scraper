module Main where

-- import Lib
-- import Parser
import System.IO
import Text.HTML.TagSoup
import Data.Maybe (catMaybes)

parseForChapterContents :: [Tag String] -> [Tag String]
parseForChapterContents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">")

main :: IO ()
main = do
    file <- readFile "thing.html"
    let chapter_contents = catMaybes . map maybeTagText . parseForChapterContents . parseTags $ file

    writeFile "out.txt" $ unlines chapter_contents
    
    print chapter_contents
