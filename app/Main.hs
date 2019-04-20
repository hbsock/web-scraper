module Main where


import Parser (parseMain)
import Lib (getWebsiteWithDelay)
import System.IO
import qualified Data.Text.Lazy.IO as I
import Data.Text.Lazy.Encoding (decodeUtf8)


main :: IO ()
main = do
    contents <- getWebsiteWithDelay "Anime"
    I.writeFile "wiki.html" (decodeUtf8 contents)
