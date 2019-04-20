{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where


import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple
import System.Random (getStdRandom, randomR)
import Control.Concurrent (threadDelay)


getRandomNumInRange :: Int -> Int -> IO Int
getRandomNumInRange lo hi = getStdRandom (randomR (lo, hi))


someFunc :: IO ()
someFunc = do

    rand_delay_in_microsec <- getRandomNumInRange 1 3000000
    threadDelay rand_delay_in_microsec
    putStrLn $ "Delayed for " ++ show (rand_delay_in_microsec `div` 1000) ++ " miliseconds."
    
    {--
    response <- httpLBS =<< parseRequest ("https://en.wikipedia.org/wiki/" ++ "Anime")
    putStrLn $ "Status code was: " ++ show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    --L8.writeFile "wiki.html" $ getResponseBody response
    --}

    
