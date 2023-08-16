import Data.List (break)

(-:) :: t1 -> (t1 -> t2) -> t2
x -: f = f x

{- 15.3 超シンプルなファイルシステム -}

type Name = String

type Data = String

data FSItem = File Name Data | Folder Name [FSItem] deriving (Show)

myDisk :: FSItem
myDisk =
  Folder
    "root"
    [ File "goat_yelling_like_man.wmv" "baaaaaa",
      File "pope_time.avi" "god bless",
      Folder
        "pics"
        [ File "ape_throwing_up.jpg" "bleargh",
          File "watermelon_smash.gif" "smash!!",
          File "skull_man(scary).bmp" "Yikes!"
        ],
      File "dijon_poupon.doc" "best mustard",
      Folder
        "programs"
        [ File "fartwizard.exe" "10gotofart",
          File "owl_bandit.dmg" "mov eax, h00t",
          File "not_a_virus.exe" "really not a virus",
          Folder
            "source code"
            [ File "best_hs_prog.hs" "main = print (fix error)",
              File "random.hs" "main = print 4"
            ]
        ]
    ]

-- これでファイルシステムができたので、あとはジッパーさえあれば、ファイルの追加・編集・消去が自在にできる

-- ぱんくずリストは、「ここに行く！」と決めたもの以外の全ての情報を含む必要がある。今回の場合、パンク図はフォルダにそっくりなデータ構造になるはず。

-- あれ、ファイルは？ ひとたびファイルに注目したら、ファイルシステムをそれ以上深く掘ることはできないので、フォルダだけでいい。ファイルは、あたかも空の木のような役割。

-- これがファイルシステムのぱんくずの型

data FSCrumb = FSCrumb Name [FSItem] [FSItem] deriving (Show)

-- これがジッパー

type FSZipper = (FSItem, [FSCrumb])

-- ぱんくずには、フォルダの名前・フォルダの中で注目点より前にあったアイテムのリストls・注目点より後ろにあったアイテムのリストrsが全部入っているから、上に戻るのは簡単

fsUp :: FSZipper -> Maybe FSZipper
-- ぱんくずリストが空なら、上に戻る場所はない
fsUp (_, []) = Nothing
fsUp (item, FSCrumb name ls rs : bs) = Just (Folder name (ls ++ [item] ++ rs), bs)

-- ファイルシステムを下に降りる
-- まずbreakを使って、今探しているアイテムよりも前にあるものと後ろにあるものにリストを分ける。 nameIs関数が述語として働き、リストをls,item,rsに分ける。そのあと、それらをぱんくずに詰める

fsTo :: Name -> FSZipper -> Maybe FSZipper
-- いま注目しているのがファイルなら、降りられる場所はない
fsTo _ (File _ _, _) = Nothing
fsTo name (Folder folderName items, bs) =
  let (ls, rest) = break (nameIs name) items
   in case rest of
        [] -> Nothing -- itemが見つからなかった
        (item : rs) -> Just (item, FSCrumb folderName ls rs : bs)

nameIs :: Name -> FSItem -> Bool
nameIs name (Folder folderName _) = name == folderName
nameIs name (File fileName _) = name == fileName

-- 注目しているファイルの名前を変更する

fsRename :: Name -> FSZipper -> FSZipper
fsRename newName (Folder name items, bs) = (Folder newName items, bs)
fsRename newName (File name dat, bs) = (File newName dat, bs)

-- 現在のフォルダにアイテムを新規作成する

fsNewFile :: FSItem -> FSZipper -> Maybe FSZipper
-- 今注目しているのがファイルなら、新規作成できない
fsNewFile _ (File _ _, _) = Nothing
fsNewFile item (Folder folderName items, bs) = Just (Folder folderName (item : items), bs)
