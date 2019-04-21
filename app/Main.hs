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
    scrapeMain  [1..1500] 
                "output/the-kings-avatar/" 
                "https://boxnovel.com/novel/the-kings-avatar/"
                parseBoxnovel
