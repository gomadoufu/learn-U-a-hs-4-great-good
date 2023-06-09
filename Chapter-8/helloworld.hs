{- 8.2 Hello, World! -}

main :: IO ()
main = putStrLn "hello, world"

-- putStrLnはIOアクションを返す。IOアクションは、それにmainという名前をつけて実行すると、結果が生成される(画面に表示される)
