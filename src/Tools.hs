{-# LANGUAGE OverloadedStrings #-}

module Tools
    ( 
        getWebsite,
        getWebsiteWithDelay
    ) where


import qualified Data.Text as T
import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple
import System.Random (getStdRandom, randomR)
import Control.Concurrent (threadDelay)


getRandomNumInRange :: Int -> Int -> IO Int
getRandomNumInRange lo hi = getStdRandom (randomR (lo, hi))


getWebsite :: String -> IO L8.ByteString
getWebsite url = do
    response <- httpLBS =<< parseRequest url
    return $ getResponseBody response
    

getWebsiteWithDelay :: String -> IO L8.ByteString
getWebsiteWithDelay url = do
    rand_delay_in_microsec <- getRandomNumInRange 1000 100000
    threadDelay rand_delay_in_microsec
    putStrLn $ "Delayed for " ++ show (rand_delay_in_microsec `div` 1000) ++ " miliseconds."

    getWebsite url
