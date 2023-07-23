{- 13章 モナドがいっぱい -}

{- 13.1 アプリカティブファンクターを強化する -}
-- モナドは、アプリカティブファンクターの拡張。
-- 「普通の値aを取って文脈付きの値を返す関数」に文脈付きの値m aを渡すために導入する。

-- 言い換えると、 a-> m b 型の関数を m a型の値に適用したいということ。
-- つまりこの関数が欲しいということ
-- (>>=) :: (Monad m) => m a -> (a -> m b) -> m b
-- モナドはこの>>=関数(バインド関数)が追加されたアプリカティブファンクターにすぎない。

{- 13.2 Maybeから始めるモナド -}
-- Maybe a型の値は、失敗する可能性があるという文脈を表している

-- Functorでは、、、
-- fmap (++ "!") (Just "wisdom") ->  Just "wisdom!"

-- Applicative Functorでは、、
-- Just (+3) <*> Just 3 -> Just 6
-- Nothing <*> Just "hello" <*> Just "world" <*> Just "!" -> Nothing (失敗の伝播)
-- max <$> Just 3 <*> Just 6 -> Just 6 (アプリカティブスタイル)

-- Monadではどうなる？ とりあえず、Maybeに特化したバインド関数 applyMaybe を考えてみる

applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
applyMaybe Nothing f = Nothing
applyMaybe (Just x) f = f x

-- Just 3 `applyMaybe` \x -> Just (x+1)   -> Just 4
-- Nothing `applyMaybe` \x -> Just (x+1)  -> Nothing
-- Just 3 `applyMaybe` \x -> if x > 2 then Just x else Nothing  -> Nothing

-- この例では、Just値と関数を引数にapplyMaybeを呼び出した時は、たんにJustの中の値に関数が適用されている。
-- また、Nothing値を引数に呼びだすと、全体の結果がNothingになっている。
-- 関数の方がNothingを返す場合も、やはり結果がNothingになっている。

-- これで、「文脈付きの変な値」に「普通の値を取って変な値を返す関数」を適用する方法がわかってきた。
