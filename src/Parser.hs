module Parser 
    ( parseBoxNovelHTML
    ) where


import Text.HTML.TagSoup
import Data.Maybe (catMaybes)

parseForChapterContents :: [Tag String] -> [Tag String]
parseForChapterContents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">")

parseBoxNovelHTML :: String -> [String]
parseBoxNovelHTML = catMaybes . map maybeTagText . parseForChapterContents . parseTags
