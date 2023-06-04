{- 7.6 型シノニム -}

-- 型エイリアスだね
-- type String = [Char]
-- 型シノニムでも型引数が使える
-- type AssocList k v = [(k, v)]

{- 7.7 再帰的なデータ構造 -}

-- リスト

-- Consを中置関数にしている。中置関数にするには、値コンストラクタをコロンで囲む必要がある。
-- 関数を演算子として定義するにあたり、その結合性(fixity)を宣言することができる。
-- infixrはそのための構文で、レベル5で右結合することを示す。
infixr 5 :-:

data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)

-- 二部探索木
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a = Node a (treeInsert x left) right
  | x > a = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
  | x == a = True
  | x < a = treeElem x left
  | x > a = treeElem x right
