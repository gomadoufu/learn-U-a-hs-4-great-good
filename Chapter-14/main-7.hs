{- 14.4 Errorを壁に -}
-- Maybeモナドは、「失敗するかもしれない計算」という文脈を値に与えるものだった。
-- これは確かに便利なのだが、どんな失敗があったのか知りたい時もあるよね

-- Either e a型は、Maybe型と同じく失敗の文脈を与えるモナドだが、失敗に値を付加できる。
-- これにより、何が失敗したかを説明したり、その他失敗にまつわる有用な情報を提供できる

-- Either e aは、Right値であれば正解や計算の成功を、Left値であれば失敗を表す

-- instance (Error e) => Monad (Either e) where
--   return x = Right x
--   Right x >>= f = f x
--   Left err >>= f = Left err
--   fail msg = Left (strMsg msg)
