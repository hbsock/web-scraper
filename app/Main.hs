{-# LANGUAGE OverloadedStrings #-}

module Main where


import Control.Applicative
import Data.Typeable (Typeable)
import qualified Data.Text.Lazy.IO as I
import qualified Data.Text as T
import System.FilePath (isValid)
import Network.URI (isURI)

import WebScraper (scrapeMain)
import Parser

data WebScraperException = 
    InvalidNumberRange !T.Text 
    | InvalidOutputDirPath !T.Text 
    | InvalidBaseURL !T.Text
    deriving (Show, Typeable)


data Inputs = Inputs {
    is_complete :: Bool,
    low :: Int,
    high :: Int,
    output_dir :: FilePath,
    base_url :: String

} deriving (Eq, Ord, Show)


isInputInvalid :: Inputs -> Maybe WebScraperException
isInputInvalid inputs = 
        isNumberRangeInvalid (low inputs) (high inputs) 
    <|> isOutputDirPathInvalid (output_dir inputs)
    <|> isBaseURLinvalid (base_url inputs)


isNumberRangeInvalid :: Int -> Int -> Maybe WebScraperException
isNumberRangeInvalid low high =
    case compare low high of
        LT -> Nothing
        EQ -> Nothing
        GT -> Just $ InvalidNumberRange $ T.pack $ 
            "The lower number" <> (show low) <> 
            "is higher than the high number" <> (show high)
        

isOutputDirPathInvalid :: FilePath -> Maybe WebScraperException
isOutputDirPathInvalid path = 
    case isValid path of
        True -> Nothing
        False -> Just $ 
            InvalidOutputDirPath $ 
                T.pack ("The output directory " <> show path <> "is invalid")


isBaseURLinvalid :: String -> Maybe WebScraperException
isBaseURLinvalid url = 
    case isURI url of
        True -> Nothing
        False -> Just $ InvalidBaseURL $ T.pack url



testParsing :: FilePath -> FilePath -> IO ()
testParsing inputFile outputFile = do
    content <- I.readFile inputFile
    I.writeFile outputFile $ parseBoxnovel content
    


main :: IO ()
main = do
    let inputs = Inputs {
        is_complete = True,
        low = 1,
        high = 1315,
        output_dir = "output/a-will-eternal/",
        base_url = "https://boxnovel.com/novel/a-will-eternal/"
    }

    case isInputInvalid inputs of
        Just err -> putStrLn ("Invalid input!\n\n\t" <> show err)
        Nothing -> 
            scrapeMain 
                (is_complete inputs)
                (low inputs)
                (high inputs)
                (output_dir inputs) 
                (base_url inputs)
                parseBoxnovel
{--
            testParsing 
                "/home/hanbinsock/programman/haskell/web-scraper/output/the-first-hunter/index.html"
                "test.txt"

--}
