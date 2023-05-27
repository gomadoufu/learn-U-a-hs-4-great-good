{- 2.4 型クラス-}
-- Eq 型クラス

-- Ord 型クラス
LT = "aoba" `compare` "goma"

GT = 5 `compare` 3

-- Show 型クラス 文字列表現を返せるもの(stringifyできるもの)
three = show 3

-- Read 型クラス 文字列からパースできるもの
true = read "True" || False

five = read "5" :: Int

-- Enum 型クラス 要素の値を列挙できるもの。rangeが使える
abcde = ['a' .. 'e']

c = succ 'B'

-- Bounded 型クラス 有界であるもの
minInt = minBound :: Int
