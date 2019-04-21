module WebScraper 
    (
        scrapeMain
    ) where


import Parser (parseChaoticSwordGodHTML)
import Tools (getWebsiteWithDelay)
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as I
import Data.Text.Lazy.Encoding (decodeUtf8)
import System.Directory (createDirectoryIfMissing)


scrapeNovel :: String -> String -> (T.Text -> T.Text) -> IO ()
scrapeNovel url output_file parse_func = do
    contents <- getWebsiteWithDelay url
    let parsed_contents = parse_func $ decodeUtf8 contents
    
    putStrLn $ "Writing file: " ++ output_file
    I.writeFile output_file $ parsed_contents


scrapeMain :: [Int] -> FilePath -> FilePath -> (T.Text -> T.Text) -> IO ()
scrapeMain chap_nums output_dir base_url parse_func = do

    let chap_strs = map (\n -> "chapter-" ++ (show n)) chap_nums
    let output_file_names = map (\t -> output_dir ++ t ++ ".txt") chap_strs
    let urls = map (\t -> base_url ++ t) chap_strs

    createDirectoryIfMissing True output_dir
    let output_name_and_urls = zip urls output_file_names 
    
    mapM_ (\(url, out) -> scrapeNovel url out parse_func) output_name_and_urls
