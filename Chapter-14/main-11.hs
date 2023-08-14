{- 14.8 モナドを作る -}

-- 型が生まれてモナドであると確認され、適切なMonadインスタンスが与えられるまでの過程を、例題を通して学ぶ

-- リストは非決定性計算だった。例えば [3,5,9]を整数3,5,9が同時に存在している状態だと思って見ることができるが、ところでこれには存在確率の情報がない。
-- 存在確率の情報付きの値を作ってみよう！！

-- 簡単に、存在確率をそれぞれの値がタプルで持つことにしてみる
-- [(3,0.5), (5,0.25), (9,0.25)]
-- 浮動小数だと、精度が心配だな、、

-- HaskellにはRational型があり、数を分数で表せる
-- 1 % 2 とか 19 % 12 と書くと、Rationalインスタンスの分数になる

-- [(3, 1%2), (5, 1%4), (9, 1%4)]
-- これで、3が出る確率は1/2で、5と9はそれぞれ1/4であることを綺麗に表現できた。

-- newtypeにしておく
import Data.Ratio

newtype Prob a = Prob {getProb :: [(a, Rational)]} deriving (Show)

-- このProbってファンクターかな？ リストがファンクターだし、Probもファンクターかも。もし関数でProbを写したら、値だけ変わって、確率はそのまま残されるのが自然な気がするね。

instance Functor Prob where
  fmap f (Prob xs) = Prob $ map (\(x, p) -> (f x, p)) xs

-- では、これはモナドだろうか？ まずreturnについて考えてみる。
-- returnは単一要素のリストで、確率は1が良さそう
-- バインドの方は？ むずかしい。そこでjoin (fmap f m)を示す方針でいってみる。
-- joinという名前はもう使われているので、flattenという名前で関数を考える

flatten :: Prob (Prob a) -> Prob a
flatten (Prob xs) = Prob $ concat $ map multAll xs
  where
    multAll (Prob innerxs, p) = map (\(x, r) -> (x, p * r)) innerxs

-- 以上より、モナドインスタンスは以下

-- instance Monad Prob where
--   return x = Prob [(x, 1 % 1)]
--   m >>= f = flatten (fmap f m)
--   fail _ = Prob []

-- できたばかりのモナドが、きちんとモナド則を満たしているかどうか試すことも重要
