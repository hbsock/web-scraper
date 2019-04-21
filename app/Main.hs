module Main where


import WebScraper (scrapeMain)
import Parser (parseChaoticSwordGodHTML)


main :: IO ()
main = do
    scrapeMain  [41..50] 
                "output/chaotic-sword-god/" 
                "https://boxnovel.com/novel/chaotic-sword-god/"
                parseChaoticSwordGodHTML
