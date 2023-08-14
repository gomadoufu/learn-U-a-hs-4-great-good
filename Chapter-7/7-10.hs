{- 7.10 Functor型クラス -}
-- Functorは、「全体を写せる」(map overできる)ものの性質を表す型クラス

-- class Functor f where
--   fmap :: (a -> b) -> f a -> f b

-- fmap関数は、型aから型bへの関数と、型aに適用されたファンクター値をとり、型bに適用されたファンクター値を返す。
-- こう、包みを外して、中身を変換して、また包み直すみたいな？

-- map :: (a -> b) -> [a] -> [b]
-- mapは、リスト限定のfmap関数だ！

-- instance Functor [] where
--   fmap = map

-- MaybeもFunctorだ

-- instance Functor Maybe where
--   fmap f (Just x) = Just (f x)
--   fmap f Nothing = Nothing

-- EitherもFunctor
-- 型コンストラクタも部分適用できる！

-- instance Functor (Either a) where
--   fmap f (Right) x = Right (f x)
--   fmap f (Left x) = Left x
