{- 13.6 リストモナド -}

-- instance Monad [] where
--   return x = [x]
--   xs >>= f = concat (map f xs)
--   fail _ = []

-- リストのモナドは非決定性計算を表すらしい。
-- 「リストモナドとは、非決定的な値 (xs :: [a]) と 非決定性計算 (f :: a -> [b]) を引数にとり、さらにより沢山の候補値を含んだ非決定的な値を返す関数 (非決定性計算) である」

-- リスト内包表記は、リストモナドの構文糖衣。

{- 13.6.2 MonadPlus とguard関数 -}
-- さて、ここで以下のようなリスト内包表記がある
-- [ x | x <- [1..50], '7' `elem` show x]
-- 数xをshowで文字に変えて、それから文字7が含まれているか調べている
-- これはどんなリストもなどに翻訳されるだろうか？

-- これには、guard関数とMonadPlus型クラスを学ぶ必要がある。

class Monad m => MonadPlus m where
  mzero :: m a
  mplus :: m a -> m a -> m a

-- MonadPlusは、モナドのうち、モノイドの性質を持つものに付けられる型クラスである。
-- mzeroは、Monoidでいうところのmemptyに相当する。
-- mplusは、Monoidでいうところのmappendに相当する。

instance MonadPlus [] where
  mzero = []
  mplus = (++)

-- リストに関するmzeroは、候補が1つもない、失敗した非決定製計算を表している。
-- mplusは2つの非決定性計算を1つの値にくっつける。

-- さて、guard関数は、MonadPlus型クラスのインスタンスであるモナドに対して定義されている。

guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()
guard False = mzero

-- ガードは、モナドの計算の中で、条件に応じて、計算を続けて良いかの判断をしてくれる。
