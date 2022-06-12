import os
from glob import glob
txtFiles = glob(os.getcwd() + "/folder1/*/*.txt", recursive = True)
print('==== file list ====')
print(txtFiles)

for i in txtFiles:
    print('==== file name ====')
    print(i)