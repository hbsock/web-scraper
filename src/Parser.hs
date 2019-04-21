module Parser 
    ( 
        parseChaoticSwordGodHTML,
        parseTheKingsAvatarHTML,
        parseBoxnovel
    ) where


import Text.HTML.TagSoup
import Data.Maybe (catMaybes)
import Data.List (intercalate)
import qualified Data.Text.Lazy as T


parseBoxnovel :: T.Text -> T.Text
parseBoxnovel = 
    T.unlines .
    takeWhile (/= (T.pack "© 2018 BoxNovel. All rights reserved" )) .
    catMaybes . 
    map maybeTagText .
    concat .
    map (take 2) .
    sections (~== "<p>") .
    dropWhile (~/= "<div class=\"text-left\">") . parseTags


parseForChapterContents :: [Tag T.Text] -> [Tag T.Text]
parseForChapterContents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">")


parseChaoticSwordGodHTML :: T.Text -> T.Text
parseChaoticSwordGodHTML = T.strip . T.unlines . catMaybes . map maybeTagText . parseForChapterContents . parseTags




parseTheKingsAvatarHTML :: T.Text -> [Tag T.Text]
parseTheKingsAvatarHTML = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">") . parseTags

