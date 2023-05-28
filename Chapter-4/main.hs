{- 4.1 再帰 -}

maximum' [] = error "maximum of empty list!"
maximum' [x] = x
maximum' (x : xs) = max x (maximum' xs)

{- 4.2 -}

replicate' n x
  | n <= 0 = []
  | otherwise = x : replicate' (n - 1) x

take' n _
  | n <= 0 = []
take' _ [] = []
take' n (x : xs) = x : take' (n - 1) xs

reverse' [] = []
reverse' (x : xs) = reverse' xs ++ [x]

repeat' x = x : repeat' x

zip' _ [] = []
zip' [] _ = []
zip' (x : xs) (y : ys) = (x, y) : zip' xs ys

elem' a [] = False
elem' a (x : xs)
  | a == x = True
  | otherwise = elem' a xs
