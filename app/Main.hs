{-# LANGUAGE OverloadedStrings #-}

module Main where


import Control.Applicative
import Data.Typeable (Typeable)
import qualified Data.Text.Lazy.IO as I
import qualified Data.Text as T
import System.FilePath (isValid)

import WebScraper (scrapeMain)
import Parser

data WebScraperException = 
    InvalidNumberRange !T.Text |
    InvalidOutputDirPath !T.Text
    deriving (Show, Typeable)


data Inputs = Inputs {
    low :: Integer,
    high :: Integer,
    output_dir :: FilePath

} deriving (Eq, Ord, Show)


isInputInvalid :: Inputs -> Maybe WebScraperException
isInputInvalid inputs = 
        isNumberRangeInvalid (low inputs) (high inputs) 
    <|> isOutputDirPathInvalid (output_dir inputs)


isNumberRangeInvalid :: Integer -> Integer -> Maybe WebScraperException
isNumberRangeInvalid low high =
    case compare low high of
        LT -> Nothing
        EQ -> Nothing
        GT -> Just $ InvalidNumberRange "The lower number is higher than the high number."
        

isOutputDirPathInvalid :: FilePath -> Maybe WebScraperException
isOutputDirPathInvalid path = 
    case isValid path of
        True -> Nothing
        False -> Just $ 
            InvalidOutputDirPath $ 
                T.pack ("The output directory " <> show path <> "is invalid")


testParsing :: IO ()
testParsing = do
    content <- I.readFile "the-kings-avatar-example.html"
    I.writeFile "tmp.txt" $ parseBoxnovel content
    


main :: IO ()
main = do
    let inputs = Inputs {
        low = 1,
        high = 10,
        output_dir = "outputs/the-first-hunter/"
    }

    case isInputInvalid inputs of
        Just err -> putStrLn ("Invalid input!\n\n\t" <> show err)
        Nothing -> putStrLn "No input errors"
{--
            scrapeMain  [1..1] 
                "output/the-kings-avatar/" 
                "https://boxnovel.com/novel/the-kings-avatar/"
                parseBoxnovel
--}
