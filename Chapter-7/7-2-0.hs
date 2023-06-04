{- 7.1 新しいデータ型を定義する -}
-- 新しいデータ型を定義するには、dataキーワードを使う
-- Bool型はこのように定義されているとみなせる
-- data Bool = False | True

{- 7.2 形づくる -}
-- 構造体ぽいもの。いや列挙型か
data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

-- どういう意味？こう考えるとよい、まずShapeはCircleとRectangleの直和型
-- data Shape = Circle | Rectangle
-- ただ、それぞれの値コンストラクタが値を生成するには、まだ情報が足りないので、Floatフィールドを付け加えた。
-- 実際、値コンストラクタはただの関数

-- メソッド的なものを作ってみる
area :: Shape -> Float
area (Circle _ _ r) = pi * r ^ 2
area (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- インスタンス化してみる
rect = Rectangle 0 0 100 10

thousand = area rect
