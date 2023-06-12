import Control.Exception (handle)
import GHC.Data.ShortText (ShortText (contents))
import System.IO

main = do
  -- ファイル操作
  -- data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode
  handle <- openFile "baabaa.txt" ReadMode
  contents <- hGetContents handle
  putStr contents
  hClose handle

  -- withFileを使ったバージョン
  withFile "baabaa.txt" ReadMode $ \handle -> do
    contents <- hGetContents handle
    putStr contents

  -- readFileを使ったバージョン
  contents <- readFile "baabaa.txt"
  putStr contents
