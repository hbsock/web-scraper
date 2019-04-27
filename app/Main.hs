module Main where


import qualified Data.Text.Lazy.IO as I
import WebScraper (scrapeMain)
import Parser
import CmdParser


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
            print inputs
{--
            scrapeMain 
                (is_complete inputs)
                (low inputs)
                (high inputs)
                (output_dir inputs) 
                (base_url inputs)
                parseBoxnovel
--}
