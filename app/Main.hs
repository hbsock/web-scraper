module Main where


import WebScraper (scrapeMain)



main :: IO ()
main = do
    scrapeMain [31..40] "output/chaotic-sword-god/"
