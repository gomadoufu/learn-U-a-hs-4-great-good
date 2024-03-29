-- ここからは、節ごとに休憩する
{- 13.7 モナド則 -}

{- 13.7.1 左恒等性 -}
-- return x >>= f と f x は同じになりなさいt、という規則
-- returnは値をその値が再現できるような最小限の文脈に入れるもの。余計なことをしてはいけない。

{- 13.7.2 右恒等性 -}
-- m >>= return と m は同じになりなさい、という規則
-- 言い換えると、returnに冪等性を持たせなさい、ということかも
-- やはりここでも、returnは余計なことをするなと言っている
-- returnはモナドシステムの中で、特に重要なことがわかる

{- 13.7.3 結合法則 -}
-- (m >>= f) >>= g と m >>= (\x -> f x >>= g) は同じになりなさい、という規則
-- バインドを使ったモナド関数適用の連鎖がある時、どの順序で評価しても結果は同じであるべき、ということ
