import Control.Monad.State

{- 14.3 計算の状態の正体 -}
-- Stateモナドというのがある。これを使えば、状態つきの計算を純粋に扱える

{- 14.3.1 状態付きの計算 -}
-- 状態月の計算を考えるために、まずは型を与えてみる。状態付きの計算とは、ある状態をとって、更新された状態と一緒に計算結果を返す関数として表現できる。型はこんな感じ

-- s -> (a, s)
-- s は状態のかたで、aは状態付き計算の結果

{- 14.3.2 スタックと石 -}
-- スタックをモデル化したいとする。stackとは、いくつかのデータを格納でき、次の2つの操作をサポートするデータ構造のこと
-- push: スタックのてっぺんに要素を積む
-- pop: スタックのてっぺんの要素を取り除く

-- スタックの表現にはリストを使うことにする。

type Stack = [Int]

pop :: Stack -> (Int, Stack)
pop (x : xs) = (x, xs)

push :: Int -> Stack -> ((), Stack)
push a xs = ((), a : xs)

stackManip :: Stack -> (Int, Stack)
stackManip stack =
  let ((), newStack1) = push 3 stack
      (a, newStack2) = pop newStack1
   in pop newStack2
