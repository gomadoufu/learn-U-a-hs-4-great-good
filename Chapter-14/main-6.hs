import Control.Monad.State

{- 14.3.4 状態の取得と設定 -}

-- Control.Monad.Stateモジュールは、MonadStateという型クラスを提供している
-- MonadStateは、2つの便利な関数 get と put を備えている

-- Stateモナドに対するgetの実装は以下
-- get = state $ \s -> (s, s)
-- 現在の状態をとってきて、それを結果として提示している

-- put関数は、状態型の引数を取り、「その状態を、現在の状態に上書きする状態付き関数」を返す
-- put newState = state $ \s -> ((), newState)

-- というわけで、このputとgetがあれば、Stateの文脈の中で、簡単に現在のスタックを取得したり変更したりできる

type Stack = [Int]

stackyStack :: State Stack ()
stackyStack = do
  stackNow <- get
  if stackNow == [1, 2, 3]
    then put [8, 3, 1]
    else put [9, 2, 1]
