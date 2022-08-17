# コマンドの例
# python argparsePractice.py 10 --input_path D:\blog -a abbreviation

# helpを確認する
# python argparsePractice.py --help or python argparsePractice.py -h

# import module
import argparse

# argparseの中身の定義
parser = argparse.ArgumentParser()
parser.add_argument('firstArg1', type=float) # float, stringなどの変数の型を指定できる
parser.add_argument('--input_path', type=str, default='None', help='input path')
parser.add_argument('--value1', type=float, default=0.5, help='label path')
parser.add_argument('-a','--long_name', type=str, default='None', help='abbreviation')
# argsに、引数の値が格納される
args = parser.parse_args()

# パラメーターの確認
print('firstArg1 = '+str(args.firstArg1))
print('input_path = '+args.input_path)
print('value1 = '+str(args.value1))
print('long_name = '+args.long_name) # 省略後ではなく、正式名で参照する