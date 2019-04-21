module Parser 
    ( parseChaoticSwordGodHTML
    ) where


import Text.HTML.TagSoup
import Data.Maybe (catMaybes)
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as I

parseForChapterContents :: [Tag T.Text] -> [Tag T.Text]
parseForChapterContents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">")

parseChaoticSwordGodHTML :: T.Text -> T.Text
parseChaoticSwordGodHTML = T.strip . T.unlines . catMaybes . map maybeTagText . parseForChapterContents . parseTags
