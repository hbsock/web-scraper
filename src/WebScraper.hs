module WebScraper 
    (
        scrapeChaoticSwordGodNovel
    ) where


import Parser (parseChaoticSwordGodHTML)
import Tools (getWebsiteWithDelay)
import qualified Data.Text.Lazy.IO as I
import Data.Text.Lazy.Encoding (decodeUtf8)


scrapeChaoticSwordGodNovel :: String -> String -> IO ()
scrapeChaoticSwordGodNovel url output_file = do
    contents <- getWebsiteWithDelay url
    let parsed_contents = parseChaoticSwordGodHTML $ decodeUtf8 contents
    
    putStrLn $ "Writing file: " ++ output_file
    I.writeFile output_file $ parsed_contents
