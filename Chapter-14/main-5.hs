import Control.Monad.State

type Stack = [Int]

{- 14.3.3 Stateモナド -}
-- 定義はこんな感じ
-- newtype State s a = State {runState :: s -> (a, s)}

-- モナドインスタンスはこんな感じ
-- instance Monad (State s) where
--   return x = State $ \s -> (x, s)
--   (State h) >>= f = State $ \s ->
--     let (a, newState) = h s
--         (State g) = f a
--      in g newState

-- 1. returnは、値を取るが、状態には手をつけず、値と状態をタプルにして返す
-- 2. バインドでは、とりあえず1つ目の状態付き計算から結果の値を取り出さなければいけない。状態付き計算の文脈を壊さないように、現在の状態sを状態付き計算hに渡して、計算結果と新しい状態のペア (a, newState)を得る。最後に、f aで新しい状態付き計算gを取り出し、gとnewStateをタプルにして返す。

-- pop とpushを、Stateモナドで書き換えてみる

popM :: State Stack Int
popM = state $ \(x : xs) -> (x, xs)

pushM :: Int -> State Stack ()
pushM a = state $ \xs -> ((), a : xs)

-- stackManipもモナドで置き換えてみる
stackManipM :: State Stack Int
stackManipM = do
  pushM 3
  popM
  popM

stackStuffM :: State Stack ()
stackStuffM = do
  a <- popM
  if a == 5
    then pushM 5
    else do
      pushM 3
      pushM 8
