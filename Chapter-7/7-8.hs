{- 7.8 型クラス中級-}

data TrafficLight = Red | Yellow | Green

-- 型クラスのインスタンスにする
instance Eq TrafficLight where
  Red == Red = True
  Green == Green = True
  Yellow == Yellow = True
  _ == _ = False

instance Show TrafficLight where
  show Red = "Red light"
  show Yellow = "Yellow light"
  show Green = "Green light"

{- 7.9 YesとNoの型クラス-}
class YesNo a where
  yesno :: a -> Bool

instance YesNo Int where
  yesno 0 = False
  yesno _ = True

instance YesNo ([] a) where
  yesno [] = False
  yesno _ = True

instance YesNo Bool where
  --id関数: 自身を返す
  yesno = id

instance YesNo (Maybe a) where
  yesno (Just _) = True
  yesno Nothing = False

yesnoIf yesnoVal yesResult noResult = if yesno yesnoVal then yesResult else noResult
