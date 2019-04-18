module Parser 
    ( parseBoxNovelHTML
    ) where


import Text.HTML.TagSoup
import Data.Maybe (catMaybes)
import qualified Data.Text.Lazy as T

parseForChapterContents :: [Tag T.Text] -> [Tag T.Text]
parseForChapterContents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">")

parseBoxNovelHTML :: T.Text -> T.Text
parseBoxNovelHTML = T.unlines . catMaybes . map maybeTagText . parseForChapterContents . parseTags
