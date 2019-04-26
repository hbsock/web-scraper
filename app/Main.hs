{-# LANGUAGE OverloadedStrings #-}

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


data Inputs = Inputs {
    low :: Integer,
    high :: Integer
} deriving (Eq, Ord, Show)


validateInputs :: Inputs -> Maybe WebScraperException
validateInputs inputs = testLowAndHigh (low inputs) (high inputs)

testLowAndHigh :: Integer -> Integer -> Maybe WebScraperException
testLowAndHigh low high = do
    case compare low high of
        LT -> Nothing
        EQ -> Nothing
        GT -> Just $ InvalidNumberRange "The lower number is higher than the high number."
        


testParsing :: IO ()
testParsing = do
    content <- I.readFile "the-kings-avatar-example.html"
    I.writeFile "tmp.txt" $ parseBoxnovel content

    


main :: IO ()
main = do
    let inputs = Inputs {
        low = 11,
        high = 10
    }

    case validateInputs inputs of
        Just err -> putStrLn ("Invalid input!\n\n\t" <> show err)
        Nothing -> putStrLn "No input errors"
{--
            scrapeMain  [1..1] 
                "output/the-kings-avatar/" 
                "https://boxnovel.com/novel/the-kings-avatar/"
                parseBoxnovel
--}
