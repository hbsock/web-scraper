{-# LANGUAGE DeriveDataTypeable #-}

module CmdParser
    (
        Inputs (..),
        InputError,
        isInputInvalid,
        defaultInputs,
        getInputsFromCmdLine
    ) where


import Control.Applicative
import Data.Typeable (Typeable)
import qualified Data.Text as T
import System.FilePath (isValid)
import Network.URI (isURI)
import System.Console.CmdArgs


data InputError = 
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

} deriving (Eq, Ord, Show, Data, Typeable)


isInputInvalid :: Inputs -> Maybe InputError
isInputInvalid inputs = 
        isNumberRangeInvalid (low inputs) (high inputs) 
    <|> isOutputDirPathInvalid (output_dir inputs)
    <|> isBaseURLinvalid (base_url inputs)


isNumberRangeInvalid :: Int -> Int -> Maybe InputError
isNumberRangeInvalid low high =
    case compare low high of
        LT -> Nothing
        EQ -> Nothing
        GT -> Just $ InvalidNumberRange $ T.pack $ 
            "The lower number" <> (show low) <> 
            "is higher than the high number" <> (show high)
        

isOutputDirPathInvalid :: FilePath -> Maybe InputError
isOutputDirPathInvalid path = 
    case isValid path of
        True -> Nothing
        False -> Just $ 
            InvalidOutputDirPath $ 
                T.pack ("The output directory " <> show path <> "is invalid")


isBaseURLinvalid :: String -> Maybe InputError
isBaseURLinvalid url = 
    case isURI url of
        True -> Nothing
        False -> Just $ InvalidBaseURL $ T.pack url


defaultInputs :: Inputs
defaultInputs = Inputs {
        is_complete = False,
        low = 1,
        high = 0,
        output_dir = "",
        base_url = ""
    }
    &= summary "This is the list of options for this web scraper."


getInputsFromCmdLine :: IO Inputs
getInputsFromCmdLine = cmdArgs defaultInputs
