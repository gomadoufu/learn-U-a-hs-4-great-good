{- 14章 もうちょっとだけモナド -}

{- 14.1 Writer? 中の人なんていません! -}
-- Writerモナドは、自身以外にもう1つの値がくっついた値を表し、付加された値はログのように振る舞う。
-- Writerモナドを使えば、一覧の計算を行っている間、すべてのログが単一のログ値にまとめて記録されることを保証できる。
-- たとえばデバッグ目的とかで

isBigGang :: Int -> Bool
isBigGang x = x > 9

-- 例えば、isBigGang関数に、自分がどんな働きをしたかを示す文字列も一緒に返してほしいとする。

isBigGangWriter :: Int -> (Bool, String)
isBigGangWriter x = (x > 9, "Compared gang size to 9.")

-- 別にこれでもいいけど、すでに文字列がついている値、たとえば (3, "Smallish gang.")をisBigGangWriterに食わせるにはどうする？
-- モナドを使う。
-- でもこれ、別に文字列じゃなくてもいい。任意のリストでいいし、もっと抽象化すると、Monoidならなんでもよい。

{- 14.1.2 Writer型 -}
-- 「モノイドのおまけのついた値」がモナド値のように振る舞うことがわかった。
-- Control.Monad.Writerモジュールには、Writer w a型とそのMonadインスタンス、そしてWriter型を扱うための関数が定義されている。
-- 値にモノイドのおまけをつけるには、タプルに入れるだけ！ Wtiterの定義はシンプルで、タプルのnewtypeに過ぎない
newtype Writer w a = Writer {runWriter :: (a, w)}

-- 型引数aが主となる値の型を表し、型引数wが付加されるモノイド値の型を表す。
-- WriterのMonadインスタンスは、こんな感じ

-- instance (Monoid w) => Monad (Writer w) where
--   return x = Writer (x, mempty)
--   (Writer (x, v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')

-- 始めに、>>= の実装について。ここで、fは x -> (y, v) である関数で、vはWriterモナド値の付加された値の部分。
-- まず、Writer w a 型の値を Writer (x, v) でパターンマッチして、wをx、aをvとして取り出す。
-- 次に f をxに適用して、その結果を再び Writer (y, v')でパターンマッチする。
-- 最後に値を返す。主となる値の方は、変換したかっただけなので、yでよい。おまけの値の方は、どんどん付加されて行ってほしいので、残しておいたvと、新しく作られたv'をmappendで結合する。値コンストラクタWriterと(, )でもって、値を作って返しておわり。

-- returnは、値を最小の文脈に入れるのだった。最小のMonoidはmemptyなので、returnの実装は以上のようになる。
-- ちなみに、Writerインスタンスにはfailの実装がないので、do記法の中でパターンマッチに失敗するとerrorになる。
