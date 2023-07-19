{- 13.4.1 ひたすらコーディング -}
{- 13.4.2 うゎぁあああああ落ちるぅぅうううああああ -}

-- バランス棒を持って、ピエールが歩いているよ！
-- バランス棒の左右の端に飛んできたり飛び去ったりする鳥をシュミレートしたい

type Birds = Int

type Pole = (Birds, Birds)

-- 鳥をとまらせる関数
landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
  | abs ((left + n) - right) < 4 = Just (left + n, right)
  | otherwise = Nothing

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
  | abs (left - (right + n)) < 4 = Just (left, right + n)
  | otherwise = Nothing

-- 関数を適用するのに、まず引数、次に関数をかけるようにする関数
x -: f = f x

-- -:によって、鳥をとまらせる関数をわかりやすく合成することができた。
-- (0, 0) -: landLeft 1 -: landRight 1 -: landLeft 2 -> (3, 1)

-- しかし、失敗を表すためにMaybeを導入したことで、その能力を失ってしまった。なぜなら、これら2つの関数はMaybeを引数に取らないから。

-- そこで、バインド>>=を使う。こうすれば、Poleを取ってMaybe Poleを返す関数にMaybe Poleを渡すことができる。Maybeの文脈を保ったまま、操作を合成できる。
-- return (0, 0) >>= landRight 2 >>= landLeft 2 >>= landRight 2 -> Just (2, 4)

{- 13.4.3 ロープの上のバナナ -}
-- 今度はバランス棒に留まっている鳥の数によらず、いきなりピエールを滑らせて落っことす関数を作ってみる
banana :: Pole -> Maybe Pole
banana _ = Nothing

-- この関数は、鳥をとまらせる関数と混ぜて使える。
-- return (0, 0) >>= landLeft 1 >>= banana >>= landRight 1 -> Nothing

-- 実は、bananaのように入力に関係なく規程のモナド値を返す関数だったら、自作せずとも>>関数を使うことができる。
-- return (0, 0) >>= landLeft 1 >> Nothing >>= landRight 1
