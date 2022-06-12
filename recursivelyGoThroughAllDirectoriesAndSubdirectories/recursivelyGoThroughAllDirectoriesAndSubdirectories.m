%% サブフォルダも含めてファイルのリストを作成する
clear;clc;close all
% サブフォルダも含め、txtデータを集める
txtList = dir(fullfile(pwd, 'folder1\**\*.txt'));  %get list of files and folders in any subfolder
% 拡張子を含めず、あらゆるファイルを取得する
filelist = dir(fullfile(pwd, 'folder1\**\*'));  
filelist = filelist(~[filelist.isdir]);  % フォルダの情報を削除する

