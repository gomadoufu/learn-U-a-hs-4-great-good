{- 12.3.4 Orderingモノイド -}
-- Ordering型って何だっけ
-- -> LT, EQ, GTという3つの値のいずれかを取るやつだった

-- 1 `compare` 2 -> LT
-- 2 `compare` 2 -> EQ
-- 3 `compare` 2 -> GT

-- モノイドのインスタンス実装は？
-- instance Monoid Ordering where
--    mempty = EQ
--    LT `mappend` _ = LT
--    EQ `mappend` y = y
--    GT `mappend` _ = GT

-- ORderingモノイドは、さまざまな条件でものの大小を比較し、条件そのものに「最も重視すべき条件」から「どうでもいい条件」まで優先順位をつけて最終判定を出すのに使える、便利なもの、らしい。

{- 12.3.5 Maybeモノイド-}
-- Maybeをモノイドにする方法も複数ある。
-- 一番素直な方法は、Maybe aの aがモノイドである限りMaybeもモノイドであるとし、Maybe aのmappendを、Justの中身のmappendを使って定義すること。

-- instance Monoid a => Monoid (Maybe a) where
--      mempty = Nothing
--      Nothing `mappend` m = m
--      m `mappend` Nothing = m
--      Just m1 `mappend` Just m2 = Just (m1 `mappend` m2)

{- 12.4 モノイドで畳み込む -}
-- 畳み込みをする時にもモノイドは活躍する。

-- 畳み込みできる構造を表す Foldable型クラスがある。
-- Foldable型クラスは、Preludeと名前がぶつかるので、修飾付きインポートすると良い
-- import qualified Data.Foldable as F

-- Data.Foldableの関数は、Foldable型クラスのインスタンスならなんでも畳み込む。たとえばData.Foldable.foldr
-- F.foldr :: (F.Foldable t) => (a -> b -> b) -> b -> t a -> b

-- ある型コンストラクタをFoldableのインスタンスにするには、foldrを実装するか、またはfoldMapを実装する必要がある。
-- foldMap :: (Monoid m,  foldable t) => (a -> m) -> t a -> m
-- 第一引数 a -> m は 「Foldableにしたいコンテナの中身a型 の値を取って、モノイドを返す」関数。
-- 第二引数 t a は、a型の値を含む Foldable構造自身
