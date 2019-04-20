module Parser 
    ( parseMain
    ) where


import Text.HTML.TagSoup
import Data.Maybe (catMaybes)
import qualified Data.Text as T
import qualified Data.Text.IO as I

parseForChapterContents :: [Tag T.Text] -> [Tag T.Text]
parseForChapterContents = takeWhile (~/= "</div>") . dropWhile (~/= "<div class=\"text-left\">")

parseBoxNovelHTML :: T.Text -> T.Text
parseBoxNovelHTML = T.strip . T.unlines . catMaybes . map maybeTagText . parseForChapterContents . parseTags

parseMain :: IO ()
parseMain = do
    file <- I.readFile "thing.html"
    let chapter_contents = parseBoxNovelHTML file

    I.writeFile "out.txt" $ chapter_contents
