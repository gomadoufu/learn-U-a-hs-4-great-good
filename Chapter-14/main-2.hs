import Control.Monad.Writer

{- 14.1.3 Writerをdo記法で使う -}
logNumber :: Int -> Writer [String] Int
logNumber x = writer (x, ["Got number: " ++ show x])

multWithLog :: Writer [String] Int
multWithLog = do
  a <- logNumber 3
  b <- logNumber 5
  tell ["Gonna multiply these two"]
  return (a * b)

-- モノイド値として文字列のリストを使い、入ってきた数に対して「その数が通ったよ」という記録を単一要素リストとして残す

-- 時には、メインの値ではなくモノイド値を追記したい時もある。
-- その時には、tell関数を用いる

{- 14.1.4 プログラムにログを追加しよう！ -}
-- 普通のgcd関数
-- gcd' :: Int -> Int -> Int
-- gcd' a b
--   | b == 0 = a
--   | otherwise = gcd' b (a `mod` b)

gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
  | b == 0 = do
    tell ["Finished with " ++ show a]
    return a
  | otherwise = do
    tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
    gcd' b (a `mod` b)
