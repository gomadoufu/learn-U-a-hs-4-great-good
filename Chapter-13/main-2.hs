{- 13.3 Monad 型クラス-}
-- class Monad m where
--    return :: a -> m a
--
--    (>>=) :: m a -> (a -> m b) -> mb
--
--    (>>) :: m a -> m b -> m b
--       x >> y = x >>= _ -> y
--
--    fail :: String -> m a
--       fail msg = error msg

-- 全てのMonadはアプリカティブファンクターなんだけど、歴史的な経緯でMonadの型クラス宣言にはApplicativeの型クラス制約が書かれていない
-- 書かれていなくても、実際はそう

-- 1. returnは、Applicativeのpureと同じもの。普通の値を文脈に入れて返す。
-- 2. >>=はバインドという。関数適用に似ているが、普通の値をとって通常の関数を適用するのではなく、モナド値をとって、それに「通常の値を取るがモナド値を返す関数」を適用する。
-- 3. >>にはデフォルト実装がついている。大抵このデフォルト実装で大丈夫らしい
-- 4. failはユーザが呼び出すことは全くなくて、もっぱらHaskellシステムが呼び出す。failはモナド用の特別な構文において、パターンマッチに失敗してもプログラムを以上終了させず、失敗をモナドの文脈の中で扱えるようにするためのもの。あまり気にしなくてよい

-- さて、MaybeのMonadインスタンスの実装を見てみる。

-- instance Monad Maybe where
--     return x = Just x
--     Nothing >>= f = Nothing
--     Just x >>= f = f x
--     fail _ = Nothing
