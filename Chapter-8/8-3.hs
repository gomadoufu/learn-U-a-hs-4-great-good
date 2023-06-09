--プログラムは常にmainと名付けられた単一のIOアクションである

-- 複数のIOアクションを単一のIOアクションにまとめるために、do構文が使える
-- doと書いてから、あたかも命令型言語のように、実行ステップを書き並べる
-- 実行ステップのそれぞれがIOアクションである

main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  putStrLn ("Hey " ++ name ++ ", you rock!")
