module Main where


import Parser (parseChaoticSwordGodHTML)
import Lib (getWebsiteWithDelay)
import System.IO
import qualified Data.Text.Lazy.IO as I
import Data.Text.Lazy.Encoding (decodeUtf8)


main :: IO ()
main = do
    contents <- getWebsiteWithDelay "https://boxnovel.com/novel/chaotic-sword-god/chapter-1/"
    let parsed_contents = parseChaoticSwordGodHTML $ decodeUtf8 contents
    I.writeFile "out.txt" $ parsed_contents
