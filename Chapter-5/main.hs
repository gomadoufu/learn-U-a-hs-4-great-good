{- 5.2 -}

zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x : xs) (y : ys) = f x y : zipWith' f xs ys

flip' f = g where g x y = f y x

map' _ [] = []
map' f (x : xs) = f x : map f xs

filter' _ [] = []
filter' p (x : xs)
  | p x = x : filter' p xs
  | otherwise = filter' p xs

{- 5.5 畳み込み -}

sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0

maximum' :: (Ord a) => [a] -> a
maximum' = foldl1 max
