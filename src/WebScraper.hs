module WebScraper 
    (
        scrapeMain
    ) where


import Parser (parseChaoticSwordGodHTML)
import Tools (getWebsiteWithDelay)
import qualified Data.Text.Lazy.IO as I
import Data.Text.Lazy.Encoding (decodeUtf8)
import System.Directory (createDirectoryIfMissing)


scrapeChaoticSwordGodNovel :: String -> String -> IO ()
scrapeChaoticSwordGodNovel url output_file = do
    contents <- getWebsiteWithDelay url
    let parsed_contents = parseChaoticSwordGodHTML $ decodeUtf8 contents
    
    putStrLn $ "Writing file: " ++ output_file
    I.writeFile output_file $ parsed_contents


scrapeMain :: [Int] -> FilePath -> IO ()
scrapeMain chap_nums output_dir = do

    let chap_strs = map (\n -> "chapter-" ++ (show n)) chap_nums
    let output_file_names = map (\t -> output_dir ++ t ++ ".txt") chap_strs
    let urls = map (\t -> "https://boxnovel.com/novel/chaotic-sword-god/" ++ t) chap_strs

    createDirectoryIfMissing True output_dir
    let output_name_and_urls = zip urls output_file_names 
    
    mapM_ (\(url, out) -> scrapeChaoticSwordGodNovel url out) output_name_and_urls
