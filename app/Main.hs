module Main where


import WebScraper (scrapeMain)



main :: IO ()
main = do
    scrapeMain  [31..40] 
                "output/chaotic-sword-god/" 
                "https://boxnovel.com/novel/chaotic-sword-god/"
