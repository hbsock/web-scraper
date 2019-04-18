module Main where


import Parser (parseBoxNovelHTML)
import System.IO
import qualified Data.Text.Lazy.IO as L


main :: IO ()
main = do
    file <- L.readFile "thing.html"
    let chapter_contents = parseBoxNovelHTML file

    L.writeFile "out.txt" $ chapter_contents
    print chapter_contents
