{- 13.5 do記法 -}
-- do記法は、入出力の構文ではなく、モナド専用構文だった！

-- 例えば、次のようなコードがある
-- Just 3 >>= (\x -> Just (show x ++ "!")) -- Just "3!"

-- ここまでなら大したことないが、ラムダ式のなかにさらにバインドがあったら、ネストが深くなって読みにくくなる。
-- Just 3 >>= (\x -> Just "!" >>= (\y -> Just (show x ++ y))) -- Just "3!"

-- もっと見やすくしたい
-- スクリプトふうに書き直してみる
-- foo :: Maybe String
-- foo = Just 3 >>= (\x ->
--       Just "!" >>= (\y ->
--       Just (show x ++ y)))

-- これを簡潔に描けるように、do記法がある

foo :: Maybe String
foo = do
  x <- Just 3
  y <- Just "!"
  Just (show x ++ y)

-- 見やす〜〜〜〜〜い！！！

-- do式では、このようにMaybeから値をそのまま取り出せる「風」に書ける
-- バインドの連鎖と等価なので、どこかがNothingならdo式全体もNothingになる
