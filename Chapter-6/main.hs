{- 6.4 モジュールをエクスポートする -}
module Main (numUniques, oneTwoThree) where

{- 6.1 モジュールをインポートする -}

import Data.Char
import Data.List
-- Data.Mapは、PreludeやData.Listと関数名が被っているので、qualifiedキーワードとasで修飾付きインポートする。これで "Map.function" みたいな形で使える
import qualified Data.Map as Map

numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub

wordNums :: String -> [(String, Int)]
wordNums = map (\ws -> (head ws, length ws)) . group . sort . words

digitSum :: Int -> Int
digitSum = sum . map digitToInt . show

firstTo40 :: Maybe Int
firstTo40 = find (\x -> digitSum x == 40) [1 ..]

-- Map型 Map.Map
oneTwoThree :: Map.Map Integer String
oneTwoThree = Map.fromList [(1, "one"), (2, "two"), (3, "three")]

-- 探す Map.lookup

-- 挿入 Map.insert

-- 長さ Map.size
