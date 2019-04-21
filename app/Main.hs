module Main where


import WebScraper (scrapeChaoticSwordGodNovel)

main :: IO ()
main = scrapeChaoticSwordGodNovel 
        "https://boxnovel.com/novel/chaotic-sword-god/chapter-1/" 
        "chapter-1.txt"

