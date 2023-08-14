{- 14.5.3 filterM -}

-- filterの型はこうだったね
-- filter :: (a -> Bool) -> [a] -> [a]

-- では、a -> Bool の BoolがBoolがモナド値だったらどうしよう。
-- Boolに文脈がついているのなら、filterの結果のリストにもそれが残っているべきよね

-- そこで、Control.MonadにfilterMがある

-- filterM :: (Monad m) => (a -> m Bool) -> [a] -> m [a]

{- 14.5.4 foldM -}
-- foldlのモナド版がfoldM。foldlと同じことをするけれど、モナドを返す関数を使う

-- foldl :: (a -> b -> a) -> a -> [b] -> a

-- foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a
