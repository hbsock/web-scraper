module Main where



import Control.Exception
import Data.Typeable (Typeable)
import qualified Data.Text.Lazy.IO as I
import qualified Data.Text as T

import WebScraper (scrapeMain)
import Parser

data WebScraperException = 
    InvalidNumberRange !T.Text
    deriving (Show, Typeable)


instance Exception WebScraperException


testExceptions :: Integer -> Integer -> IO ()
testExceptions low high = do
    case compare low high of
        LT -> putStrLn "Low is less than high, that is okay."
        EQ -> putStrLn "Low is equal to high, that is okay."
        GT -> throw ( InvalidNumberRange (T.pack "The lower number is higher than the high number."))
        


testParsing :: IO ()
testParsing = do
    content <- I.readFile "the-kings-avatar-example.html"
    I.writeFile "tmp.txt" $ parseBoxnovel content

    

main :: IO ()
main = do
    testExceptions 5 10
    testExceptions 1 1
    testExceptions 10 5
{--
    scrapeMain  [1..1500] 
                "output/the-kings-avatar/" 
                "https://boxnovel.com/novel/the-kings-avatar/"
                parseBoxnovel
--}
