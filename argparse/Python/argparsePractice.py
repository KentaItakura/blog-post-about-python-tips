parser = argparse.ArgumentParser()
parser.add_argument('arg1', type=float')
parser.add_argument('--input_path', type=str, default='None', help='input path')
parser.add_argument('--label_path', type=str, default='None', help='label path')
parser.add_argument('--output_path', type=str, default='None', help='output path')
# parser.add_argument('--model_path', type=str, default='./results/Log_2021-02-28_16-17-18', help='pretrained model path')
args = parser.parse_args()

# Specify input path
print('arg1='+args.arg1)
print('arg2='+args.input_path)
print('arg3='+args.arg3)
print('arg4='+args.arg4)