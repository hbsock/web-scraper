module Main where


import WebScraper (scrapeChaoticSwordGodNovel)
import System.Directory (createDirectoryIfMissing)

scrapeMain :: [Int] -> FilePath -> IO ()
scrapeMain chap_nums output_dir = do

    let chap_strs = map (\n -> "chapter-" ++ (show n)) chap_nums
    let output_file_names = map (\t -> output_dir ++ t ++ ".txt") chap_strs
    let urls = map (\t -> "https://boxnovel.com/novel/chaotic-sword-god/" ++ t) chap_strs

    createDirectoryIfMissing True output_dir
    let output_name_and_urls = zip urls output_file_names 
    
    mapM_ (\(url, out) -> scrapeChaoticSwordGodNovel url out) output_name_and_urls


main :: IO ()
main = do
    scrapeMain [1..10] "output/chaotic-sword-god/"

{--
    mapM_ 
        (\(url, output_file) -> createDirectoryIfMissing url output_file) 
        output_name_and_urls 
        --}
    -- print output_name_and_urls
    -- print output_file_names
    -- print urls
    -- scrapeChaoticSwordGodNovel "https://boxnovel.com/novel/chaotic-sword-god/chapter-1/" "chapter-1.txt"

