{- 1.2 関数入門 -}

-- 関数適用
-- succ 8

-- min 9 10

-- max 100 101

-- 関数の中置
-- 92 `div` 10

-- 関数定義
doubleMe x = x + x

-- if式 else節は必須
doubleSmallNumber :: (Ord a, Num a) => a -> a
doubleSmallNumber x = if x > 100 then x else x * 2

-- 定義 小文字で始めること
gomadoufu = "gomadoufu"

{- 1.3 リスト -}

-- リスト
lostNumbers = [4, 8, 15, 16, 23, 42]

-- リストの連結 Concatenate
helloWorld = "hello" ++ "world"

-- リストの頭への要素の追加 Append
aSmallCat = 'A' : " small cat"

-- 要素のアクセス
m = "gomadoufu" !! 3

-- リスト操作
g = head "gomadoufu"

omadoufu = tail "gomadoufu"

u = last "gomadoufu"

gomadouf = init "gomadoufu"

-- リストの長さ
nine = length "gomadoufu"

-- リストが空かどうか調べる
nullFalse = null [1, 2, 3]

nullTrue = null []

-- リストを逆順にする
ufuodamog = reverse "gomadoufu"

-- 先頭から指定された数の要素を取り出したリストを返す
goma = take 4 "gomadoufu"

-- 先頭から指定された数の要素を取り除いたリストを返す
doufu = drop 4 "gomadoufu"

-- Ord型クラスのインスタンスからなるリストを受け取り、最大の要素を返す
five = maximum [1, 2, 3, 4, 5]

-- 数のリストを受け取り、それらの和や積を返す
sum5 = sum [1, 2, 3, 4, 5]

product5 = product [1, 2, 3, 4, 5]

-- リストの要素にあるか調べる Include
-- ` ` で囲むと前置関数を中置できる
elemTrue = 4 `elem` [3, 4, 5, 6]

elemFalse = 10 `elem` [1, 2, 3]

-- rangeと無限リスト
-- [1..10] 1,2,3,4,5,6,7,8,9,10
-- [2, 4..] 偶数の無限リスト

oneTwoThree = take 10 (cycle [1, 2, 3])

tenFives = take 10 (repeat 5)

-- 同じ要素からなるリストを作る
threeTens = replicate 3 10

-- リスト内包表記
even = [x * 2 | x <- [1 .. 10]]

removeNonUppercase st = [c | c <- st, c `elem` ['A' .. 'Z']]

{- 1.6 タプル -}
-- (1, 2)
-- (8, 22, 5)
-- タプルは、要素数も型の一部なので、大きさを後から変更する事はできない

-- タプルの関数
eight = fst (8, 11)

eleven = snd (8, 11)

-- zip関数でペアを作る
-- zip [1, 2, 3, 4, 5] [5, 5, 5, 5, 5]
-- -> [(1, 5), (2, 5), (3, 5), (4, 5), (5, 5)]
