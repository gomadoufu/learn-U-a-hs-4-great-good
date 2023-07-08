{- 12章 モノイド-}
-- Monoidは、値を二項演算しで結合できるような型を表す。

{- 12.1 既存の方を新しい型にくるむ-}
-- nwetypeキーワードで、既存の型をラップして、別の方を作ることができる。
newtype ZipList a = ZipList {getZipList :: [a]}

-- dataキーワードでも型を作れるが、newtypeの方が高速。
-- 一方、newtypeキーワードは値コンストラクタを一つしか作れず、また値コンストラクタが持てるフィールドも一つだけという制限がある
-- newtypeでも、derivingが使える

{- 12.1.3 type vs. newtype vs. data-}
-- typeキーワードは型シノニムを作るためのもの。エイリアスを作るだけ
-- newtypeキーワードは、既存の型から新しい型を作るもの。
-- data キーワードは、自作の新しいデータ型を作るためのもの。

{- 12.2 Monoid大集合-}
-- モノイドは、結合的な二項演算子と、その演算に関する単位元からなる構造。
-- 結合的とは、計算の順序を変えても結果は変わらないという性質。掛け算とか。

-- Monoidの定義
-- class Monoid m where
--    mempty :: m
--    mappend :: m -> m -> m
--    mconcat :: [m] -> m
--    mconcat = foldr mappend mempty

-- 1. Monoidのインスタンスになれるのは具体型だけ
-- 2. memptyは多相定数。単位元を表す
-- 3. mappendは、モノイド固有の2項演算。
-- 4. mconcatは、モノイドのリストを取ってmappendを間に挟んだ式を作り、単一の値にしてくれるもの。デフォルト実装がついており、大抵これで十分らしい。

{- 12.2.2 モノイド則 -}

-- 1. mempty `mappend` x = x
-- 2. x `mappend` mempty = x
-- 3. (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)

-- memptyがmappendに対して単位元として振る舞うこと(1, 2)と、mappendを評価する順序は順序は関知しない事(3)を示している。
-- モノイド則は対称律まで要求していないことに注意。a `mappend` b と b `mappend` aは別に同じじゃなくていい。memptyに関してだけ。

{-12.3.1 リストはモノイド -}
-- 関数++と空リスト[]でモノイドを構成している。

-- instance Monoid [a] where
--    mempty = []
--    mappend = (++)

{- 12.3.2 ProductとSum -}
-- ある型が、型クラスのインスタンスとして2通りの表し方がある時、newtypeパターンを使うといい。
-- この場合、Num型はモノイドとしてProductとSumの2通り考えられる

-- newtype Product a = Product {getProduct :: a}
--    deriving (Eq, Ord, Read, Show, Bounded)

-- instance Num a => Monoid (Product a) where
--    mempty = Product 1
--    Product x `mappend` Product y = Product (x * y)

-- newtype Sum a = Sum {getSum :: a}
--    deriving (Eq, Ord, Read, Show, Bounded)

-- instance Num a => Monoid (Sum a) where
--    mempty = Sum 0
--    Sum x `mappend` Sum y = Sum (x + y)

{- 12.3.3 AnyとAll -}
-- Num a以外にも、モノイドにする方法が2通りある型として、Bool型がある。AnyとAllの2通りがある

-- newtype Any = Any { getAny :: Bool }
--      deriving (Eq, Ord, Read, Show, Bounded)

-- instance Monoid Any where
--    mempty = Any False
--    Any x `mappend` Any y = Any (x || y)

-- x `mappend` y は xかyのいずれかがTrueの時、全体がTrueになる

-- newtype All = All { getAll :: Bool }
--      deriving (Eq, Ord, Read, Show, Bounded)

-- instance Monoid All where
--    mempty = All True
--    All x `mappend` All y = All (x && y)

-- x `mappend` y は xとyが共にTrueの時のみ、全体がTrueになる
