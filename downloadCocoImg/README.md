# 1. はじめに  

COCOデータセットをダウンロードする際に、ダウンロードリンクから直接ダウンロードできませんでした。  

この記事は、wgetを利用したダウンロード方法についての備忘録です。  

![image_0.png](README_images/image_0.png)

https://cocodataset.org/\#download

なお、CocoはGoogle Cloud Platform (GCP)に格納されており、gsutil ツールを利用してダウンロードすることが推奨されています。

**https://cloud.google.com/storage/docs/gsutil?hl=ja**

# 2. Wgetを利用したCocoデータセットのダウンロード**  **

ここでは、Windowsを利用します。  

**1. Wgetをインストールする**

インストール方法については、以下のページがわかりやすかったです。

https://www.kkaneko.jp/tools/win/wget.html

**2. コマンドプロンプトにて以下のコマンドを実行する**

なお、私は1でWgetのパスは通さず、直接  

**`cd "C:\Program Files (x86)\GnuWin32\bin"`**

にてパスを移動しました。

wgetの -P オプションで保存先を指定することができます。  

以下のコマンドで訓練データやアノテーションデータをダウンロードすることができます。

`wget -P D:\ScanX\tools wget http://images.cocodataset.org/zips/train2017.zip`

`wget -P D:\ScanX\tools http://images.cocodataset.org/annotations/annotations_trainval2017.zip`

ダウンロードが完了すると、指定したとおり、D:\ScanX\toolsにデータがダウンロードできました。

![image_1.png](README_images/image_1.png)
