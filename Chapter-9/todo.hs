import Control.Exception
import Data.List
import GHC.Data.ShortText (ShortText (contents))
import System.Directory
import System.Environment
import System.IO

main = do
  (command : argList) <- getArgs
  dispatch command argList

dispatch :: String -> [String] -> IO ()
dispatch "add" = add
dispatch "view" = view
dispatch "remove" = remove
dispatch "bump" = bump
dispatch command = doesntExist command

doesntExist :: String -> [String] -> IO ()
doesntExist command _ =
  putStrLn $ "The " ++ command ++ " command doesn't exist"

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")
add _ = putStrLn "The add command takes exactly two arguments"

view :: [String] -> IO ()
view [fileName] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0 ..] todoTasks
  putStr $ unlines numberedTasks
view _ = putStrLn "The view command takes exactly one argument"

remove :: [String] -> IO ()
remove [fileName, numberString] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      number = read numberString
      newTodoItems = unlines $ delete (todoTasks !! number) todoTasks
  writeTodo newTodoItems fileName
remove _ = putStrLn "The remove command takes exactly two arguments"

bump :: [String] -> IO ()
bump [fileName, numberString] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      number = read numberString
      headItem = todoTasks !! number
      otherItems = delete headItem todoTasks
      newTodoItems = unlines $ headItem : otherItems
  writeTodo newTodoItems fileName
bump _ = putStrLn "The bump command takes exactly two arguments"

writeTodo :: String -> String -> IO ()
writeTodo newTodoItems fileName = do
  -- 以上終了しても、一時ファイルをちゃんと削除する bracketOnError
  bracketOnError
    (openTempFile "." "temp")
    ( \(tempName, tempHandle) -> do
        hClose tempHandle
        removeFile tempName
    )
    ( \(tempName, tempHandle) -> do
        hPutStr tempHandle newTodoItems
        hClose tempHandle
        removeFile fileName
        renameFile tempName fileName
    )
