module Main where


import WebScraper (scrapeChaoticSwordGodNovel)


main :: IO ()
main = do
    let chap_nums = [1..10]
    let chap_strs = map (\n -> "chapter-" ++ (show n)) chap_nums

    let output_dir = "output/"
    let output_file_names = map (\t -> output_dir ++ t ++ ".txt") chap_strs

    print output_file_names
    -- scrapeChaoticSwordGodNovel "https://boxnovel.com/novel/chaotic-sword-god/chapter-1/" "chapter-1.txt"

