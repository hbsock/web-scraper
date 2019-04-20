{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where


import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple
import System.Random (getStdRandom, randomR)


getRandomNumInRange :: Int -> Int -> IO Int
getRandomNumInRange lo hi = getStdRandom (randomR (lo, hi))


someFunc :: IO ()
someFunc = do

    rand <- getRandomNumInRange 1 6
    print rand
    
    {--
    response <- httpLBS =<< parseRequest ("https://en.wikipedia.org/wiki/" ++ "Anime")
    putStrLn $ "Status code was: " ++ show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    --L8.writeFile "wiki.html" $ getResponseBody response
    --}

    
