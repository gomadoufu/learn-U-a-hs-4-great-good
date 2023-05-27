{- 3.1 パターンマッチ -}
firstLetter :: String -> String
firstLetter "" = "Empty string, whoops!"
firstLetter all@(x : xs) = "The first letter of " ++ all ++ " is " ++ [x]

{- 3.2 ガード -}
max' :: Ord a => a -> a -> a
max' a b
  | a <= b = b
  | otherwise = a

myCompare :: Ord a => a -> a -> Ordering
a `myCompare` b
  | a == b = EQ
  | a <= b = LT
  | otherwise = GT

{- 3.3 where節 -}
initials :: [Char] -> [Char] -> [Char]
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
  where
    (f : _) = firstname
    (l : _) = lastname

{- 3.4 let式 -}
fortyTwo = 4 * (let a = 9 in a + 1) + 2

sixHandred = (let (a, b, c) = (1, 2, 3) in a + b + c) * 100

initialLet :: [Char] -> [Char] -> [Char]
initialLet firstname lastname = let (f : _) = firstname; (l : _) = lastname in [f] ++ ". " ++ [l] ++ "."

{- 3.5 case式 -}
describeListCase ls =
  "The list is "
    ++ case ls of
      [] -> "empty."
      [x] -> "a singleton list."
      xs -> "a longer list."
