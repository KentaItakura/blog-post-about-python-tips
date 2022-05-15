# PythonからPDFを画像に変換＆画像からPDFに変換する方法のメモ  
この記事では、Pythonを用いて、PDFファイルを読み込んで、画像に変換すること、さらに、画像からPDFに変換する方法について調べたのでメモとして残したいと思います。  
　ここでのスクリプトで特定のことをしたいわけではなく、Pythonを用いたPDFの読み込み、書き込みの経験がなかったので練習をしたいと思いました。大量のPDFの処理の用事などができたら、今後利活用できたらよいなと考えています。ここでの内容は、  
- PDFを画像に変換して、各種端末で見やすくする  
- 大量の画像を一気にPDF化して保存する  
といったことにつながるのではないかと考えられます。このほかにも、皆様の役に立てば幸いです。

# 1. PDFを扱うことのできるPythonライブラリーについて  
- PyPDF2  
https://www.shibutan-bloomers.com/python_library_pypdf2/2157/  
- PDFMiner  
https://liquidjumper.com/programming/python/python_pdf_import_text_pdfminer  
- pdf2image  
https://laboratory.kazuuu.net/convert-a-pdf-file-to-an-image-using-pdf2image-in-python/  
- img2pdf  
https://self-development.info/%E3%80%90python%E3%80%91%E5%86%99%E7%9C%9F%EF%BC%88%E7%94%BB%E5%83%8F%EF%BC%89%E3%82%92pdf%E5%8C%96%E3%81%99%E3%82%8Bimg2pdf%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB/  

などがあるようです。また、PyPDF2よりも、PDFMinerをおすすめする記事もありました。  
https://self-development.info/%E3%80%90python%E3%80%91pypdf2%E3%81%A7%E3%81%AF%E3%81%AA%E3%81%8Fpdfminer%E3%82%92%E4%BD%BF%E3%81%84%E3%81%BE%E3%81%97%E3%82%87%E3%81%86/  

ここでは、pdf2image, img2pdfを用いて、PDFの読み込みや画像への変換、そして、その画像を拡大してからPDFへの変換などを行っていきたいと思います。  
  
さっそく、以下に、今回用いたPythonコードを記載していきます。

# 2. Pythonコード  
## 2.1. 準備  
同じディレクトリに、`data`というフォルダを用意してください。参考のために、練習用ファイルを以下のURLにアップロードしています。  
https://github.com/KentaItakura/blog-post-about-python-tips/tree/main/pdf2img2pdf

## 2.2. モジュールの読み込み  
あらかじめ、`PIL`や`img2pdf`, `pdf2image`などのモジュールをインストールしておいてください。


```python
#from pathlib import Path
from pdf2image import convert_from_path
from PIL import Image, ImageDraw, ImageFilter
import os
import glob
import img2pdf
```

## 2.3. PDFファイルの確認


```python
# PDFから画像に変換したものを拡大するときのパラメータ。参考程度にお使いください。  
fx = 1.2
fy = 1.2

# PDFファイルのパスを参照する
pdf_data = glob.glob('./data/*.pdf')

# 一度書き出す画像はimageというフォルダ、最終的な出力はfinalOutputというフォルダに格納します。まだ作成していない場合、自動的にそのフォルダを作成します
img_path = './image'
out_path = './finalOutput'
print('==========')
print('Does the output path for img exist?')
print(os.path.exists(img_path))
# 画像を格納するフォルダがあるかどうか確認する
if os.path.exists(img_path)==False:
    os.mkdir(img_path)
    print('ouput folder for img created')

print('==========')
print('Does the output path for pdf exist?')
print(os.path.exists(out_path))
# PDFを格納するフォルダがあるかどうか確認する
if os.path.exists(out_path)==False:
    os.mkdir(out_path)
    print('ouput folder created')
```

    ==========
    Does the output path for img exist?
    True
    ==========
    Does the output path for pdf exist?
    True
    

## 2.4. convert_from_pathを用いて、PDFから画像に変換する  
`convert_from_path`の引数については以下のページをご覧ください。2.5で画像を拡大しますが、ここで、`dpi`の値を大きくすることも可能です。
https://pdf2image.readthedocs.io/en/latest/reference.html#functions


```python
for i in range(len(pdf_data)):
    print(str(i)+'-th data is being processed. Target file is '+pdf_data[i])
    # 拡張子なしのファイル名を取得する
    basename = os.path.basename(pdf_data[i])
    file_name = os.path.splitext(basename)[0]
    # PDFが2ページ以上ある場合は、single_file=Falseとする
    convert_from_path(pdf_data[i], output_folder=img_path,fmt='png',output_file=file_name,single_file=True)
    print('Done!')

print('All pdf files have been converted into images')
```

    0-th data is being processed. Target file is ./data\test1.pdf
    Done!
    1-th data is being processed. Target file is ./data\test2.pdf
    Done!
    2-th data is being processed. Target file is ./data\test3.pdf
    Done!
    All pdf files have been converted into images
    

## 2.5. 画像を拡大し、PDFに変換する


```python
dir_path = './image/'
png_data = glob.glob(os.path.join(dir_path,'*.png'))

for i in range(len(png_data)):
    print('==========')
    print(str(i)+'-th data is being processed. Target file is '+png_data[i])
    # 画像の読み込み
    img = Image.open(png_data[0])
    # リサイズ
    size = (round(img.width * fx), round(img.height * fy))
    outsize = (img2pdf.mm_to_pt(round(img.width * fx)),img2pdf.mm_to_pt(round(img.height * fy)))
    layout_fun = img2pdf.get_layout_fun(outsize)
    # 拡張子なしのファイル名を取得する
    basename = os.path.basename(png_data[i])
    file_name = os.path.splitext(basename)[0]
    print(file_name)
    file_name_pdf_out = out_path+os.path.sep+file_name+'_enlarged.pdf'
    # 出力するときのファイル名を取得する
    print('Output file name is ')
    print(file_name_pdf_out)
    
    # 書き込み
    with open(file_name_pdf_out, "wb") as f:
        f.write(img2pdf.convert(png_data[i],layout_fun=layout_fun))

print('==========')
print('Good job! All steps are finished!!')
print('==========')
```

    ==========
    0-th data is being processed. Target file is ./image\test1.png
    test1
    Output file name is 
    ./finalOutput\test1_enlarged.pdf
    ==========
    1-th data is being processed. Target file is ./image\test2.png
    test2
    Output file name is 
    ./finalOutput\test2_enlarged.pdf
    ==========
    2-th data is being processed. Target file is ./image\test3.png
    test3
    Output file name is 
    ./finalOutput\test3_enlarged.pdf
    ==========
    Good job! All steps are finished!!
    ==========
    

# 参考ページ  
冒頭で述べたページに加えて以下のページなどを参考にさせていただきました。ありがとうございました。
https://pynote.hatenablog.com/entry/pillow-resize  
https://kapibara-sos.net/archives/866


```python

```
