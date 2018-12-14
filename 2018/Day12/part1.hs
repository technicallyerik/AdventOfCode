-- TODO: I have a lot to read up on Haskell first

module Main where

import System.IO

initialInput = "##.####..####...#.####..##.#..##..#####.##.#..#...#.###.###....####.###...##..#...##.#.#...##.##.."

generationRules = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let myLines = lines contents
    return myLines

main = do
    bla <- generationRules
    print bla

