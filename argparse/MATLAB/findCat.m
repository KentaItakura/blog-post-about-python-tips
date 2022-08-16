function imgOut = findCat(img,varargin)
   % デフォルト（既定）の値の設定
   defaultOpacity = 0.1;
   defaultLineWidth = 5;
   defaultShape = 'rectangle';
   % 選択肢を設定することもできる
   expectedShapes = {'circle','rectangle','FilledRectangle'};
   
   % inputParser変数の作成
   p = inputParser;
   % 変数が数値であり、かつ0より大きいことを確認する関数を定義する
   validScalarPosNum = @(x) isnumeric(x) && isscalar(x) && (x > 0);
   % 画像のパス @ischarにて、文字型であることを確認する
   addRequired(p,'img',@ischar);
   addOptional(p,'LineWidth',defaultLineWidth,validScalarPosNum);
   addParameter(p,'Opacity',defaultOpacity,validScalarPosNum);
   addParameter(p,'shape',defaultShape,@(x) any(validatestring(x,expectedShapes)));
   parse(p,img,varargin{:});
   % 各パラメーターを変数に格納する
   img = p.Results.img;
   LineWidth = p.Results.LineWidth;
   Opacity = p.Results.Opacity;
   ShapeName = p.Results.shape;
   
   % 画像の読み込みと表示
   I = imread(img);
   figure;imshow(I)
   % 図の上で囲む範囲を指定する
   rect = getrect();
   title('図の上で囲む範囲を指定してください')
   
   % 挿入する図形の種類に応じて、処理をスイッチする
   switch ShapeName
       case 'circle'
           % 描く円の中心と半径を定義する
           centroid = [rect(1)+rect(3)/2,rect(2)+rect(4)/2,rect(3)/2];
           % 円の挿入
           imgOut = insertShape(I,'Circle',centroid,'Opacity',Opacity,'LineWidth',LineWidth);
       case 'rectangle'
           % 長方形の挿入
           imgOut = insertShape(I,'FilledRectangle',rect,'Opacity',Opacity,'LineWidth',LineWidth);
       otherwise
           % 色が塗られた長方形の挿入
           print('FilledRectangle')
           imgOut = insertShape(I,'FilledRectangle',rect,'Opacity',Opacity,'LineWidth',LineWidth);
   end

   %イメージを表示
   figure;imshow(imgOut);

end
