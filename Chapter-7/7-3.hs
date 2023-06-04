{- 7.3 レコード構文 -}

data Person = Person
  { firstName :: String,
    lastName :: String,
    age :: Int,
    height :: Float,
    phoneNumber :: String,
    flavor :: String
  }
  deriving (Show)

{- 7.4 型引数 -}
-- 値コンストラクタは、引数を取って新しい値を生み出すのだった。
-- それに対し、型引数をとって新しい型を生み出すものを、型コンストラクタという。

-- data Maybe a = Nothing | Just a

-- 中身の型ごとに別々の方にすることもできなくはないが、、、
-- data IntMaybe = INothing | IJust Int
-- data StringMaybe = SNothing | SJust String
-- data ShapeMaybe = ShNothing | ShJust Shape

-- 誰もそんなことしたくない！ので、型引数が導入される。ま、総称型の実現ですね

{- データ宣言data には、決して型クラス制約をつけないことに注意 -}
