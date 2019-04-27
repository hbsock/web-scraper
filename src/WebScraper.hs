module WebScraper 
    (
        scrapeMain
    ) where


import Tools (getWebsiteWithDelay)
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as I
import Data.Text.Lazy.Encoding (decodeUtf8)
import System.Directory (createDirectoryIfMissing)


scrapeAndParseURL :: String -> String -> (T.Text -> T.Text) -> IO ()
scrapeAndParseURL url output_file parse_func = do
    contents <- getWebsiteWithDelay url
    let parsed_contents = parse_func $ decodeUtf8 contents
    
    putStrLn $ "Writing file: " ++ output_file
    I.writeFile output_file $ parsed_contents


scrapeMain :: [Int] -> FilePath -> String -> (T.Text -> T.Text) -> IO ()
scrapeMain chap_nums output_dir base_url parse_func = do

    let chap_strs = map (\n -> "/chapter-" ++ (show n)) chap_nums
    let output_file_names = map (\t -> output_dir ++ t ++ ".txt") chap_strs
    let urls = map (\t -> base_url ++ t) chap_strs
    let output_name_and_urls = zip urls output_file_names 

    createDirectoryIfMissing True output_dir
    
    mapM_ (\(url, out) -> scrapeAndParseURL url out parse_func) 
        output_name_and_urls
