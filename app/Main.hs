module Main where


import WebScraper (scrapeMain)
import Parser

import qualified Data.Text.Lazy.IO as I

testParsing :: IO ()
testParsing = do
    content <- I.readFile "the-kings-avatar-example.html"
    I.writeFile "tmp.txt" $ parseBoxnovel content


main :: IO ()
main = do
    testParsing
{--
    scrapeMain  [41..50] 
                "output/chaotic-sword-god/" 
                "https://boxnovel.com/novel/chaotic-sword-god/"
                parseChaoticSwordGodHTML
--}
