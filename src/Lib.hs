{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc,
      getWebsiteWithDelay
    ) where


import qualified Data.Text as T
import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple
import Data.Text.Encoding (decodeUtf8)
import System.Random (getStdRandom, randomR)
import Control.Concurrent (threadDelay)


getRandomNumInRange :: Int -> Int -> IO Int
getRandomNumInRange lo hi = getStdRandom (randomR (lo, hi))


getWebsiteWithDelay :: String -> IO L8.ByteString
getWebsiteWithDelay path = do
    rand_delay_in_microsec <- getRandomNumInRange 1 100000
    threadDelay rand_delay_in_microsec
    putStrLn $ "Delayed for " ++ show (rand_delay_in_microsec `div` 1000) ++ " miliseconds."
    
    response <- httpLBS =<< parseRequest ("https://en.wikipedia.org/wiki/" ++ path)

    return $ getResponseBody response

    
    

someFunc :: IO ()
someFunc = do

    rand_delay_in_microsec <- getRandomNumInRange 1 100000
    threadDelay rand_delay_in_microsec
    putStrLn $ "Delayed for " ++ show (rand_delay_in_microsec `div` 1000) ++ " miliseconds."
    
    {--
     -
    response <- httpLBS =<< parseRequest ("https://en.wikipedia.org/wiki/" ++ "Anime")
    putStrLn $ "Status code was: " ++ show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    --L8.writeFile "wiki.html" $ getResponseBody response
    --}

    
