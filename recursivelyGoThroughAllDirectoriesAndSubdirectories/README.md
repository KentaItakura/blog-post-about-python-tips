# サブフォルダも含めてファイル一覧を取得する

# 1. はじめに

この記事では、特定のフォルダの中に存在するファイルを、サブフォルダも含めて取得する方法についてメモを残します。

# 2. コードについて

## 2.1. MATLAB

dir関数を用いる際に、`\**\`と指定すればよい。

```matlab
% サブフォルダも含め、txtデータを集める
txtList = dir(fullfile(pwd, 'folder1\**\*.txt'));  %get list of files and folders in any subfolder
% 拡張子を含めず、あらゆるファイルを取得する
filelist = dir(fullfile(pwd, 'folder1\**\*'));  
filelist = filelist(~[filelist.isdir]);  % フォルダの情報を削除する
```

## 2.2. Python

globモジュールを用いる場合を考える。MATLABの場合と同様に、Pythonの場合は `/*/`をつけるとよい。

```python
import os
from glob import glob
txtFiles = glob(os.getcwd() + "/folder1/*/*.txt", recursive = True)
print('==== file list ====')
print(txtFiles)

for i in txtFiles:
    print('==== file name ====')
    print(i)
    # 任意の処理を行う
```

# 参考ページ

[MATLAB公式ドキュメント：dir](https://jp.mathworks.com/help/matlab/ref/dir.html)

[How to recursively go through all directories and sub directories and process files?](https://jp.mathworks.com/matlabcentral/answers/429891-how-to-recursively-go-through-all-directories-and-sub-directories-and-process-files)

[MATLABで、あるフォルダ以下のサブフォルダのリストを作る => 任意の拡張子のファイルパスを取得 (ここでは*.jpg)](https://gist.github.com/rysk-t/27fe40ed4d878802fde3)

[Python でサブディレクトリを一覧表示する](https://www.delftstack.com/ja/howto/python/python-list-subdirectories/)