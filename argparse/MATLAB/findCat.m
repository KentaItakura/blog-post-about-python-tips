function imgOut = findCat(img,varargin)
   defaultOpacity = 0.1;
   defaultLineWidth = 5;
   defaultShape = 'rectangle';
   expectedShapes = {'circle','rectangle','FilledRectangle'};
   
   p = inputParser;
   validScalarPosNum = @(x) isnumeric(x) && isscalar(x) && (x > 0);
   addRequired(p,'img',@ischar);
   addOptional(p,'LineWidth',defaultLineWidth,validScalarPosNum);
   addParameter(p,'Opacity',defaultOpacity,validScalarPosNum);
   addParameter(p,'shape',defaultShape,...
                 @(x) any(validatestring(x,expectedShapes)));
   parse(p,img,varargin{:});
   
   img = p.Results.img;
   LineWidth = p.Results.LineWidth;
   Opacity = p.Results.Opacity;
   ShapeName = p.Results.shape;
   
   
   I = imread(img);
   figure;imshow(I)
   rect = getrect();
   
   % 
   switch ShapeName
       case 'circle'
           centroid = [rect(1)+rect(3)/2,rect(2)+rect(4)/2,rect(3)/2];
           imgOut = insertShape(I,'Circle',centroid,'Opacity',Opacity,'LineWidth',LineWidth);
       case 'rectangle'
           imgOut = insertShape(I,'FilledRectangle',rect,'Opacity',Opacity,'LineWidth',LineWidth);
       otherwise
           print('FilledRectangle')
           imgOut = insertShape(I,'FilledRectangle',rect,'Opacity',Opacity,'LineWidth',LineWidth);
   end

   %イメージを表示します。
   figure;imshow(imgOut);
end
