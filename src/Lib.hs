{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where


import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple


someFunc :: IO ()
someFunc = do
    response <- httpLBS =<< parseRequest ("https://en.wikipedia.org/wiki/" ++ "Anime")

    putStrLn $ "Status code was: " ++ show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    --L8.writeFile "wiki.html" $ getResponseBody response
