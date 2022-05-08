# 名前の前をゼロなどでパディングする

数字の表記を、1234ではなく、001234のように特定の数字などで埋めたい場合があると思います。この記事では、MATLABとpythonにおけるコードについて自分用のメモとして残したいと思います。例えば、

- 123, 18, 1931...のように桁数の違う数字を含むファイル名において、00123.jpg, 00018.jpg, 01931.jpgのようにすると統一性が出る
- file1.txt, file2.txt, file10.txtを並び替えると、file1.txt, file10.txt, file2.txtという順番になる場合がある。ファイル名からゼロで埋めると数字の大きさ（小ささ）の順に並び変えられる。

といった場合に有効であると考えられます。

# MATLAB

```matlab
sprintf('%07d', 1234)
```

とすれば、0001234という値（char）が返されます。

[How can i start a matlab for loop variable with 001 instead of 1?](https://jp.mathworks.com/matlabcentral/answers/249084-how-can-i-start-a-matlab-for-loop-variable-with-001-instead-of-1)

並び替えをうまく行いたい場合は、`sort_nat`を使うこともできます。

[sort_nat: Natural Order Sort](https://jp.mathworks.com/matlabcentral/fileexchange/10959-sort_nat-natural-order-sort)

# python

```matlab
v = '1234'
v.zfill(7)
```

のように、`zfill`を用いるとよいです。vは文字列であることに注意する必要があります。他にも複数方法が存在するようです。以下のページが参考になりました。

[Pythonで文字列・数値をゼロ埋め（ゼロパディング） | note.nkmk.me](https://note.nkmk.me/python-zero-padding/)