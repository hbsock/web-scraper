module Parser 
    ( 
        parseBoxnovel
    ) where


import Text.HTML.TagSoup
import Data.Maybe (catMaybes)
import Data.List (intersperse)
import qualified Data.Text.Lazy as T


parseBoxnovel :: T.Text -> T.Text
parseBoxnovel = 
    T.unlines .
    intersperse (T.pack "\n") .
    takeWhile (/= (T.pack "© 2018 BoxNovel. All rights reserved" )) .
    catMaybes . 
    map maybeTagText .
    concat .
    map (take 2) .
    sections (~== "<p>") .
    dropWhile (~/= "<div class=\"text-left\">") . parseTags
